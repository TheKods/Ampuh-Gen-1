#include "CustomAutoPilotPlugin.h"
#include "ParameterManager.h"
#include "QGCCorePlugin.h"
#include "Vehicle.h"

CustomAutoPilotPlugin::CustomAutoPilotPlugin(Vehicle *vehicle, QObject *parent)
    : PX4AutoPilotPlugin(vehicle, parent)
{
    // Whenever we go on/out of advanced mode the available list of settings pages will change
    (void) connect(QGCCorePlugin::instance(), &QGCCorePlugin::showAdvancedUIChanged, this, &CustomAutoPilotPlugin::_advancedChanged);
}

CustomAutoPilotPlugin::~CustomAutoPilotPlugin()
{
    _clearComponents();
}

void CustomAutoPilotPlugin::_clearComponents()
{
    delete _sensorsComponent;
    _sensorsComponent = nullptr;
    delete _radioComponent;
    _radioComponent = nullptr;
    delete _flightModesComponent;
    _flightModesComponent = nullptr;
    delete _powerComponent;
    _powerComponent = nullptr;
    delete _safetyComponent;
    _safetyComponent = nullptr;
    delete _airframeComponent;
    _airframeComponent = nullptr;
    delete _motorComponent;
    _motorComponent = nullptr;
    delete _tuningComponent;
    _tuningComponent = nullptr;

    _components.clear();
}

void CustomAutoPilotPlugin::_advancedChanged(bool)
{
    _clearComponents();
    emit vehicleComponentsChanged();
}

const QVariantList &CustomAutoPilotPlugin::vehicleComponents()
{
    if (!_components.isEmpty() || _incorrectParameterVersion) {
        return _components;
    }

    if (!_vehicle) {
        qWarning() << "Internal error";
        return _components;
    }

    const bool showAdvanced = QGCCorePlugin::instance()->showAdvancedUI();
    if (!_vehicle->parameterManager()->parametersReady()) {
        qWarning() << "Call to vehicleComponents prior to parametersReady";
        return _components;
    }

    // Essential Setup Pages (Sensors, Radio, Flight Modes, Power, Safety)
    _sensorsComponent = new SensorsComponent(_vehicle, this);
    _sensorsComponent->setupTriggerSignals();
    _components.append(QVariant::fromValue(static_cast<VehicleComponent*>(_sensorsComponent)));

    _radioComponent = new PX4RadioComponent(_vehicle, this);
    _radioComponent->setupTriggerSignals();
    _components.append(QVariant::fromValue(static_cast<VehicleComponent*>(_radioComponent)));

    _flightModesComponent = new FlightModesComponent(_vehicle, this);
    _flightModesComponent->setupTriggerSignals();
    _components.append(QVariant::fromValue(static_cast<VehicleComponent*>(_flightModesComponent)));

    _powerComponent = new PowerComponent(_vehicle, this);
    _powerComponent->setupTriggerSignals();
    _components.append(QVariant::fromValue(static_cast<VehicleComponent*>(_powerComponent)));

    _safetyComponent = new SafetyComponent(_vehicle, this);
    _safetyComponent->setupTriggerSignals();
    _components.append(QVariant::fromValue(static_cast<VehicleComponent*>(_safetyComponent)));

    // Advanced Setup Pages (Airframe selection, Motor testing, PID Tuning)
    if (showAdvanced) {
        _airframeComponent = new AirframeComponent(_vehicle, this);
        _airframeComponent->setupTriggerSignals();
        _components.append(QVariant::fromValue(static_cast<VehicleComponent*>(_airframeComponent)));

        _motorComponent = new MotorComponent(_vehicle, this);
        _motorComponent->setupTriggerSignals();
        _components.append(QVariant::fromValue(static_cast<VehicleComponent*>(_motorComponent)));

        _tuningComponent = new PX4TuningComponent(_vehicle, this);
        _tuningComponent->setupTriggerSignals();
        _components.append(QVariant::fromValue(static_cast<VehicleComponent*>(_tuningComponent)));
    }

    return _components;
}
