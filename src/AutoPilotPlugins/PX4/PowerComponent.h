#pragma once

#include "VehicleComponent.h"

class PowerComponent : public VehicleComponent
{
    Q_OBJECT

public:
    PowerComponent(Vehicle *vehicle, AutoPilotPlugin *autopilot, QObject *parent = nullptr);

    // Overrides from VehicleComponent
    QStringList setupCompleteChangedTriggerList() const override;

    // Overrides from VehicleComponent
    QString name() const override;
    QString description() const override;
    QString iconResource() const override;
    bool requiresSetup() const override;
    bool setupComplete() const override;
    QUrl setupSource() const override;
    QUrl summaryQmlSource() const override;
    QString vehicleConfigJson() const override;
    bool allowSetupWhileArmed() const override { return true; }

private:
    const QString _name;
    QVariantList _summaryItems;
};
