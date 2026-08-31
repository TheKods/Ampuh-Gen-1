# Resolve JNI Warnings and Java Lint Issues in QGCActivity

The goal is to fix the JNI function resolution errors in `QGCActivity.java` and address several Java lint warnings/errors in the same file.

## User Review Required

> [!IMPORTANT]
> The JNI methods in `QGCActivity.java` are currently registered dynamically using `RegisterNatives`. This plan proposes switching to the standard static JNI naming convention (`Java_package_Class_method`) to ensure Android Studio can resolve the functions, which is the primary reason for the "Cannot resolve corresponding JNI function" errors.

## Proposed Changes

### Android JNI (C++)

#### [MODIFY] [AndroidInit.cc](file:///C:/Project/qgroundcontrol-master/src/Android/AndroidInit.cc)
- Change `jniInit` to use the static JNI naming convention: `Java_org_mavlink_qgroundcontrol_QGCActivity_nativeInit`.
- Remove dynamic registration of `nativeInit` in `jniSetNativeMethods`.

#### [MODIFY] [AndroidInterface.cc](file:///C:/Project/qgroundcontrol-master/src/Android/AndroidInterface.cc)
- Change `jniLogDebug`, `jniLogWarning`, `jniStoragePermissionsResult`, and `jniOnImportResult` to use static JNI naming:
    - `Java_org_mavlink_qgroundcontrol_QGCActivity_qgcLogDebug`
    - `Java_org_mavlink_qgroundcontrol_QGCActivity_qgcLogWarning`
    - `Java_org_mavlink_qgroundcontrol_QGCActivity_nativeStoragePermissionsResult`
    - `Java_org_mavlink_qgroundcontrol_QGCActivity_onImportResult`
- Remove dynamic registration in `setNativeMethods`.

### Android Java

#### [MODIFY] [QGCActivity.java](file:///C:/Project/qgroundcontrol-master/android/src/org/mavlink/qgroundcontrol/QGCActivity.java)
- Add null check for `InputStream` in `copyFileToDestination` to prevent potential `NullPointerException`.
- Change `i <= Integer.MAX_VALUE` to `i < Integer.MAX_VALUE` in `resolveDestFile` to satisfy the "always true" lint warning.
- Fix any identified typos if possible (though "QGCActivity" might just need a dictionary entry, I'll check for actual misspellings).

## Verification Plan

### Automated Tests
- Build the project to ensure JNI signatures match and the app compiles.
- Run `just lint` to verify Java and C++ changes.

### Manual Verification
- Deploy to an Android device/emulator.
- Verify that "nativeInit" is called (check logs).
- Verify that logging from Java to C++ works (`qgcLogDebug`).
- Verify that storage permissions and file import still work, as these rely on the JNI bridge.
