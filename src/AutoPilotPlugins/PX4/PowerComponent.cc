#include "PowerComponent.h"
#include "ParameterManager.h"
#include "Vehicle.h"
#include "Fact.h"

PowerComponent::PowerComponent(Vehicle *vehicle, AutoPilotPlugin *autopilot, QObject *parent)
    : VehicleComponent(vehicle, autopilot, AutoPilotPlugin::KnownPowerVehicleComponent, parent)
    , _name(tr("Power"))
{
}

QString PowerComponent::name() const
{
    return _name;
}

QString PowerComponent::description() const
{
    return tr("Configure battery parameters, ESC calibration, and UAVCAN bus settings.");
}

QString PowerComponent::iconResource() const
{
    return QStringLiteral("/qmlimages/Battery.svg");
}

bool PowerComponent::requiresSetup() const
{
    return true;
}

bool PowerComponent::setupComplete() const
{
    bool complete = true;
    if (!_vehicle) {
        complete = false;
    } else {
        ParameterManager *paramMgr = _vehicle->parameterManager();
        if (!paramMgr) {
            complete = false;
        } else if (!paramMgr->parameterExists(ParameterManager::defaultComponentId, QStringLiteral("BAT1_SOURCE")) ||
                   !paramMgr->parameterExists(ParameterManager::defaultComponentId, QStringLiteral("BAT1_V_CHARGED")) ||
                   !paramMgr->parameterExists(ParameterManager::defaultComponentId, QStringLiteral("BAT1_V_EMPTY")) ||
                   !paramMgr->parameterExists(ParameterManager::defaultComponentId, QStringLiteral("BAT1_N_CELLS"))) {
            complete = true;
        } else {
            const Fact *sourceFact = paramMgr->getParameter(ParameterManager::defaultComponentId, QStringLiteral("BAT1_SOURCE"));
            const Fact *chargedFact = paramMgr->getParameter(ParameterManager::defaultComponentId, QStringLiteral("BAT1_V_CHARGED"));
            const Fact *emptyFact = paramMgr->getParameter(ParameterManager::defaultComponentId, QStringLiteral("BAT1_V_EMPTY"));
            const Fact *cellsFact = paramMgr->getParameter(ParameterManager::defaultComponentId, QStringLiteral("BAT1_N_CELLS"));

            const bool sourceNeg1 = sourceFact && (sourceFact->rawValue().toInt() == -1);
            const float charged = chargedFact ? chargedFact->rawValue().toFloat() : 0.0F;
            const float empty = emptyFact ? emptyFact->rawValue().toFloat() : 0.0F;
            const int cells = cellsFact ? cellsFact->rawValue().toInt() : 0;
            complete = sourceNeg1 || (charged != 0.0F && empty != 0.0F && cells != 0);
        }
    }
    return complete;
}

QStringList PowerComponent::setupCompleteChangedTriggerList() const
{
    return {
        QStringLiteral("BAT1_SOURCE"),
        QStringLiteral("BAT1_V_CHARGED"),
        QStringLiteral("BAT1_V_EMPTY"),
        QStringLiteral("BAT1_N_CELLS")
    };
}

QUrl PowerComponent::setupSource() const
{
    // Generated from Power.VehicleConfig.json
    return QUrl::fromUserInput(QStringLiteral("qrc:/qml/QGroundControl/AutoPilotPlugins/PX4/PowerComponent.qml"));
}

QUrl PowerComponent::summaryQmlSource() const
{
    return QUrl::fromUserInput(QStringLiteral("qrc:/qml/QGroundControl/AutoPilotPlugins/PX4/PowerComponentSummary.qml"));
}

QString PowerComponent::vehicleConfigJson() const
{
    return QStringLiteral(":/qml/QGroundControl/AutoPilotPlugins/PX4/VehicleConfig/Power.VehicleConfig.json");
}
