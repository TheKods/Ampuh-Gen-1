#include "AndroidInterface.h"

#include <jni.h>
#include <QAndroidScreen.h>
#include <QtAndroidHelpers/QAndroidPartialWakeLocker.h>
#include <QtAndroidHelpers/QAndroidWiFiLocker.h>
#include <QCoreApplication>
#include <QDir>
#include <QFileInfo>
#include <QJniEnvironment>
#include <QJniObject>
#include <QMetaObject>
#include <QSharedPointer>
#include <QStandardPaths>

#include "AppSettings.h"
#include "QGCApplication.h"
#include "QGCLoggingCategory.h"
#include "SettingsFact.h"
#include "SettingsManager.h"

QGC_LOGGING_CATEGORY(AndroidInterfaceLog, "Android.AndroidInterface") // NOLINT

namespace AndroidInterface {

struct JniMethodCache
{
    jmethodID checkStoragePermissions = nullptr;
    jmethodID getSDCardPath = nullptr;
    jmethodID openFileImportDialog = nullptr;
};

static JniMethodCache s_methods;                        // NOLINT
static bool           s_methodsCached = false;          // NOLINT
static QMutex         s_cacheLock;                      // NOLINT
static jclass         s_activityClass = nullptr;        // NOLINT

static std::function<void(const QString&)> s_importCallback; // NOLINT

void jniStoragePermissionsResult(jboolean granted)
{
    if (!qgcApp()) {
        return;
    }

    if (!granted) {
        qCWarning(AndroidInterfaceLog) << "Storage permission request denied; disabling save to SD card";

        (void)QMetaObject::invokeMethod(
            qgcApp(),
            []() {
                SettingsManager* const settingsManager = SettingsManager::instance();
                if (!settingsManager) {
                    return;
                }

                AppSettings* const appSettings = settingsManager->appSettings();
                if (!appSettings) {
                    return;
                }

                if (!appSettings->androidDontSaveToSDCard()->rawValue().toBool()) {
                    appSettings->androidDontSaveToSDCard()->setRawValue(true);
                }
            },
            Qt::QueuedConnection);
        return;
    }

    (void)QMetaObject::invokeMethod(
        qgcApp(),
        []() {
            SettingsManager* const settingsManager = SettingsManager::instance();
            if (!settingsManager) {
                return;
            }

            AppSettings* const appSettings = settingsManager->appSettings();
            if (!appSettings || appSettings->androidDontSaveToSDCard()->rawValue().toBool()) {
                return;
            }

            SettingsFact* const savePathFact = qobject_cast<SettingsFact*>(appSettings->savePath());
            if (!savePathFact) {
                return;
            }

            const QString appName = QCoreApplication::applicationName();
            const QString currentSavePath = savePathFact->rawValue().toString();
            const QString internalBasePath = QStandardPaths::writableLocation(QStandardPaths::GenericDataLocation);
            const QString internalSavePath = QDir(internalBasePath).filePath(appName);

            if (!currentSavePath.isEmpty() && (currentSavePath != internalSavePath)) {
                return;
            }

            const QString sdCardRootPath = getSDCardPath();
            if (sdCardRootPath.isEmpty() || !QDir(sdCardRootPath).exists() || !QFileInfo(sdCardRootPath).isWritable()) {
                return;
            }

            const QString sdSavePath = QDir(sdCardRootPath).filePath(appName);
            if (currentSavePath != sdSavePath) {
                qCDebug(AndroidInterfaceLog) << "Applying SD card save path after permission grant:" << sdSavePath;
                savePathFact->setRawValue(sdSavePath);
            }
        },
        Qt::QueuedConnection);
}

void jniOnImportResult(JNIEnv* env, jstring filePathJ)
{
    const char* const filePathCStr = env->GetStringUTFChars(filePathJ, nullptr);
    const QString filePath = QString::fromUtf8(filePathCStr);
    env->ReleaseStringUTFChars(filePathJ, filePathCStr);
    (void)QJniEnvironment::checkAndClearExceptions(env);
    auto callback = std::move(s_importCallback);
    if (!callback) {
        return;
    }
    callback(filePath);
}

static bool cacheMethodIds(JNIEnv* env, jclass javaClass)
{
    s_methods.checkStoragePermissions = env->GetStaticMethodID(javaClass, "checkStoragePermissions", "()Z");
    s_methods.getSDCardPath = env->GetStaticMethodID(javaClass, "getSDCardPath", "()Ljava/lang/String;");
    s_methods.openFileImportDialog = env->GetStaticMethodID(javaClass, "openFileImportDialog", "(Ljava/lang/String;)V");

    if (!s_methods.checkStoragePermissions || !s_methods.getSDCardPath || !s_methods.openFileImportDialog) {
        qCWarning(AndroidInterfaceLog) << "Failed to cache JNI method IDs for QGCActivity";
        (void)QJniEnvironment::checkAndClearExceptions(env);
        return false;
    }

    s_methodsCached = true;
    return true;
}

static jclass getActivityClass()
{
    QMutexLocker locker(&s_cacheLock);

    if (s_activityClass && s_methodsCached) {
        return s_activityClass;
    }

    QJniEnvironment env;
    if (!env.isValid()) {
        return nullptr;
    }

    if (!s_activityClass) {
        const jclass resolvedClass = env.findClass(kJniQGCActivityClassName);
        if (!resolvedClass) {
            qCWarning(AndroidInterfaceLog) << "Class Not Found:" << kJniQGCActivityClassName;
            return nullptr;
        }

        s_activityClass = static_cast<jclass>(env->NewGlobalRef(resolvedClass));
        env->DeleteLocalRef(resolvedClass);
    }

    if (!s_methodsCached && !cacheMethodIds(env.jniEnv(), s_activityClass)) {
        return nullptr;
    }

    return s_activityClass;
}

void setNativeMethods()
{
    qCDebug(AndroidInterfaceLog) << "Ensuring JNI method cache";
    (void)getActivityClass();
}

bool checkStoragePermissions()
{
    const jclass cls = getActivityClass();
    if (!cls) {
        return false;
    }

    QJniEnvironment env;
    jboolean hasPermission = JNI_FALSE;
    if (!callStaticBooleanMethod(env, cls, s_methods.checkStoragePermissions, "checkStoragePermissions",
                                 AndroidInterfaceLog(), hasPermission)) {
        return false;
    }

    if (hasPermission) {
        qCDebug(AndroidInterfaceLog) << "Storage permissions granted";
    } else {
        qCWarning(AndroidInterfaceLog) << "Storage permissions not granted";
    }

    return (hasPermission == JNI_TRUE);
}

QString getSDCardPath()
{
    if (!checkStoragePermissions()) {
        qCWarning(AndroidInterfaceLog) << "Storage Permission Denied";
        return QString();
    }

    const jclass cls = getActivityClass();
    if (!cls) {
        return QString();
    }

    QJniEnvironment env;
    const QJniObject result = env->CallStaticObjectMethod(cls, s_methods.getSDCardPath);
    if (env.checkAndClearExceptions()) {
        qCWarning(AndroidInterfaceLog) << "Exception in getSDCardPath";
        return QString();
    }

    if (!result.isValid()) {
        qCWarning(AndroidInterfaceLog) << "Call to java getSDCardPath failed: Invalid Result";
        return QString();
    }

    return result.toString();
}

void openFileImportDialog(const QString& destPath, std::function<void(const QString&)> callback)
{
    s_importCallback = std::move(callback);

    const jclass cls = getActivityClass();
    if (!cls) {
        if (s_importCallback) {
            auto cb = std::move(s_importCallback);
            cb(QString());
        }
        return;
    }

    const QJniObject jDestPath = QJniObject::fromString(destPath);
    QJniEnvironment env;
    env->CallStaticVoidMethod(cls, s_methods.openFileImportDialog, jDestPath.object<jstring>());

    if (env.checkAndClearExceptions()) {
        qCWarning(AndroidInterfaceLog) << "Exception in openFileImportDialog";
        if (s_importCallback) {
            auto cb = std::move(s_importCallback);
            cb(QString());
        }
    }
}

static QSharedPointer<QLocks::QLockBase> s_partialWakeLock; // NOLINT
static QSharedPointer<QLocks::QLockBase> s_wifiLock;        // NOLINT

void setKeepScreenOn(bool on)
{
    if (!QAndroidScreen::instance()) {
        new QAndroidScreen(QCoreApplication::instance());
    }
    QAndroidScreen::instance()->keepScreenOn(on);

    if (on) {
        s_partialWakeLock = QAndroidPartialWakeLocker::instance().getLock();
        s_wifiLock = QAndroidWiFiLocker::instance().getLock();
    } else {
        s_partialWakeLock.reset();
        s_wifiLock.reset();
    }
}

}  // namespace AndroidInterface

extern "C" {

void Java_org_mavlink_qgroundcontrol_QGCActivity_qgcLogDebug([[maybe_unused]] JNIEnv* env, [[maybe_unused]] jobject thiz, jstring message) // NOLINT
{
    qCDebug(AndroidInterfaceLog) << QJniObject(message).toString();
}

void Java_org_mavlink_qgroundcontrol_QGCActivity_qgcLogWarning([[maybe_unused]] JNIEnv* env, [[maybe_unused]] jobject thiz, jstring message) // NOLINT
{
    qCWarning(AndroidInterfaceLog) << QJniObject(message).toString();
}

void Java_org_mavlink_qgroundcontrol_QGCActivity_nativeStoragePermissionsResult([[maybe_unused]] JNIEnv* env, [[maybe_unused]] jobject thiz, jboolean granted) // NOLINT
{
    AndroidInterface::jniStoragePermissionsResult(granted);
}

void Java_org_mavlink_qgroundcontrol_QGCActivity_onImportResult([[maybe_unused]] JNIEnv* env, [[maybe_unused]] jobject thiz, jstring filePathJ) // NOLINT
{
    AndroidInterface::jniOnImportResult(env, filePathJ);
}

} // extern "C"
