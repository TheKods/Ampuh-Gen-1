import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import QGroundControl
import QGroundControl.FactControls
import QGroundControl.Controls

SettingsPage {
    objectName: "settingsPage_Telemetry"
    property real _stringFieldWidth: ScreenTools.defaultFontPixelWidth * 30

    function sectionVisible(index) {
        switch (index) {
        case 0: return (QGroundControl.settingsManager.mavlinkSettings.gcsMavlinkSystemID.userVisible || QGroundControl.settingsManager.mavlinkSettings.sendGCSHeartbeat.userVisible || QGroundControl.settingsManager.mavlinkSettings.noInitialDownloadWhenFlying.userVisible)
        case 1: return (QGroundControl.settingsManager.mavlinkSettings.forwardMavlink.userVisible || QGroundControl.settingsManager.mavlinkSettings.forwardMavlinkHostName.userVisible)
        case 2: return (QGroundControl.settingsManager.mavlinkSettings.telemetrySave.userVisible || QGroundControl.settingsManager.mavlinkSettings.telemetrySaveNotArmed.userVisible || QGroundControl.settingsManager.mavlinkSettings.saveCsvTelemetry.userVisible)
        case 3: return (QGroundControl.apmFirmwareSupported) && (QGroundControl.settingsManager.mavlinkSettings.apmStartMavlinkStreams.userVisible || QGroundControl.settingsManager.apmMavlinkStreamRateSettings.streamRateRawSensors.userVisible || QGroundControl.settingsManager.apmMavlinkStreamRateSettings.streamRateExtendedStatus.userVisible || QGroundControl.settingsManager.apmMavlinkStreamRateSettings.streamRateRCChannels.userVisible || QGroundControl.settingsManager.apmMavlinkStreamRateSettings.streamRatePosition.userVisible || QGroundControl.settingsManager.apmMavlinkStreamRateSettings.streamRateExtra1.userVisible || QGroundControl.settingsManager.apmMavlinkStreamRateSettings.streamRateExtra2.userVisible || QGroundControl.settingsManager.apmMavlinkStreamRateSettings.streamRateExtra3.userVisible)
        default: return true
        }
    }

    SettingsGroupLayout {
        objectName: "settingsGroup_GroundStation"
        Layout.fillWidth: true
        heading: qsTranslate("Telemetry.SettingsUI.json", "Ground Station")
        visible: (sectionFilter === -1 || sectionFilter === 0) && (QGroundControl.settingsManager.mavlinkSettings.gcsMavlinkSystemID.userVisible || QGroundControl.settingsManager.mavlinkSettings.sendGCSHeartbeat.userVisible || QGroundControl.settingsManager.mavlinkSettings.noInitialDownloadWhenFlying.userVisible)

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.mavlinkSettings.gcsMavlinkSystemID.userVisible

            LabelledFactTextField {
                label: fact.label
                Layout.fillWidth: true
                fact: QGroundControl.settingsManager.mavlinkSettings.gcsMavlinkSystemID
                objectName: "settingsTextField_gcsMavlinkSystemID"
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.mavlinkSettings.gcsMavlinkSystemID.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.mavlinkSettings.sendGCSHeartbeat.userVisible

            FactCheckBoxSlider {
                objectName: "settingsCheckBox_sendGCSHeartbeat"
                Layout.fillWidth: true
                text: fact.label
                fact: QGroundControl.settingsManager.mavlinkSettings.sendGCSHeartbeat
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.mavlinkSettings.sendGCSHeartbeat.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.mavlinkSettings.noInitialDownloadWhenFlying.userVisible

            FactCheckBoxSlider {
                objectName: "settingsCheckBox_noInitialDownloadWhenFlying"
                Layout.fillWidth: true
                text: fact.label
                fact: QGroundControl.settingsManager.mavlinkSettings.noInitialDownloadWhenFlying
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.mavlinkSettings.noInitialDownloadWhenFlying.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }
    }

    SettingsGroupLayout {
        objectName: "settingsGroup_MAVLinkForwarding"
        Layout.fillWidth: true
        heading: qsTranslate("Telemetry.SettingsUI.json", "MAVLink Forwarding")
        visible: (sectionFilter === -1 || sectionFilter === 1) && (QGroundControl.settingsManager.mavlinkSettings.forwardMavlink.userVisible || QGroundControl.settingsManager.mavlinkSettings.forwardMavlinkHostName.userVisible)

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.mavlinkSettings.forwardMavlink.userVisible

            FactCheckBoxSlider {
                objectName: "settingsCheckBox_forwardMavlink"
                Layout.fillWidth: true
                text: fact.label
                fact: QGroundControl.settingsManager.mavlinkSettings.forwardMavlink
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.mavlinkSettings.forwardMavlink.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.mavlinkSettings.forwardMavlinkHostName.userVisible

            LabelledFactTextField {
                label: fact.label
                Layout.fillWidth: true
                fact: QGroundControl.settingsManager.mavlinkSettings.forwardMavlinkHostName
                enabled: QGroundControl.settingsManager.mavlinkSettings.forwardMavlink.rawValue
                objectName: "settingsTextField_forwardMavlinkHostName"
                textFieldPreferredWidth: _stringFieldWidth
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.mavlinkSettings.forwardMavlinkHostName.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }
    }

    SettingsGroupLayout {
        objectName: "settingsGroup_Logging"
        Layout.fillWidth: true
        heading: qsTranslate("Telemetry.SettingsUI.json", "Logging")
        visible: (sectionFilter === -1 || sectionFilter === 2) && (QGroundControl.settingsManager.mavlinkSettings.telemetrySave.userVisible || QGroundControl.settingsManager.mavlinkSettings.telemetrySaveNotArmed.userVisible || QGroundControl.settingsManager.mavlinkSettings.saveCsvTelemetry.userVisible)

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.mavlinkSettings.telemetrySave.userVisible

            FactCheckBoxSlider {
                objectName: "settingsCheckBox_telemetrySave"
                Layout.fillWidth: true
                text: fact.label
                fact: QGroundControl.settingsManager.mavlinkSettings.telemetrySave
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.mavlinkSettings.telemetrySave.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.mavlinkSettings.telemetrySaveNotArmed.userVisible

            FactCheckBoxSlider {
                objectName: "settingsCheckBox_telemetrySaveNotArmed"
                Layout.fillWidth: true
                text: fact.label
                fact: QGroundControl.settingsManager.mavlinkSettings.telemetrySaveNotArmed
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.mavlinkSettings.telemetrySaveNotArmed.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.mavlinkSettings.saveCsvTelemetry.userVisible

            FactCheckBoxSlider {
                objectName: "settingsCheckBox_saveCsvTelemetry"
                Layout.fillWidth: true
                text: fact.label
                fact: QGroundControl.settingsManager.mavlinkSettings.saveCsvTelemetry
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.mavlinkSettings.saveCsvTelemetry.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }
    }

    SettingsGroupLayout {
        objectName: "settingsGroup_StreamRatesArduPilotOnly"
        Layout.fillWidth: true
        heading: qsTranslate("Telemetry.SettingsUI.json", "Stream Rates (ArduPilot Only)")
        visible: (sectionFilter === -1 || sectionFilter === 3) && (QGroundControl.apmFirmwareSupported) && (QGroundControl.settingsManager.mavlinkSettings.apmStartMavlinkStreams.userVisible || QGroundControl.settingsManager.apmMavlinkStreamRateSettings.streamRateRawSensors.userVisible || QGroundControl.settingsManager.apmMavlinkStreamRateSettings.streamRateExtendedStatus.userVisible || QGroundControl.settingsManager.apmMavlinkStreamRateSettings.streamRateRCChannels.userVisible || QGroundControl.settingsManager.apmMavlinkStreamRateSettings.streamRatePosition.userVisible || QGroundControl.settingsManager.apmMavlinkStreamRateSettings.streamRateExtra1.userVisible || QGroundControl.settingsManager.apmMavlinkStreamRateSettings.streamRateExtra2.userVisible || QGroundControl.settingsManager.apmMavlinkStreamRateSettings.streamRateExtra3.userVisible)

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.mavlinkSettings.apmStartMavlinkStreams.userVisible

            FactCheckBoxSlider {
                objectName: "settingsCheckBox_apmStartMavlinkStreams"
                Layout.fillWidth: true
                text: fact.label
                fact: QGroundControl.settingsManager.mavlinkSettings.apmStartMavlinkStreams
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.mavlinkSettings.apmStartMavlinkStreams.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.apmMavlinkStreamRateSettings.streamRateRawSensors.userVisible

            LabelledFactComboBox {
                label: fact.label
                Layout.fillWidth: true
                fact: QGroundControl.settingsManager.apmMavlinkStreamRateSettings.streamRateRawSensors
                indexModel: false
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.apmMavlinkStreamRateSettings.streamRateRawSensors.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.apmMavlinkStreamRateSettings.streamRateExtendedStatus.userVisible

            LabelledFactComboBox {
                label: fact.label
                Layout.fillWidth: true
                fact: QGroundControl.settingsManager.apmMavlinkStreamRateSettings.streamRateExtendedStatus
                indexModel: false
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.apmMavlinkStreamRateSettings.streamRateExtendedStatus.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.apmMavlinkStreamRateSettings.streamRateRCChannels.userVisible

            LabelledFactComboBox {
                label: fact.label
                Layout.fillWidth: true
                fact: QGroundControl.settingsManager.apmMavlinkStreamRateSettings.streamRateRCChannels
                indexModel: false
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.apmMavlinkStreamRateSettings.streamRateRCChannels.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.apmMavlinkStreamRateSettings.streamRatePosition.userVisible

            LabelledFactComboBox {
                label: fact.label
                Layout.fillWidth: true
                fact: QGroundControl.settingsManager.apmMavlinkStreamRateSettings.streamRatePosition
                indexModel: false
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.apmMavlinkStreamRateSettings.streamRatePosition.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.apmMavlinkStreamRateSettings.streamRateExtra1.userVisible

            LabelledFactComboBox {
                label: fact.label
                Layout.fillWidth: true
                fact: QGroundControl.settingsManager.apmMavlinkStreamRateSettings.streamRateExtra1
                indexModel: false
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.apmMavlinkStreamRateSettings.streamRateExtra1.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.apmMavlinkStreamRateSettings.streamRateExtra2.userVisible

            LabelledFactComboBox {
                label: fact.label
                Layout.fillWidth: true
                fact: QGroundControl.settingsManager.apmMavlinkStreamRateSettings.streamRateExtra2
                indexModel: false
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.apmMavlinkStreamRateSettings.streamRateExtra2.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.apmMavlinkStreamRateSettings.streamRateExtra3.userVisible

            LabelledFactComboBox {
                label: fact.label
                Layout.fillWidth: true
                fact: QGroundControl.settingsManager.apmMavlinkStreamRateSettings.streamRateExtra3
                indexModel: false
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.apmMavlinkStreamRateSettings.streamRateExtra3.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }
    }

    ColumnLayout {
        Layout.fillWidth: true
        spacing: 0
        visible: (sectionFilter === -1 || sectionFilter === 4)

        SigningKeyManager {
            Layout.fillWidth: true
        }
    }

    ColumnLayout {
        Layout.fillWidth: true
        spacing: 0
        visible: (sectionFilter === -1 || sectionFilter === 5)

        MavlinkLinkStatus {
            Layout.fillWidth: true
        }
    }
}
