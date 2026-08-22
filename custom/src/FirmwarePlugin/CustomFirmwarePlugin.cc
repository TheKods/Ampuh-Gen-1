#include "CustomFirmwarePlugin.h"
#include "CustomAutoPilotPlugin.h"
#include "px4_custom_mode.h"
#include "Vehicle.h"

CustomFirmwarePlugin::CustomFirmwarePlugin()
{
}

AutoPilotPlugin* CustomFirmwarePlugin::autopilotPlugin(Vehicle *vehicle) const
{
    return new CustomAutoPilotPlugin(vehicle, vehicle);
}

const QVariantList& CustomFirmwarePlugin::toolIndicators(const Vehicle *vehicle)
{
    if (_toolIndicatorList.size() == 0) {
        // First call the base class to get the standard QGC list.
        _toolIndicatorList = FirmwarePlugin::toolIndicators(vehicle);
    }

    return _toolIndicatorList;
}

bool CustomFirmwarePlugin::hasGimbal(Vehicle* /*vehicle*/, bool &rollSupported, bool &pitchSupported, bool &yawSupported) const
{
    rollSupported = false;
    pitchSupported = true;
    yawSupported = true;

    return true;
}

void CustomFirmwarePlugin::updateAvailableFlightModes(FlightModeList &modeList)
{
    for (auto &mode: modeList) {
        const PX4CustomMode::Mode cMode = static_cast<PX4CustomMode::Mode>(mode.custom_mode);
        mode.canBeSet = (cMode == PX4CustomMode::AUTO_LOITER) ||
                        (cMode == PX4CustomMode::AUTO_RTL) ||
                        (cMode == PX4CustomMode::AUTO_MISSION) ||
                        (cMode == PX4CustomMode::AUTO_TAKEOFF) ||
                        (cMode == PX4CustomMode::AUTO_LAND) ||
                        (cMode == PX4CustomMode::POSCTL_POSCTL) ||
                        (cMode == PX4CustomMode::ALTCTL) ||
                        (cMode == PX4CustomMode::MANUAL) ||
                        (cMode == PX4CustomMode::OFFBOARD);
    }

    // Let the base class do the standard airframe (fixed wing / multi rotor) classification
    // and update the internal flight mode lists.
    PX4FirmwarePlugin::updateAvailableFlightModes(modeList);
}
