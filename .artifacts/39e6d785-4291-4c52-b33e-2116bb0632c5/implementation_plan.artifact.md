# Fix Gradle Sync Error: Missing Qt Properties

The project is failing to sync in Android Studio because several properties required by `android/build.gradle` (like `qtGradlePluginType`, `androidPackageName`, etc.) are not defined in `gradle.properties`. These properties are typically injected by Qt's deployment tools (`androiddeployqt`) during a full build, but are missing when the project is opened directly in Android Studio from the source tree.

## Proposed Changes

I will modify `android/build.gradle` to provide default values for these properties if they are not already defined. This will allow the project to sync successfully in Android Studio while maintaining compatibility with the Qt deployment process.

### [Component Name]

#### [MODIFY] [build.gradle](file:///C:/Project/qgroundcontrol-master/android/build.gradle)

Add a block at the top of the file to initialize these properties with sane defaults if they are missing.

```gradle
// Initialize Qt-related properties with defaults if they are not provided (e.g. when syncing in Android Studio)
def getExtProperty = { name, defaultValue ->
    return project.hasProperty(name) ? project.getProperty(name) : defaultValue
}

ext.qtGradlePluginType = getExtProperty('qtGradlePluginType', 'com.android.application')
ext.androidPackageName = getExtProperty('androidPackageName', 'org.mavlink.qgroundcontrol')
ext.androidCompileSdkVersion = getExtProperty('androidCompileSdkVersion', 34).toInteger()
ext.androidBuildToolsVersion = getExtProperty('androidBuildToolsVersion', '34.0.0')
ext.androidNdkVersion = getExtProperty('androidNdkVersion', '30.0.15729638')
ext.qtAndroidDir = getExtProperty('qtAndroidDir', 'C:/Qt/6.11.2/android_arm64_v8a')
ext.qtMinSdkVersion = getExtProperty('qtMinSdkVersion', 26)
ext.qtTargetSdkVersion = getExtProperty('qtTargetSdkVersion', 34)
ext.qtTargetAbiList = getExtProperty('qtTargetAbiList', 'arm64-v8a')
ext.legacyPackaging = getExtProperty('legacyPackaging', true).toBoolean()
```

## Verification Plan

### Manual Verification
- The user should attempt to sync the project in Android Studio after the changes are applied.
- The "Could not get unknown property 'qtGradlePluginType'" error should no longer occur.
