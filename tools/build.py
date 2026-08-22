#!/usr/bin/env python3
"""
Wrapper for cmake --build that automatically loads the MSVC environment on Windows.
"""

from __future__ import annotations

import os
import shutil
import subprocess
import sys
from pathlib import Path

def get_build_env() -> dict[str, str]:
    env = os.environ.copy()
    if sys.platform == "win32":
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
            r"C:\Qt\6.8.2\msvc2022_64\bin",
        ]
        current_path = env.get("PATH", "")
        for p in extra_paths:
            if os.path.exists(p) and p.lower() not in current_path.lower():
                current_path = f"{p};{current_path}"
        env["PATH"] = current_path
    return env

def main() -> int:
    env = get_build_env()
    cmake_bin = shutil.which("cmake.exe", path=env.get("PATH")) or "cmake"
    cmd = [cmake_bin, "--build"] + sys.argv[1:]
    res = subprocess.run(cmd, env=env)
    return res.returncode

if __name__ == "__main__":
    sys.exit(main())
