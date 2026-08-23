#!/usr/bin/env python3
"""Configure QGroundControl CMake build.

Usage:
    ./tools/configure.py                     # Default Debug build
    ./tools/configure.py --release           # Release build
    ./tools/configure.py --testing           # With unit tests
    ./tools/configure.py --coverage          # With coverage
    ./tools/configure.py --unity             # Unity build (faster)
    ./tools/configure.py --qt-root ~/Qt/6.8.0/gcc_64  # Explicit Qt

Environment:
    QT_ROOT_DIR - Qt installation (auto-detected if not set)
    CMAKE_GENERATOR - Generator (default: Ninja)
"""

from __future__ import annotations

import argparse
import os
import re
import shutil
import subprocess
import sys
from dataclasses import dataclass, field
from glob import glob
from pathlib import Path

from _bootstrap import ensure_tools_dir

ensure_tools_dir(__file__)

from common.file_traversal import find_repo_root
from common.gh_actions import write_github_output
from common.platform import host_arch, is_macos, is_windows


@dataclass
class CMakeConfig:
    """CMake invocation options for configure.py."""

    source_dir: Path = field(default_factory=lambda: Path("."))
    build_dir: Path = field(default_factory=lambda: Path("build"))
    build_type: str = "Debug"
    generator: str = "Ninja"
    testing: bool = False
    coverage: bool = False
    preset: str | None = None
    use_preset: bool = True
    stable: bool = False
    unity_build: bool = False
    unity_batch_size: int = 16
    use_qt_cmake: bool = True
    qt_root: Path | None = None
    extra_args: list[str] = field(default_factory=list)


LOCAL_PRESETS = {
    "Debug": "default",
    "Release": "default-release",
    "RelWithDebInfo": "default-relwithdebinfo",
    "MinSizeRel": "default-minsizerel",
}


def select_preset(config: CMakeConfig) -> str | None:
    """Select the canonical local preset for a configuration."""
    if not config.use_preset:
        return None
    if config.preset:
        return config.preset
    if config.generator != "Ninja":
        return None
    if config.coverage:
        if not sys.platform.startswith("linux"):
            raise ValueError("Coverage builds require Linux; use --no-preset for a custom setup")
        return "Linux-coverage"
    return LOCAL_PRESETS[config.build_type]


def parse_version(path: Path) -> tuple[int, ...]:
    """Extract version tuple from Qt path for sorting."""
    # Match patterns like 6.8.0, 6.10.1, etc.
    match = re.search(r"[\\/](\d+)\.(\d+)\.(\d+)[\\/]", str(path))
    if match:
        return tuple(int(x) for x in match.groups())
    return (0, 0, 0)


def find_qt_cmake(qt_root: Path | None = None) -> Path | None:
    """Find qt-cmake executable, preferring newest version.

    Search order:
    1. Explicit qt_root parameter
    2. QT_ROOT_DIR environment variable
    3. Common installation paths (newest version first)
    """
    # On Windows, prefer .bat variant since qt-cmake may be a bash script
    suffixes = [".bat", ""] if is_windows() else [""]

    # Check explicit qt_root
    if qt_root:
        for suffix in suffixes:
            qt_cmake = qt_root / "bin" / f"qt-cmake{suffix}"
            if qt_cmake.exists() and os.access(qt_cmake, os.X_OK):
                return qt_cmake

    # Check QT_ROOT_DIR environment variable
    env_root = os.environ.get("QT_ROOT_DIR")
    if env_root:
        for suffix in suffixes:
            qt_cmake = Path(env_root) / "bin" / f"qt-cmake{suffix}"
            if qt_cmake.exists() and os.access(qt_cmake, os.X_OK):
                return qt_cmake

    patterns: list[Path]
    if is_windows():
        msvc_kit = "msvc*_arm64" if host_arch() == "aarch64" else "msvc*_64"
        patterns = [
            base / "*" / msvc_kit / "bin" / "qt-cmake.bat"
            for base in (Path("C:/Qt"), Path.home() / "Qt")
        ]
    elif is_macos():
        patterns = [
            base / "*" / kit / "bin" / "qt-cmake"
            for base in (Path.home() / "Qt", Path("/Applications/Qt"))
            for kit in ("macos", "clang_64")
        ]
    else:
        gcc_kit = "gcc_arm64" if host_arch() == "aarch64" else "gcc_64"
        patterns = [
            Path.home() / "Qt" / "*" / gcc_kit / "bin" / "qt-cmake",
            Path("/opt/Qt") / "*" / gcc_kit / "bin" / "qt-cmake",
            Path("/usr/lib/qt6/bin/qt-cmake"),
        ]

    for pattern in patterns:
        if "*" in str(pattern):
            matches = [Path(match) for match in glob(str(pattern))]
            matches.sort(key=parse_version, reverse=True)
            for match in matches:
                if match.exists() and os.access(match, os.X_OK):
                    return match
        else:
            if pattern.exists() and os.access(pattern, os.X_OK):
                return pattern

    return None


def configure(config: CMakeConfig) -> int:
    """Run CMake configuration."""
    preset = select_preset(config)

    # Determine cmake command
    if config.use_qt_cmake:
        qt_cmake = find_qt_cmake(config.qt_root)
        if qt_cmake:
            cmake_cmd = str(qt_cmake)
            print(f"Using: {cmake_cmd}")
        else:
            print("Error: qt-cmake not found; pass --no-qt-cmake to use cmake", file=sys.stderr)
            return 1
    else:
        cmake_cmd = "cmake"

    if preset:
        args = [
            cmake_cmd,
            "--preset",
            preset,
            "-S",
            str(config.source_dir),
            "-B",
            str(config.build_dir),
        ]
    else:
        args = [
            cmake_cmd,
            "-S",
            str(config.source_dir),
            "-B",
            str(config.build_dir),
            "-G",
            config.generator,
            f"-DCMAKE_BUILD_TYPE={config.build_type}",
        ]

    # Feature flags
    if config.testing:
        args.append("-DQGC_BUILD_TESTING=ON")
    elif not preset:
        args.append("-DQGC_BUILD_TESTING=OFF")

    if config.coverage and preset != "Linux-coverage":
        args.append("-DQGC_ENABLE_COVERAGE=ON")

    if config.stable:
        args.append("-DQGC_STABLE_BUILD=ON")

    if config.unity_build:
        args.append("-DCMAKE_UNITY_BUILD=ON")
        args.append(f"-DCMAKE_UNITY_BUILD_BATCH_SIZE={config.unity_batch_size}")

    # Extra arguments
    args.extend(config.extra_args)

    if preset:
        print(f"Preset: {preset}")
    else:
        print(f"Build type: {config.build_type}")
    print(f"Build dir: {config.build_dir}")

    # Run cmake
    env = os.environ.copy()
    if is_windows():
        # Auto-load MSVC environment if vcvars64.bat exists
        vcvars_candidates = [
            Path(r"C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\VC\Auxiliary\Build\vcvars64.bat"),
            Path(r"C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvars64.bat"),
            Path(r"C:\Program Files\Microsoft Visual Studio\2022\Professional\VC\Auxiliary\Build\vcvars64.bat"),
            Path(r"C:\Program Files\Microsoft Visual Studio\2022\Enterprise\VC\Auxiliary\Build\vcvars64.bat"),
            Path(r"C:\Program Files (x86)\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvars64.bat"),
        ]
        for vcvars in vcvars_candidates:
            if vcvars.exists():
                try:
                    output = subprocess.check_output(f'"{vcvars}" >nul 2>&1 && set', shell=True, text=True)
                    for line in output.splitlines():
                        if "=" in line:
                            k, v = line.split("=", 1)
                            env[k] = v
                    break
                except Exception:
                    pass

        extra_paths = [
            r"C:\Program Files\CMake\bin",
            os.path.expandvars(r"%LOCALAPPDATA%\Microsoft\WinGet\Links"),
            r"C:\Program Files\Git\cmd",
        ]
        if config.use_qt_cmake and qt_cmake:
            extra_paths.append(str(qt_cmake.parent.resolve()))
        current_path = env.get("PATH", "")
        for p in extra_paths:
            if os.path.exists(p) and p.lower() not in current_path.lower():
                current_path = f"{p};{current_path}"
        env["PATH"] = current_path

        # Find and pass ml64 assembler matching active toolset
        ml64 = None
        if "VCToolsInstallDir" in env:
            for arch in ("Hostx64\\x64", "HostX64\\x64"):
                vctools_ml64 = Path(env["VCToolsInstallDir"]) / "bin" / arch / "ml64.exe"
                if vctools_ml64.exists():
                    ml64 = str(vctools_ml64)
                    break
        if not ml64:
            ml64 = shutil.which("ml64.exe", path=env.get("PATH"))
        if not ml64:
            candidates = glob(r"C:\Program Files (x86)\Microsoft Visual Studio\2022\*\VC\Tools\MSVC\*\bin\Hostx64\x64\ml64.exe")
            candidates += glob(r"C:\Program Files\Microsoft Visual Studio\2022\*\VC\Tools\MSVC\*\bin\Hostx64\x64\ml64.exe")
            candidates.sort(key=parse_version, reverse=True)
            for candidate in candidates:
                if os.path.exists(candidate):
                    ml64 = candidate
                    break
        if ml64:
            ml64_posix = Path(ml64).as_posix()
            args.append(f"-DCMAKE_ASM_COMPILER={ml64_posix}")
            args.append(f"-DCMAKE_ASM_MASM_COMPILER={ml64_posix}")
            env["ASM"] = str(ml64)

    if config.use_qt_cmake and qt_cmake:
        qt_root_dir = qt_cmake.parent.parent.resolve()
        env["QT_ROOT_DIR"] = str(qt_root_dir)
        args.append(f"-DCMAKE_PREFIX_PATH={qt_root_dir.as_posix()}")
    elif config.qt_root:
        env["QT_ROOT_DIR"] = str(config.qt_root.resolve())
        args.append(f"-DCMAKE_PREFIX_PATH={config.qt_root.resolve().as_posix()}")
    result = subprocess.run(args, env=env)

    if result.returncode != 0:
        return result.returncode

    write_github_output({"build_dir": str(config.build_dir.resolve())})

    print(f"Configured: {config.build_dir}")
    return 0


def parse_args() -> argparse.Namespace:
    """Parse command line arguments."""
    parser = argparse.ArgumentParser(
        description="Configure QGroundControl CMake build",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Environment:
  QT_ROOT_DIR         Qt installation (auto-detected if not set)
  CMAKE_GENERATOR     Default generator

Examples:
  %(prog)s --release --testing
  %(prog)s -B build-debug --debug
  %(prog)s --preset Linux-debug
  %(prog)s --qt-root ~/Qt/6.8.0/gcc_64 --release
""",
    )

    parser.add_argument(
        "-S",
        "--source-dir",
        type=Path,
        default=Path("."),
        help="Source directory (default: current directory)",
    )
    parser.add_argument(
        "-B",
        "--build-dir",
        type=Path,
        default=Path("build"),
        help="Build directory (default: build)",
    )
    parser.add_argument(
        "-t",
        "--build-type",
        choices=["Debug", "Release", "RelWithDebInfo", "MinSizeRel"],
        default="Debug",
        help="Build type (default: Debug)",
    )
    parser.add_argument(
        "-G",
        "--generator",
        default=os.environ.get("CMAKE_GENERATOR", "Ninja"),
        help="CMake generator (default: Ninja)",
    )
    parser.add_argument(
        "--release",
        action="store_const",
        const="Release",
        dest="build_type",
        help="Shorthand for --build-type Release",
    )
    parser.add_argument(
        "--debug",
        action="store_const",
        const="Debug",
        dest="build_type",
        help="Shorthand for --build-type Debug",
    )
    parser.add_argument(
        "--testing",
        action="store_true",
        help="Enable unit tests (QGC_BUILD_TESTING=ON)",
    )
    parser.add_argument(
        "--coverage",
        action="store_true",
        help="Enable code coverage (QGC_ENABLE_COVERAGE=ON)",
    )
    preset_group = parser.add_mutually_exclusive_group()
    preset_group.add_argument(
        "--preset",
        help="CMake configure preset (default: matching default* preset)",
    )
    preset_group.add_argument(
        "--no-preset",
        action="store_true",
        help="Use legacy command-line configuration for an unsupported custom setup",
    )
    parser.add_argument(
        "--stable",
        action="store_true",
        help="Build as stable release (QGC_STABLE_BUILD=ON)",
    )
    parser.add_argument(
        "--unity",
        action="store_true",
        help="Enable unity build (faster compilation)",
    )
    parser.add_argument(
        "--unity-batch",
        type=int,
        default=16,
        metavar="SIZE",
        help="Unity build batch size (default: 16)",
    )
    parser.add_argument(
        "--qt-root",
        type=Path,
        help="Qt installation directory",
    )
    parser.add_argument(
        "--no-qt-cmake",
        action="store_true",
        help="Use cmake instead of qt-cmake",
    )
    parser.add_argument(
        "extra_args",
        nargs="*",
        help="Additional CMake arguments",
    )

    return parser.parse_args()


def main() -> int:
    """Main entry point."""
    args = parse_args()

    # Default source dir to repo root when run from tools/
    source_dir = args.source_dir
    if source_dir == Path(".") and Path(__file__).parent.name == "tools":
        source_dir = find_repo_root(Path(__file__))

    config = CMakeConfig(
        source_dir=source_dir.resolve(),
        build_dir=args.build_dir,
        build_type=args.build_type or "Debug",
        generator=args.generator,
        testing=args.testing,
        coverage=args.coverage,
        preset=args.preset,
        use_preset=not args.no_preset,
        stable=args.stable,
        unity_build=args.unity,
        unity_batch_size=args.unity_batch,
        use_qt_cmake=not args.no_qt_cmake,
        qt_root=args.qt_root,
        extra_args=args.extra_args,
    )

    return configure(config)


if __name__ == "__main__":
    sys.exit(main())
