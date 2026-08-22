#include "CustomPlugin.h"
#include "PerimeterScanComplexItem.h"
#include "PerimeterScanPlanCreator.h"
#include "QmlComponentInfo.h"
#include "QGCLoggingCategory.h"
#include "QGCPalette.h"
#include "QGCMAVLink.h"
#include "AppSettings.h"

#include <QtCore/QApplicationStatic>
#include <QtQml/QQmlApplicationEngine>
#include <QtQml/QQmlFile>

QGC_LOGGING_CATEGORY(CustomLog, "Custom.CustomPlugin")

Q_APPLICATION_STATIC(CustomPlugin, _customPluginInstance);

CustomFlyViewOptions::CustomFlyViewOptions(CustomOptions* options, QObject* parent)
    : QGCFlyViewOptions(options, parent)
{
    qCDebug(CustomLog) << this;
}

CustomOptions::CustomOptions(CustomPlugin *plugin, QObject *parent)
    : QGCOptions(parent)
    , _plugin(plugin)
    , _flyViewOptions(new CustomFlyViewOptions(this, this))
{
    Q_CHECK_PTR(_plugin);
}

/*===========================================================================*/

CustomPlugin::CustomPlugin(QObject *parent)
    : QGCCorePlugin(parent)
    , _options(new CustomOptions(this, this))
{
    qCDebug(CustomLog) << this;

    _showAdvancedUI = false;
    (void) connect(this, &QGCCorePlugin::showAdvancedUIChanged, this, &CustomPlugin::_advancedChanged);
}

QGCCorePlugin *CustomPlugin::instance()
{
    return _customPluginInstance();
}

void CustomPlugin::_advancedChanged(bool changed)
{
    // Firmware Upgrade page is only show in Advanced mode
    emit _options->showFirmwareUpgradeChanged(changed);
}

void CustomPlugin::_addSettingsEntry(const QString &title, const char *qmlFile, const char *iconFile)
{
    Q_CHECK_PTR(qmlFile);
    // 'this' instance will take ownership on the QmlComponentInfo instance
    _customSettingsList.append(QVariant::fromValue(
        new QmlComponentInfo(
            title,
            QUrl::fromUserInput(qmlFile),
            !iconFile ? QUrl() : QUrl::fromUserInput(iconFile),
            this)
        )
    );
}

void CustomPlugin::adjustSettingMetaData(const QString& settingsGroup, FactMetaData& metaData, bool &userVisible)
{
    QGCCorePlugin::adjustSettingMetaData(settingsGroup, metaData, userVisible);

    if (settingsGroup == AppSettings::settingsGroup) {
        // This tells QGC than when you are creating Plans while not connected to a vehicle
        // the specific firmware/vehicle the plan is for.
        if (metaData.name() == AppSettings::offlineEditingFirmwareClassName) {
            metaData.setRawDefaultValue(QGCMAVLink::FirmwareClassPX4);
            userVisible = false;
            return;
        } else if (metaData.name() == AppSettings::offlineEditingVehicleClassName) {
            metaData.setRawDefaultValue(QGCMAVLink::VehicleClassMultiRotor);
            userVisible = false;
            return;
        }
    }
}

void CustomPlugin::paletteOverride(const QString &colorName, QGCPalette::PaletteColorInfo_t& colorInfo)
{
    if (colorName == QStringLiteral("window")) {
        colorInfo[QGCPalette::Dark][QGCPalette::ColorGroupEnabled]   = QColor("#0a0f1d");
        colorInfo[QGCPalette::Dark][QGCPalette::ColorGroupDisabled]  = QColor("#0a0f1d");
        colorInfo[QGCPalette::Light][QGCPalette::ColorGroupEnabled]  = QColor("#f1f5f9");
        colorInfo[QGCPalette::Light][QGCPalette::ColorGroupDisabled] = QColor("#e2e8f0");
    } else if (colorName == QStringLiteral("windowShade")) {
        colorInfo[QGCPalette::Dark][QGCPalette::ColorGroupEnabled]   = QColor("#111827");
        colorInfo[QGCPalette::Dark][QGCPalette::ColorGroupDisabled]  = QColor("#111827");
        colorInfo[QGCPalette::Light][QGCPalette::ColorGroupEnabled]  = QColor("#e2e8f0");
        colorInfo[QGCPalette::Light][QGCPalette::ColorGroupDisabled] = QColor("#cbd5e1");
    } else if (colorName == QStringLiteral("windowShadeDark")) {
        colorInfo[QGCPalette::Dark][QGCPalette::ColorGroupEnabled]   = QColor("#050811");
        colorInfo[QGCPalette::Dark][QGCPalette::ColorGroupDisabled]  = QColor("#050811");
        colorInfo[QGCPalette::Light][QGCPalette::ColorGroupEnabled]  = QColor("#cbd5e1");
        colorInfo[QGCPalette::Light][QGCPalette::ColorGroupDisabled] = QColor("#94a3b8");
    } else if (colorName == QStringLiteral("text")) {
        colorInfo[QGCPalette::Dark][QGCPalette::ColorGroupEnabled]   = QColor("#f8fafc");
        colorInfo[QGCPalette::Dark][QGCPalette::ColorGroupDisabled]  = QColor("#64748b");
        colorInfo[QGCPalette::Light][QGCPalette::ColorGroupEnabled]  = QColor("#0f172a");
        colorInfo[QGCPalette::Light][QGCPalette::ColorGroupDisabled] = QColor("#94a3b8");
    } else if (colorName == QStringLiteral("warningText")) {
        colorInfo[QGCPalette::Dark][QGCPalette::ColorGroupEnabled]   = QColor("#ef4444");
        colorInfo[QGCPalette::Dark][QGCPalette::ColorGroupDisabled]  = QColor("#ef4444");
        colorInfo[QGCPalette::Light][QGCPalette::ColorGroupEnabled]  = QColor("#dc2626");
        colorInfo[QGCPalette::Light][QGCPalette::ColorGroupDisabled] = QColor("#dc2626");
    } else if (colorName == QStringLiteral("button")) {
        colorInfo[QGCPalette::Dark][QGCPalette::ColorGroupEnabled]   = QColor("#1e293b");
        colorInfo[QGCPalette::Dark][QGCPalette::ColorGroupDisabled]  = QColor("#1e293b");
        colorInfo[QGCPalette::Light][QGCPalette::ColorGroupEnabled]  = QColor("#e2e8f0");
        colorInfo[QGCPalette::Light][QGCPalette::ColorGroupDisabled] = QColor("#e2e8f0");
    } else if (colorName == QStringLiteral("buttonText")) {
        colorInfo[QGCPalette::Dark][QGCPalette::ColorGroupEnabled]   = QColor("#f8fafc");
        colorInfo[QGCPalette::Dark][QGCPalette::ColorGroupDisabled]  = QColor("#64748b");
        colorInfo[QGCPalette::Light][QGCPalette::ColorGroupEnabled]  = QColor("#0f172a");
        colorInfo[QGCPalette::Light][QGCPalette::ColorGroupDisabled] = QColor("#94a3b8");
    } else if (colorName == QStringLiteral("buttonHighlight")) {
        colorInfo[QGCPalette::Dark][QGCPalette::ColorGroupEnabled]   = QColor("#00f0ff");
        colorInfo[QGCPalette::Dark][QGCPalette::ColorGroupDisabled]  = QColor("#1e293b");
        colorInfo[QGCPalette::Light][QGCPalette::ColorGroupEnabled]  = QColor("#0284c7");
        colorInfo[QGCPalette::Light][QGCPalette::ColorGroupDisabled] = QColor("#cbd5e1");
    } else if (colorName == QStringLiteral("buttonHighlightText")) {
        colorInfo[QGCPalette::Dark][QGCPalette::ColorGroupEnabled]   = QColor("#020617");
        colorInfo[QGCPalette::Dark][QGCPalette::ColorGroupDisabled]  = QColor("#64748b");
        colorInfo[QGCPalette::Light][QGCPalette::ColorGroupEnabled]  = QColor("#ffffff");
        colorInfo[QGCPalette::Light][QGCPalette::ColorGroupDisabled] = QColor("#334155");
    } else if (colorName == QStringLiteral("primaryButton")) {
        colorInfo[QGCPalette::Dark][QGCPalette::ColorGroupEnabled]   = QColor("#0284c7");
        colorInfo[QGCPalette::Dark][QGCPalette::ColorGroupDisabled]  = QColor("#1e293b");
        colorInfo[QGCPalette::Light][QGCPalette::ColorGroupEnabled]  = QColor("#0369a1");
        colorInfo[QGCPalette::Light][QGCPalette::ColorGroupDisabled] = QColor("#94a3b8");
    } else if (colorName == QStringLiteral("primaryButtonText")) {
        colorInfo[QGCPalette::Dark][QGCPalette::ColorGroupEnabled]   = QColor("#ffffff");
        colorInfo[QGCPalette::Dark][QGCPalette::ColorGroupDisabled]  = QColor("#ffffff");
        colorInfo[QGCPalette::Light][QGCPalette::ColorGroupEnabled]  = QColor("#ffffff");
        colorInfo[QGCPalette::Light][QGCPalette::ColorGroupDisabled] = QColor("#cbd5e1");
    } else if (colorName == QStringLiteral("textField")) {
        colorInfo[QGCPalette::Dark][QGCPalette::ColorGroupEnabled]   = QColor("#0f172a");
        colorInfo[QGCPalette::Dark][QGCPalette::ColorGroupDisabled]  = QColor("#1e293b");
        colorInfo[QGCPalette::Light][QGCPalette::ColorGroupEnabled]  = QColor("#ffffff");
        colorInfo[QGCPalette::Light][QGCPalette::ColorGroupDisabled] = QColor("#f1f5f9");
    } else if (colorName == QStringLiteral("textFieldText")) {
        colorInfo[QGCPalette::Dark][QGCPalette::ColorGroupEnabled]   = QColor("#f8fafc");
        colorInfo[QGCPalette::Dark][QGCPalette::ColorGroupDisabled]  = QColor("#64748b");
        colorInfo[QGCPalette::Light][QGCPalette::ColorGroupEnabled]  = QColor("#0f172a");
        colorInfo[QGCPalette::Light][QGCPalette::ColorGroupDisabled] = QColor("#94a3b8");
    } else if (colorName == QStringLiteral("mapButton")) {
        colorInfo[QGCPalette::Dark][QGCPalette::ColorGroupEnabled]   = QColor("#0f172a");
        colorInfo[QGCPalette::Dark][QGCPalette::ColorGroupDisabled]  = QColor("#1e293b");
        colorInfo[QGCPalette::Light][QGCPalette::ColorGroupEnabled]  = QColor("#ffffff");
        colorInfo[QGCPalette::Light][QGCPalette::ColorGroupDisabled] = QColor("#e2e8f0");
    } else if (colorName == QStringLiteral("mapButtonHighlight")) {
        colorInfo[QGCPalette::Dark][QGCPalette::ColorGroupEnabled]   = QColor("#00f0ff");
        colorInfo[QGCPalette::Dark][QGCPalette::ColorGroupDisabled]  = QColor("#1e293b");
        colorInfo[QGCPalette::Light][QGCPalette::ColorGroupEnabled]  = QColor("#0284c7");
        colorInfo[QGCPalette::Light][QGCPalette::ColorGroupDisabled] = QColor("#cbd5e1");
    } else if (colorName == QStringLiteral("mapIndicator")) {
        colorInfo[QGCPalette::Dark][QGCPalette::ColorGroupEnabled]   = QColor("#10b981");
        colorInfo[QGCPalette::Dark][QGCPalette::ColorGroupDisabled]  = QColor("#1e293b");
        colorInfo[QGCPalette::Light][QGCPalette::ColorGroupEnabled]  = QColor("#059669");
        colorInfo[QGCPalette::Light][QGCPalette::ColorGroupDisabled] = QColor("#cbd5e1");
    } else if (colorName == QStringLiteral("mapIndicatorChild")) {
        colorInfo[QGCPalette::Dark][QGCPalette::ColorGroupEnabled]   = QColor("#059669");
        colorInfo[QGCPalette::Dark][QGCPalette::ColorGroupDisabled]  = QColor("#1e293b");
        colorInfo[QGCPalette::Light][QGCPalette::ColorGroupEnabled]  = QColor("#047857");
        colorInfo[QGCPalette::Light][QGCPalette::ColorGroupDisabled] = QColor("#cbd5e1");
    } else if (colorName == QStringLiteral("colorGreen")) {
        colorInfo[QGCPalette::Dark][QGCPalette::ColorGroupEnabled]   = QColor("#10b981");
        colorInfo[QGCPalette::Dark][QGCPalette::ColorGroupDisabled]  = QColor("#059669");
        colorInfo[QGCPalette::Light][QGCPalette::ColorGroupEnabled]  = QColor("#059669");
        colorInfo[QGCPalette::Light][QGCPalette::ColorGroupDisabled] = QColor("#059669");
    } else if (colorName == QStringLiteral("colorOrange")) {
        colorInfo[QGCPalette::Dark][QGCPalette::ColorGroupEnabled]   = QColor("#f59e0b");
        colorInfo[QGCPalette::Dark][QGCPalette::ColorGroupDisabled]  = QColor("#d97706");
        colorInfo[QGCPalette::Light][QGCPalette::ColorGroupEnabled]  = QColor("#d97706");
        colorInfo[QGCPalette::Light][QGCPalette::ColorGroupDisabled] = QColor("#d97706");
    } else if (colorName == QStringLiteral("colorRed")) {
        colorInfo[QGCPalette::Dark][QGCPalette::ColorGroupEnabled]   = QColor("#ef4444");
        colorInfo[QGCPalette::Dark][QGCPalette::ColorGroupDisabled]  = QColor("#dc2626");
        colorInfo[QGCPalette::Light][QGCPalette::ColorGroupEnabled]  = QColor("#dc2626");
        colorInfo[QGCPalette::Light][QGCPalette::ColorGroupDisabled] = QColor("#dc2626");
    } else if (colorName == QStringLiteral("colorGrey")) {
        colorInfo[QGCPalette::Dark][QGCPalette::ColorGroupEnabled]   = QColor("#64748b");
        colorInfo[QGCPalette::Dark][QGCPalette::ColorGroupDisabled]  = QColor("#64748b");
        colorInfo[QGCPalette::Light][QGCPalette::ColorGroupEnabled]  = QColor("#94a3b8");
        colorInfo[QGCPalette::Light][QGCPalette::ColorGroupDisabled] = QColor("#94a3b8");
    } else if (colorName == QStringLiteral("colorBlue")) {
        colorInfo[QGCPalette::Dark][QGCPalette::ColorGroupEnabled]   = QColor("#00f0ff");
        colorInfo[QGCPalette::Dark][QGCPalette::ColorGroupDisabled]  = QColor("#0284c7");
        colorInfo[QGCPalette::Light][QGCPalette::ColorGroupEnabled]  = QColor("#0284c7");
        colorInfo[QGCPalette::Light][QGCPalette::ColorGroupDisabled] = QColor("#0284c7");
    } else if (colorName == QStringLiteral("alertBackground")) {
        colorInfo[QGCPalette::Dark][QGCPalette::ColorGroupEnabled]   = QColor("#78350f");
        colorInfo[QGCPalette::Dark][QGCPalette::ColorGroupDisabled]  = QColor("#78350f");
        colorInfo[QGCPalette::Light][QGCPalette::ColorGroupEnabled]  = QColor("#fef3c7");
        colorInfo[QGCPalette::Light][QGCPalette::ColorGroupDisabled] = QColor("#fde68a");
    } else if (colorName == QStringLiteral("alertBorder")) {
        colorInfo[QGCPalette::Dark][QGCPalette::ColorGroupEnabled]   = QColor("#f59e0b");
        colorInfo[QGCPalette::Dark][QGCPalette::ColorGroupDisabled]  = QColor("#f59e0b");
        colorInfo[QGCPalette::Light][QGCPalette::ColorGroupEnabled]  = QColor("#d97706");
        colorInfo[QGCPalette::Light][QGCPalette::ColorGroupDisabled] = QColor("#d97706");
    } else if (colorName == QStringLiteral("alertText")) {
        colorInfo[QGCPalette::Dark][QGCPalette::ColorGroupEnabled]   = QColor("#fef3c7");
        colorInfo[QGCPalette::Dark][QGCPalette::ColorGroupDisabled]  = QColor("#fef3c7");
        colorInfo[QGCPalette::Light][QGCPalette::ColorGroupEnabled]  = QColor("#78350f");
        colorInfo[QGCPalette::Light][QGCPalette::ColorGroupDisabled] = QColor("#78350f");
    } else if (colorName == QStringLiteral("missionItemEditor")) {
        colorInfo[QGCPalette::Dark][QGCPalette::ColorGroupEnabled]   = QColor("#111827");
        colorInfo[QGCPalette::Dark][QGCPalette::ColorGroupDisabled]  = QColor("#050811");
        colorInfo[QGCPalette::Light][QGCPalette::ColorGroupEnabled]  = QColor("#ffffff");
        colorInfo[QGCPalette::Light][QGCPalette::ColorGroupDisabled] = QColor("#cbd5e1");
    } else if (colorName == QStringLiteral("hoverColor")) {
        colorInfo[QGCPalette::Dark][QGCPalette::ColorGroupEnabled]   = QColor("#38bdf8");
        colorInfo[QGCPalette::Dark][QGCPalette::ColorGroupDisabled]  = QColor("#0284c7");
        colorInfo[QGCPalette::Light][QGCPalette::ColorGroupEnabled]  = QColor("#0284c7");
        colorInfo[QGCPalette::Light][QGCPalette::ColorGroupDisabled] = QColor("#0369a1");
    } else if (colorName == QStringLiteral("mapWidgetBorderLight")) {
        colorInfo[QGCPalette::Dark][QGCPalette::ColorGroupEnabled]   = QColor("#334155");
        colorInfo[QGCPalette::Dark][QGCPalette::ColorGroupDisabled]  = QColor("#1e293b");
        colorInfo[QGCPalette::Light][QGCPalette::ColorGroupEnabled]  = QColor("#cbd5e1");
        colorInfo[QGCPalette::Light][QGCPalette::ColorGroupDisabled] = QColor("#94a3b8");
    } else if (colorName == QStringLiteral("mapWidgetBorderDark")) {
        colorInfo[QGCPalette::Dark][QGCPalette::ColorGroupEnabled]   = QColor("#020617");
        colorInfo[QGCPalette::Dark][QGCPalette::ColorGroupDisabled]  = QColor("#020617");
        colorInfo[QGCPalette::Light][QGCPalette::ColorGroupEnabled]  = QColor("#1e293b");
        colorInfo[QGCPalette::Light][QGCPalette::ColorGroupDisabled] = QColor("#0f172a");
    } else if (colorName == QStringLiteral("brandingPurple")) {
        colorInfo[QGCPalette::Dark][QGCPalette::ColorGroupEnabled]   = QColor("#00f0ff");
        colorInfo[QGCPalette::Dark][QGCPalette::ColorGroupDisabled]  = QColor("#00f0ff");
        colorInfo[QGCPalette::Light][QGCPalette::ColorGroupEnabled]  = QColor("#0284c7");
        colorInfo[QGCPalette::Light][QGCPalette::ColorGroupDisabled] = QColor("#0284c7");
    } else if (colorName == QStringLiteral("brandingBlue")) {
        colorInfo[QGCPalette::Dark][QGCPalette::ColorGroupEnabled]   = QColor("#38bdf8");
        colorInfo[QGCPalette::Dark][QGCPalette::ColorGroupDisabled]  = QColor("#0ea5e9");
        colorInfo[QGCPalette::Light][QGCPalette::ColorGroupEnabled]  = QColor("#0284c7");
        colorInfo[QGCPalette::Light][QGCPalette::ColorGroupDisabled] = QColor("#0ea5e9");
    }
}

QQmlApplicationEngine* CustomPlugin::createQmlApplicationEngine(QObject* parent)
{
    _qmlEngine = QGCCorePlugin::createQmlApplicationEngine(parent);
    _qmlEngine->addImportPath("qrc:/qml/Custom/Widgets");
    _qmlEngine->addImportPath("qrc:/qml/Custom/Plan");
    // TODO: Investigate _qmlEngine->setExtraSelectors({"custom"})

    _urlInterceptor = new CustomOverrideInterceptor();
    _qmlEngine->addUrlInterceptor(_urlInterceptor);

    return _qmlEngine;
}

void CustomPlugin::destroyQmlApplicationEngine(QQmlApplicationEngine *qmlEngine)
{
    if (qmlEngine && (qmlEngine == _qmlEngine)) {
        qmlEngine->removeUrlInterceptor(_urlInterceptor);
        delete _urlInterceptor;
        _urlInterceptor = nullptr;
        _qmlEngine = nullptr;
    }

    QGCCorePlugin::destroyQmlApplicationEngine(qmlEngine);
}

/*===========================================================================*/

CustomOverrideInterceptor::CustomOverrideInterceptor()
    : QQmlAbstractUrlInterceptor()
{

}

QUrl CustomOverrideInterceptor::intercept(const QUrl &url, QQmlAbstractUrlInterceptor::DataType type)
{
    switch (type) {
    case QQmlAbstractUrlInterceptor::QmlFile:
    case QQmlAbstractUrlInterceptor::UrlString:
        if (url.scheme() == QStringLiteral("qrc")) {
            const QString origPath = url.path();
            const QString overrideRes = QStringLiteral(":/Custom%1").arg(origPath);
            if (QFile::exists(overrideRes)) {
                const QString relPath = overrideRes.mid(2);
                QUrl result;
                result.setScheme(QStringLiteral("qrc"));
                result.setPath('/' + relPath);
                return result;
            }
        }
        break;
    default:
        break;
    }

    return url;
}

/*===========================================================================*/

QVariantList CustomPlugin::complexMissionItemNames(Vehicle *vehicle)
{
    // Start with the standard set, then append our custom item.
    QVariantList items = QGCCorePlugin::complexMissionItemNames(vehicle);

    QVariantMap entry;
    entry[QStringLiteral("canonicalName")]  = QString(PerimeterScanComplexItem::canonicalName);
    entry[QStringLiteral("translatedName")] = PerimeterScanComplexItem::tr(PerimeterScanComplexItem::canonicalName);
    items.append(entry);

    return items;
}

ComplexMissionItem *CustomPlugin::createComplexMissionItem(const QString &complexItemType,
                                                            PlanMasterController *masterController,
                                                            bool flyView,
                                                            const QString &kmlOrShpFile)
{
    if (complexItemType == PerimeterScanComplexItem::canonicalName
            || complexItemType == PerimeterScanComplexItem::jsonComplexItemTypeValue) {
        return new PerimeterScanComplexItem(masterController, flyView, kmlOrShpFile);
    }
    // Fall back to the built-in factory for all standard item types.
    return QGCCorePlugin::createComplexMissionItem(complexItemType, masterController, flyView, kmlOrShpFile);
}

QList<PlanCreator *> CustomPlugin::planCreators(PlanMasterController *planMasterController)
{
    // Start with the standard creators, then add ours.
    QList<PlanCreator *> creators = QGCCorePlugin::planCreators(planMasterController);
    creators.append(new PerimeterScanPlanCreator(planMasterController));
    return creators;
}
