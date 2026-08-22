#!/usr/bin/env python3
"""Run QGroundControl application with proper runtime environment.

Usage:
    ./tools/run.py                      # Run default Debug build
    ./tools/run.py --release            # Run Release build
    ./tools/run.py --build-dir build    # Specify build directory
    ./tools/run.py -- ...               # Pass arguments to application
"""

from __future__ import annotations

import argparse
import os
import subprocess
import sys
from pathlib import Path

from _bootstrap import ensure_tools_dir

ensure_tools_dir(__file__)

from common.logging import log_error, log_info
from common.platform import is_macos, is_windows
from configure import find_qt_cmake


def find_app_binary(build_dir: Path, build_type: str = "Debug") -> Path | None:
    """Find application executable in build directory."""
    if is_macos():
        candidates = [
            build_dir / build_type / "AmpuhGen1.app" / "Contents" / "MacOS" / "AmpuhGen1",
            build_dir / "AmpuhGen1.app" / "Contents" / "MacOS" / "AmpuhGen1",
            build_dir / build_type / "QGroundControl.app" / "Contents" / "MacOS" / "QGroundControl",
            build_dir / "QGroundControl.app" / "Contents" / "MacOS" / "QGroundControl",
        ]
    elif is_windows():
        candidates = [
            build_dir / build_type / "AmpuhGen1.exe",
            build_dir / "AmpuhGen1.exe",
            build_dir / build_type / "QGroundControl.exe",
            build_dir / "QGroundControl.exe",
        ]
    else:
        candidates = [
            build_dir / build_type / "AmpuhGen1",
            build_dir / "AmpuhGen1",
            build_dir / build_type / "QGroundControl",
            build_dir / "QGroundControl",
        ]

    for candidate in candidates:
        if candidate.is_file():
            return candidate

    if is_windows():
        for exe in build_dir.glob(f"{build_type}/*.exe"):
            if "Test" not in exe.name:
                return exe
        for exe in build_dir.glob("*.exe"):
            if "Test" not in exe.name:
                return exe
    return None


def get_runtime_env(build_dir: Path, qt_root: Path | None = None) -> dict[str, str]:
    """Configure runtime environment with Qt and QML plugin paths."""
    env = os.environ.copy()

    qt_cmake = find_qt_cmake(qt_root)
    qt_bin_dir: Path | None = None
    qt_plugins_dir: Path | None = None
    qt_qml_dir: Path | None = None

    if qt_cmake:
        qt_root_dir = qt_cmake.parent.parent.resolve()
        qt_bin_dir = qt_root_dir / "bin"
        qt_plugins_dir = qt_root_dir / "plugins"
        qt_qml_dir = qt_root_dir / "qml"
    elif "QT_ROOT_DIR" in env:
        qt_root_dir = Path(env["QT_ROOT_DIR"]).resolve()
        qt_bin_dir = qt_root_dir / "bin"
        qt_plugins_dir = qt_root_dir / "plugins"
        qt_qml_dir = qt_root_dir / "qml"
    else:
        for default_root in (Path("C:/Qt/6.8.2/msvc2022_64"), Path.home() / "Qt" / "6.8.2" / "msvc2022_64"):
            if default_root.exists():
                qt_bin_dir = default_root / "bin"
                qt_plugins_dir = default_root / "plugins"
                qt_qml_dir = default_root / "qml"
                break

    if is_windows():
        current_path = env.get("PATH", "")
        extra_paths: list[str] = []
        if qt_bin_dir and qt_bin_dir.exists():
            extra_paths.append(str(qt_bin_dir))
        for p in extra_paths:
            if p.lower() not in current_path.lower():
                current_path = f"{p};{current_path}"
        env["PATH"] = current_path

    if qt_plugins_dir and qt_plugins_dir.exists():
        env["QT_PLUGIN_PATH"] = str(qt_plugins_dir)

    qml_import_paths = [str(build_dir.resolve() / "qml")]
    if qt_qml_dir and qt_qml_dir.exists():
        qml_import_paths.append(str(qt_qml_dir))

    sep = ";" if is_windows() else ":"
    env["QML2_IMPORT_PATH"] = sep.join(qml_import_paths)
    return env


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "-B", "--build-dir", type=Path, default=Path("build"), help="Build directory (default: build)"
    )
    parser.add_argument(
        "-t", "--build-type", default=None, help="Build type: Debug, Release, RelWithDebInfo (default: auto/Debug)"
    )
    parser.add_argument("--release", action="store_true", help="Run Release build")
    parser.add_argument("--qt-root", type=Path, help="Explicit Qt installation root directory")
    parser.add_argument("app_args", nargs=argparse.REMAINDER, help="Arguments forwarded to application")

    args = parser.parse_args(argv)

    build_type = "Release" if args.release else (args.build_type or os.environ.get("BUILD_TYPE", "Debug"))
    build_dir = args.build_dir

    binary = find_app_binary(build_dir, build_type)
    if not binary:
        alt_type = "Release" if build_type == "Debug" else "Debug"
        binary = find_app_binary(build_dir, alt_type)

    if not binary or not binary.exists():
        log_error(f"Application executable not found in {build_dir}. Run 'just build' first.")
        return 1

    env = get_runtime_env(build_dir, args.qt_root)

    app_args = list(args.app_args)
    if app_args and app_args[0] == "--":
        app_args = app_args[1:]

    cmd = [str(binary), *app_args]
    log_info(f"Running: {binary}")

    try:
        # Run application with Qt environment
        res = subprocess.run(cmd, env=env)
        return res.returncode
    except KeyboardInterrupt:
        return 0


if __name__ == "__main__":
    sys.exit(main())
