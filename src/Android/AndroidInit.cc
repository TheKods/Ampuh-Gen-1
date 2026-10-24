#include <jni.h>
#include "AndroidInterface.h"
#ifndef QGC_NO_SERIAL_LINK
#include "AndroidSerial.h"
#endif
#include <QJniEnvironment>
#include <QJniObject>
#include <QLoggingCategory>

#include <atomic>

#include "QGCLoggingCategory.h"

QGC_LOGGING_CATEGORY(AndroidInitLog, "Android.AndroidInit"); // NOLINT

static std::atomic<jobject> s_context{nullptr};       // NOLINT
static std::atomic<jobject> s_class_loader{nullptr};  // NOLINT
static std::atomic<JavaVM*> s_java_vm{nullptr};       // NOLINT

#ifdef QGC_GST_STREAMING

#define QGC_JNI_EXPORT __attribute__((visibility("default")))

extern "C"
{
    // Exported for GStreamer plugins (e.g. androidmedia) that are statically
    // linked into the main binary and need Android platform access at runtime.

    QGC_JNI_EXPORT jobject gst_android_get_application_context(void)
    {
        return s_context.load(std::memory_order_acquire);
    }

    QGC_JNI_EXPORT jobject gst_android_get_application_class_loader(void)
    {
        return s_class_loader.load(std::memory_order_acquire);
    }

    QGC_JNI_EXPORT JavaVM *gst_android_get_java_vm(void)
    {
        return s_java_vm.load(std::memory_order_acquire);
    }
}

#endif

extern "C" jboolean Java_org_mavlink_qgroundcontrol_QGCActivity_nativeInit(JNIEnv* env, [[maybe_unused]] jobject thiz) // NOLINT
{
    (void)env;
    qCDebug(AndroidInitLog) << Q_FUNC_INFO;

    const jclass contextCls = env->GetObjectClass(thiz);
    if (!contextCls) {
        return JNI_FALSE;
    }

    const jmethodID getAppContextId = env->GetMethodID(contextCls, "getApplicationContext", "()Landroid/content/Context;");
    env->DeleteLocalRef(contextCls);
    if (QJniEnvironment::checkAndClearExceptions(env)) {
        return JNI_FALSE;
    }

    const jobject appContext = env->CallObjectMethod(thiz, getAppContextId);
    if (QJniEnvironment::checkAndClearExceptions(env) || !appContext) {
        return JNI_FALSE;
    }

    const jclass appContextCls = env->GetObjectClass(appContext);
    if (!appContextCls) {
        env->DeleteLocalRef(appContext);
        return JNI_FALSE;
    }

    const jmethodID getClassLoaderId = env->GetMethodID(appContextCls, "getClassLoader", "()Ljava/lang/ClassLoader;");
    env->DeleteLocalRef(appContextCls);
    if (QJniEnvironment::checkAndClearExceptions(env)) {
        env->DeleteLocalRef(appContext);
        return JNI_FALSE;
    }

    const jobject classLoader = env->CallObjectMethod(appContext, getClassLoaderId);
    if (QJniEnvironment::checkAndClearExceptions(env)) {
        env->DeleteLocalRef(appContext);
        return JNI_FALSE;
    }

    const jobject appContextGlobal = env->NewGlobalRef(appContext);
    const jobject classLoaderGlobal = env->NewGlobalRef(classLoader);

    env->DeleteLocalRef(appContext);
    env->DeleteLocalRef(classLoader);

    if (!appContextGlobal || !classLoaderGlobal || QJniEnvironment::checkAndClearExceptions(env)) {
        if (appContextGlobal) {
            env->DeleteGlobalRef(appContextGlobal);
        }
        if (classLoaderGlobal) {
            env->DeleteGlobalRef(classLoaderGlobal);
        }
        return JNI_FALSE;
    }

    if (jobject oldContext = s_context.exchange(appContextGlobal, std::memory_order_acq_rel)) {
        env->DeleteGlobalRef(oldContext);
    }
    if (jobject oldClassLoader = s_class_loader.exchange(classLoaderGlobal, std::memory_order_acq_rel)) {
        env->DeleteGlobalRef(oldClassLoader);
    }

    return JNI_TRUE;
}

static jint jniSetNativeMethods()
{
    qCDebug(AndroidInitLog) << Q_FUNC_INFO;

    return JNI_OK;
}

jint JNI_OnLoad(JavaVM* vm, void* reserved)
{
    (void)reserved;
    qCDebug(AndroidInitLog) << Q_FUNC_INFO;

    s_java_vm.store(vm, std::memory_order_release);

    JNIEnv *env;
    if (vm->GetEnv(reinterpret_cast<void**>(&env), JNI_VERSION_1_6) != JNI_OK) {
        return JNI_ERR;
    }

    if (jniSetNativeMethods() != JNI_OK) {
        return JNI_ERR;
    }

    AndroidInterface::setNativeMethods();

#ifndef QGC_NO_SERIAL_LINK
    AndroidSerial::setNativeMethods();
#endif

    QNativeInterface::QAndroidApplication::hideSplashScreen(333);

    return JNI_VERSION_1_6;
}

void JNI_OnUnload(JavaVM* vm, void* reserved)
{
    (void)reserved;
    qCDebug(AndroidInitLog) << Q_FUNC_INFO;

    JNIEnv* env = nullptr;
    if (vm->GetEnv(reinterpret_cast<void**>(&env), JNI_VERSION_1_6) == JNI_OK) {
        if (jobject ctx = s_context.exchange(nullptr, std::memory_order_acq_rel)) {
            env->DeleteGlobalRef(ctx);
        }
        if (jobject cl = s_class_loader.exchange(nullptr, std::memory_order_acq_rel)) {
            env->DeleteGlobalRef(cl);
        }
    }

    s_java_vm.store(nullptr, std::memory_order_release);

#ifndef QGC_NO_SERIAL_LINK
    AndroidSerial::cleanupJniCache();
#endif
}
