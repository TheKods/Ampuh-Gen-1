# Fix CMake Version Mismatch

The project sync is failing because QGroundControl requires CMake 3.25 or higher, but the Android build configuration is explicitly set to use CMake 3.22.1.

## Proposed Changes

### Build Configuration

#### [MODIFY] [build.gradle](file:///C:/Project/qgroundcontrol-master/android/build.gradle)
Update the CMake version in the `externalNativeBuild` block from `3.22.1` to `3.25.1`.

#### [MODIFY] [CMakeLists.txt](file:///C:/Project/qgroundcontrol-master/CMakeLists.txt)
Update `cmake_minimum_required` from `3.22` to `3.25` to maintain consistency with the actual project requirements as specified in `.github/build-config.json`.

## Verification Plan

### Automated Tests
- Run `./gradlew :prepareKotlinBuildScriptModel` to verify that the sync error is resolved.
- Run `just configure` to ensure the root CMake configuration still works as expected.
