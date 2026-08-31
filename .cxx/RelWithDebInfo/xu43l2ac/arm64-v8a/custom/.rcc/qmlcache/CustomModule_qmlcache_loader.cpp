#include <QtQml/qqmlprivate.h>
#include <QtCore/qdir.h>
#include <QtCore/qurl.h>
#include <QtCore/qhash.h>
#include <QtCore/qstring.h>

namespace QmlCacheGeneratedCode {
namespace _qml_Custom_Widgets_CustomArtificialHorizon_qml { 
    extern const unsigned char qmlData[];
    extern const QQmlPrivate::AOTCompiledFunction aotBuiltFunctions[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), &aotBuiltFunctions[0], nullptr
    };
}
namespace _qml_Custom_Widgets_CustomAttitudeWidget_qml { 
    extern const unsigned char qmlData[];
    extern const QQmlPrivate::AOTCompiledFunction aotBuiltFunctions[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), &aotBuiltFunctions[0], nullptr
    };
}
namespace _qml_Custom_Widgets_CustomIconButton_qml { 
    extern const unsigned char qmlData[];
    extern const QQmlPrivate::AOTCompiledFunction aotBuiltFunctions[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), &aotBuiltFunctions[0], nullptr
    };
}
namespace _qml_Custom_Widgets_CustomOnOffSwitch_qml { 
    extern const unsigned char qmlData[];
    extern const QQmlPrivate::AOTCompiledFunction aotBuiltFunctions[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), &aotBuiltFunctions[0], nullptr
    };
}
namespace _qml_Custom_Widgets_CustomQuickButton_qml { 
    extern const unsigned char qmlData[];
    extern const QQmlPrivate::AOTCompiledFunction aotBuiltFunctions[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), &aotBuiltFunctions[0], nullptr
    };
}
namespace _qml_Custom_Widgets_CustomSignalStrength_qml { 
    extern const unsigned char qmlData[];
    extern const QQmlPrivate::AOTCompiledFunction aotBuiltFunctions[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), &aotBuiltFunctions[0], nullptr
    };
}
namespace _qml_Custom_Widgets_CustomToolBarButton_qml { 
    extern const unsigned char qmlData[];
    extern const QQmlPrivate::AOTCompiledFunction aotBuiltFunctions[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), &aotBuiltFunctions[0], nullptr
    };
}
namespace _qml_Custom_Widgets_CustomVehicleButton_qml { 
    extern const unsigned char qmlData[];
    extern const QQmlPrivate::AOTCompiledFunction aotBuiltFunctions[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), &aotBuiltFunctions[0], nullptr
    };
}

}
namespace {
struct Registry {
    Registry();
    ~Registry();
    QHash<QString, const QQmlPrivate::CachedQmlUnit*> resourcePathToCachedUnit;
    static const QQmlPrivate::CachedQmlUnit *lookupCachedUnit(const QUrl &url);
};

Q_GLOBAL_STATIC(Registry, unitRegistry)


Registry::Registry() {
    resourcePathToCachedUnit.insert(QStringLiteral("/qml/Custom/Widgets/CustomArtificialHorizon.qml"), &QmlCacheGeneratedCode::_qml_Custom_Widgets_CustomArtificialHorizon_qml::unit);
    resourcePathToCachedUnit.insert(QStringLiteral("/qml/Custom/Widgets/CustomAttitudeWidget.qml"), &QmlCacheGeneratedCode::_qml_Custom_Widgets_CustomAttitudeWidget_qml::unit);
    resourcePathToCachedUnit.insert(QStringLiteral("/qml/Custom/Widgets/CustomIconButton.qml"), &QmlCacheGeneratedCode::_qml_Custom_Widgets_CustomIconButton_qml::unit);
    resourcePathToCachedUnit.insert(QStringLiteral("/qml/Custom/Widgets/CustomOnOffSwitch.qml"), &QmlCacheGeneratedCode::_qml_Custom_Widgets_CustomOnOffSwitch_qml::unit);
    resourcePathToCachedUnit.insert(QStringLiteral("/qml/Custom/Widgets/CustomQuickButton.qml"), &QmlCacheGeneratedCode::_qml_Custom_Widgets_CustomQuickButton_qml::unit);
    resourcePathToCachedUnit.insert(QStringLiteral("/qml/Custom/Widgets/CustomSignalStrength.qml"), &QmlCacheGeneratedCode::_qml_Custom_Widgets_CustomSignalStrength_qml::unit);
    resourcePathToCachedUnit.insert(QStringLiteral("/qml/Custom/Widgets/CustomToolBarButton.qml"), &QmlCacheGeneratedCode::_qml_Custom_Widgets_CustomToolBarButton_qml::unit);
    resourcePathToCachedUnit.insert(QStringLiteral("/qml/Custom/Widgets/CustomVehicleButton.qml"), &QmlCacheGeneratedCode::_qml_Custom_Widgets_CustomVehicleButton_qml::unit);
    QQmlPrivate::RegisterQmlUnitCacheHook registration;
    registration.structVersion = 0;
    registration.lookupCachedQmlUnit = &lookupCachedUnit;
    QQmlPrivate::qmlregister(QQmlPrivate::QmlUnitCacheHookRegistration, &registration);
}

Registry::~Registry() {
    QQmlPrivate::qmlunregister(QQmlPrivate::QmlUnitCacheHookRegistration, quintptr(&lookupCachedUnit));
}

const QQmlPrivate::CachedQmlUnit *Registry::lookupCachedUnit(const QUrl &url) {
    if (url.scheme() != QLatin1String("qrc"))
        return nullptr;
    QString resourcePath = QDir::cleanPath(url.path());
    if (resourcePath.isEmpty())
        return nullptr;
    if (!resourcePath.startsWith(QLatin1Char('/')))
        resourcePath.prepend(QLatin1Char('/'));
    return unitRegistry()->resourcePathToCachedUnit.value(resourcePath, nullptr);
}
}
int QT_MANGLE_NAMESPACE(qInitResources_qmlcache_CustomModule)() {
    ::unitRegistry();
    return 1;
}
Q_CONSTRUCTOR_FUNCTION(QT_MANGLE_NAMESPACE(qInitResources_qmlcache_CustomModule))
int QT_MANGLE_NAMESPACE(qCleanupResources_qmlcache_CustomModule)() {
    return 1;
}
