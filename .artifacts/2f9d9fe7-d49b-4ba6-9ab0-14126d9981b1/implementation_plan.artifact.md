# Resolve JNI Function Issues and Code Quality in QGCActivity

The goal is to fix "Cannot resolve corresponding JNI function" errors in `QGCActivity.java` by switching to static JNI naming conventions, and to address Java code quality issues (NPE warning and redundant loop condition).

## User Review Required

> [!IMPORTANT]
> This change switches several JNI functions from dynamic registration (`RegisterNatives`) to static naming (`Java_...`). This improves IDE support and discovery but changes the C++ function signatures to include the full package name.

## Proposed Changes

### Android Layer

#### [MODIFY] [QGCActivity.java](file:///C:/Project/qgroundcontrol-master/android/src/org/mavlink/qgroundcontrol/QGCActivity.java)
- Add null check for `InputStream` in `copyFileToDestination` to prevent potential NPE.
- Simplify `resolveDestFile` loop condition to avoid redundant "always true" comparison.

#### [MODIFY] [AndroidInit.cc](file:///C:/Project/qgroundcontrol-master/src/Android/AndroidInit.cc)
- Rename `jniInit` to `Java_org_mavlink_qgroundcontrol_QGCActivity_nativeInit` and mark as `extern "C" JNIEXPORT`.
- Remove `nativeInit` from dynamic registration in `jniSetNativeMethods`.

#### [MODIFY] [AndroidInterface.cc](file:///C:/Project/qgroundcontrol-master/src/Android/AndroidInterface.cc)
- Rename JNI implementation functions to use the `Java_org_mavlink_qgroundcontrol_QGCActivity_...` naming convention.
- Mark them as `extern "C" JNIEXPORT`.
- Remove them from dynamic registration in `setNativeMethods`.

## Verification Plan

### Automated Tests
- Build the project for Android to ensure JNI signatures are correct and no linking errors occur.
- Run unit tests if applicable (though JNI changes are best verified by deployment).

### Manual Verification
- Deploy to an Android device/emulator.
- Verify that logging (`qgcLogDebug`, `qgcLogWarning`) still works.
- Verify that storage permissions and file import still function correctly.
