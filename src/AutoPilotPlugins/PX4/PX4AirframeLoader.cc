#include "PX4AirframeLoader.h"
#include "AirframeComponentAirframes.h"
#include "AppMessages.h"
#include "AutoPilotPlugin.h"
#include "QGCLoggingCategory.h"

#include <QtCore/QDebug>
#include <QtCore/QDir>
#include <QtCore/QFile>
#include <QtCore/QFileInfo>
#include <QtCore/QSettings>
#include <QtCore/QXmlStreamReader>

QGC_LOGGING_CATEGORY(px4AirframeLoaderLog, "AutoPilotPlugins.PX4AirframeLoader")

bool PX4AirframeLoader::_airframeMetaDataLoaded = false;

PX4AirframeLoader::PX4AirframeLoader(AutoPilotPlugin *autopilot, QObject *parent)
    : QObject(parent)
{
    Q_UNUSED(autopilot);
}

QString PX4AirframeLoader::airframeMetaDataFile()
{
    QSettings settings;
    QDir parameterDir = QFileInfo(settings.fileName()).dir();
    return parameterDir.filePath(QStringLiteral("PX4AirframeFactMetaData.xml"));
}

/// Load Airframe Fact meta data
///
/// The meta data comes from firmware airframes.xml file.
void PX4AirframeLoader::loadAirframeMetaData()
{
    if (_airframeMetaDataLoaded) {
        return;
    }

    qCDebug(px4AirframeLoaderLog) << "Loading PX4 airframe fact meta data";

    if (AirframeComponentAirframes::get().count() != 0) {
        qCWarning(px4AirframeLoaderLog) << "Internal error";
        return;
    }

    QString airframeFilename;

    // We want unit test builds to always use the resource based meta data to provide repeatable results
    if (!QGC::runningUnitTests()) {
        // First look for meta data that comes from a firmware download. Fall back to resource if not there.
        airframeFilename = airframeMetaDataFile();
    }
    if (airframeFilename.isEmpty() || !QFile(airframeFilename).exists()) {
        airframeFilename = QStringLiteral(":/AutoPilotPlugins/PX4/AirframeFactMetaData.xml");
    }

    qCDebug(px4AirframeLoaderLog) << "Loading meta data file:" << airframeFilename;

    QFile xmlFile(airframeFilename);
    if (!xmlFile.exists()) {
        qCWarning(px4AirframeLoaderLog) << "Internal error";
        return;
    }

    const bool success = xmlFile.open(QIODevice::ReadOnly);

    if (!success) {
        qCWarning(px4AirframeLoaderLog) << "Failed opening airframe XML";
        return;
    }

    QXmlStreamReader xml(xmlFile.readAll());
    xmlFile.close();
    if (xml.hasError()) {
        qCWarning(px4AirframeLoaderLog) << "Badly formed XML" << xml.errorString();
        return;
    }

    QString airframeGroup;
    QString image;
    int xmlState = XmlStateNone;

    while (!xml.atEnd()) {
        if (xml.isStartElement()) {
            QString elementName = xml.name().toString();

            if (elementName == QStringLiteral("airframes")) {
                if (xmlState != XmlStateNone) {
                    qCWarning(px4AirframeLoaderLog) << "Badly formed XML";
                    return;
                }
                xmlState = XmlStateFoundAirframes;

            } else if (elementName == QStringLiteral("version")) {
                if (xmlState != XmlStateFoundAirframes) {
                    qCWarning(px4AirframeLoaderLog) << "Badly formed XML";
                    return;
                }
                xmlState = XmlStateFoundVersion;

                bool convertOk = false;
                QString strVersion = xml.readElementText();
                int intVersion = strVersion.toInt(&convertOk);
                if (!convertOk) {
                    qCWarning(px4AirframeLoaderLog) << "Badly formed XML";
                    return;
                }
                if (intVersion < 1) {
                    // We can't read these old files
                    qDebug() << "Airframe version stamp too old, skipping load. Found:" << intVersion << "Want: 3 File:" << airframeFilename;
                    return;
                }

            } else if (elementName == QStringLiteral("airframe_version_major")) {
                // Just skip over for now
            } else if (elementName == QStringLiteral("airframe_version_minor")) {
                // Just skip over for now

            } else if (elementName == QStringLiteral("airframe_group")) {
                if (xmlState != XmlStateFoundVersion) {
                    // We didn't get a version stamp, assume older version we can't read
                    qDebug() << "Parameter version stamp not found, skipping load" << airframeFilename;
                    return;
                }
                xmlState = XmlStateFoundGroup;

                if (!xml.attributes().hasAttribute(QStringLiteral("name")) || !xml.attributes().hasAttribute(QStringLiteral("image"))) {
                    qCWarning(px4AirframeLoaderLog) << "Badly formed XML";
                    return;
                }
                airframeGroup = xml.attributes().value(QStringLiteral("name")).toString();
                image = xml.attributes().value(QStringLiteral("image")).toString();
                qCDebug(px4AirframeLoaderLog) << "Found group: " << airframeGroup << " image:" << image;

            } else if (elementName == QStringLiteral("airframe")) {
                if (xmlState != XmlStateFoundGroup) {
                    qCWarning(px4AirframeLoaderLog) << "Badly formed XML";
                    return;
                }
                xmlState = XmlStateFoundAirframe;

                if (!xml.attributes().hasAttribute(QStringLiteral("name")) || !xml.attributes().hasAttribute(QStringLiteral("id"))) {
                    qCWarning(px4AirframeLoaderLog) << "Badly formed XML";
                    return;
                }

                QString name = xml.attributes().value(QStringLiteral("name")).toString();
                QString id = xml.attributes().value(QStringLiteral("id")).toString();

                qCDebug(px4AirframeLoaderLog) << "Found airframe name:" << name << " type:" << airframeGroup << " id:" << id;

                // Now that we know type we can airframe meta data object and add it to the system
                AirframeComponentAirframes::insert(airframeGroup, image, name, id.toInt());

            } else {
                // We should be getting meta data now
                if (xmlState != XmlStateFoundAirframe) {
                    qCWarning(px4AirframeLoaderLog) << "Badly formed XML";
                    return;
                }
            }
        } else if (xml.isEndElement()) {
            QString elementName = xml.name().toString();

            if (elementName == QStringLiteral("airframe")) {
                // Reset for next airframe
                xmlState = XmlStateFoundGroup;
            } else if (elementName == "airframe_group") {
                xmlState = XmlStateFoundVersion;
            } else if (elementName == "airframes") {
                xmlState = XmlStateFoundAirframes;
            }
        }
        xml.readNext();
    }

    _airframeMetaDataLoaded = true;
}
