# Fix Qt Path Resolution in build.gradle

The build is failing because `build.gradle` uses hardcoded paths for Qt (`C:/Qt/6.11.2/...`) which do not exist on the user's machine. I will implement a more flexible resolution strategy that supports `local.properties` and local project-relative paths.

## User Review Required

> [!IMPORTANT]
> Since Qt is not yet installed on your machine, you will need to install it before the project can sync successfully. I will provide the commands to automate this installation after updating the build scripts.

## Proposed Changes

### Build System

#### [MODIFY] [build.gradle](file:///C:/Project/qgroundcontrol-master/build.gradle)
Update the Qt path resolution logic to:
1. Check `local.properties` for `qt.target.root.dir` and `qt.host.path`.
2. Check environment variables.
3. Check for a project-local `.qt` directory (standard for this project's setup scripts).
4. Provide a helpful error message if Qt is not found instead of failing with a cryptic CMake error.

## Verification Plan

### Manual Verification
1. I will check if `build.gradle` correctly reads from a mock `local.properties` (I'll test this in a scratch script if possible, or just rely on the logic).
2. I will provide the user with the command to install Qt and verify that the paths resolve correctly once installed.
