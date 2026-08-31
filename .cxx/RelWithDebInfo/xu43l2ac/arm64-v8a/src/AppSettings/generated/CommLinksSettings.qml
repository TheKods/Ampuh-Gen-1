import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import QGroundControl
import QGroundControl.FactControls
import QGroundControl.Controls

SettingsPage {
    objectName: "settingsPage_CommLinks"

    function sectionVisible(index) {
        switch (index) {
        case 2: return (QGroundControl.settingsManager.appSettings.androidUsePosixSerial.userVisible)
        case 3: return (QGroundControl.settingsManager.autoConnectSettings.userVisible) && (QGroundControl.settingsManager.autoConnectSettings.autoConnectPixhawk.userVisible || QGroundControl.settingsManager.autoConnectSettings.autoConnectSiKRadio.userVisible || QGroundControl.settingsManager.autoConnectSettings.autoConnectLibrePilot.userVisible || QGroundControl.settingsManager.autoConnectSettings.autoConnectUDP.userVisible || QGroundControl.settingsManager.autoConnectSettings.autoConnectRTKGPS.userVisible)
        default: return true
        }
    }

    ColumnLayout {
        Layout.fillWidth: true
        spacing: 0
        visible: (sectionFilter === -1 || sectionFilter === 0)

        LinkConfigurationManager {
            Layout.fillWidth: true
        }
    }

    ColumnLayout {
        Layout.fillWidth: true
        spacing: 0
        visible: (sectionFilter === -1 || sectionFilter === 1)

        NmeaGpsSettings {
            Layout.fillWidth: true
        }
    }

    SettingsGroupLayout {
        objectName: "settingsGroup_AndroidSerial"
        Layout.fillWidth: true
        heading: qsTranslate("CommLinks.SettingsUI.json", "Android Serial")
        visible: (sectionFilter === -1 || sectionFilter === 2) && (QGroundControl.settingsManager.appSettings.androidUsePosixSerial.userVisible)

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.appSettings.androidUsePosixSerial.userVisible

            FactCheckBoxSlider {
                objectName: "settingsCheckBox_androidUsePosixSerial"
                Layout.fillWidth: true
                text: fact.label
                fact: QGroundControl.settingsManager.appSettings.androidUsePosixSerial
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.appSettings.androidUsePosixSerial.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }
    }

    SettingsGroupLayout {
        objectName: "settingsGroup_AutoConnect"
        Layout.fillWidth: true
        heading: qsTranslate("CommLinks.SettingsUI.json", "AutoConnect")
        visible: (sectionFilter === -1 || sectionFilter === 3) && (QGroundControl.settingsManager.autoConnectSettings.userVisible) && (QGroundControl.settingsManager.autoConnectSettings.autoConnectPixhawk.userVisible || QGroundControl.settingsManager.autoConnectSettings.autoConnectSiKRadio.userVisible || QGroundControl.settingsManager.autoConnectSettings.autoConnectLibrePilot.userVisible || QGroundControl.settingsManager.autoConnectSettings.autoConnectUDP.userVisible || QGroundControl.settingsManager.autoConnectSettings.autoConnectRTKGPS.userVisible)

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.autoConnectSettings.autoConnectPixhawk.userVisible

            FactCheckBoxSlider {
                objectName: "settingsCheckBox_autoConnectPixhawk"
                Layout.fillWidth: true
                text: fact.label
                fact: QGroundControl.settingsManager.autoConnectSettings.autoConnectPixhawk
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.autoConnectSettings.autoConnectPixhawk.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.autoConnectSettings.autoConnectSiKRadio.userVisible

            FactCheckBoxSlider {
                objectName: "settingsCheckBox_autoConnectSiKRadio"
                Layout.fillWidth: true
                text: fact.label
                fact: QGroundControl.settingsManager.autoConnectSettings.autoConnectSiKRadio
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.autoConnectSettings.autoConnectSiKRadio.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.autoConnectSettings.autoConnectLibrePilot.userVisible

            FactCheckBoxSlider {
                objectName: "settingsCheckBox_autoConnectLibrePilot"
                Layout.fillWidth: true
                text: fact.label
                fact: QGroundControl.settingsManager.autoConnectSettings.autoConnectLibrePilot
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.autoConnectSettings.autoConnectLibrePilot.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.autoConnectSettings.autoConnectUDP.userVisible

            FactCheckBoxSlider {
                objectName: "settingsCheckBox_autoConnectUDP"
                Layout.fillWidth: true
                text: fact.label
                fact: QGroundControl.settingsManager.autoConnectSettings.autoConnectUDP
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.autoConnectSettings.autoConnectUDP.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.autoConnectSettings.autoConnectRTKGPS.userVisible

            FactCheckBoxSlider {
                objectName: "settingsCheckBox_autoConnectRTKGPS"
                Layout.fillWidth: true
                text: fact.label
                fact: QGroundControl.settingsManager.autoConnectSettings.autoConnectRTKGPS
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.autoConnectSettings.autoConnectRTKGPS.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }
    }
}
