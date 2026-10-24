#pragma once

#include <QtCore/QMap>
#include <QtCore/QObject>

class AutoPilotPlugin;
class FactMetaData;

/// \brief Collection of Parameter Facts for PX4 AutoPilot
class PX4AirframeLoader : public QObject
{
    Q_OBJECT

public:
    /// @param autopilot Autopilot which this set of facts is associated with
    PX4AirframeLoader(AutoPilotPlugin *autopilot, QObject *parent = nullptr);

    static void loadAirframeMetaData();

    /// @return Location of PX4 airframe fact meta data file
    static QString airframeMetaDataFile();

private:
    enum {
        XmlStateNone,
        XmlStateFoundAirframes,
        XmlStateFoundVersion,
        XmlStateFoundGroup,
        XmlStateFoundAirframe,
        XmlStateDone
    };

    static bool _airframeMetaDataLoaded;                                ///< true: parameter meta data already loaded
};
