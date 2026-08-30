# Fix CMake Sync Error: Missing QT_HOST_PATH

The Gradle sync is failing because CMake requires `QT_HOST_PATH` to be defined for Android cross-compilation. This path points to the host Qt installation (e.g., MinGW on Windows) used for build tools like `moc`, `rcc`, and `uic`.

## Proposed Changes

### Build Configuration

#### [MODIFY] [build.gradle](file:///C:/Project/qgroundcontrol-master/build.gradle)

- Define `qtHostDir` pointing to the host Qt installation.
- Allow `qtAndroidDir` and `qtHostDir` to be overridden by environment variables (`QT_TARGET_ROOT_DIR` and `QT_HOST_PATH`).
- Pass `QT_HOST_PATH` and `QT_TARGET_ROOT_DIR` as arguments to the `externalNativeBuild.cmake` block.

## Verification Plan

### Manual Verification
- Trigger a Gradle sync in Android Studio (or run `./gradlew :prepareKotlinBuildScriptModel` as the user did) and verify that the CMake configuration completes successfully.
