# Update NDK and Optimize CMake Configuration

This plan updates the project to use NDK `27.2.12479018` to resolve the `[CXX5304]` error and adds optimization flags to speed up the CMake configuration process.

## Proposed Changes

### [build.gradle](file:///C:/Project/qgroundcontrol-master/build.gradle)

#### [MODIFY] [build.gradle](file:///C:/Project/qgroundcontrol-master/build.gradle)
- Update `ndkVersion` and `ndkDir` to `27.2.12479018`.
- Add `-DQGC_BUILD_TESTING=OFF` to disable slow unit test processing.
- Add `-DQGC_VERBOSE_CONFIGURE=ON` to provide detailed logs during configuration.
- Add `-DQGC_USE_CACHE=ON` to ensure compiler caching is enabled.

## Verification Plan

### Automated Tests
- Run `gradle sync` (Gradle Sync) to verify the new NDK version is recognized and the [CXX5304] error is resolved.
- Check the **Build** output tab in Android Studio to see verbose CMake logs.
