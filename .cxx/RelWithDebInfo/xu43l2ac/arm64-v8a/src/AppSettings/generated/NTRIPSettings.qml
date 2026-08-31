import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import QGroundControl
import QGroundControl.FactControls
import QGroundControl.Controls

SettingsPage {
    objectName: "settingsPage_NTRIPRTK"
    property real _stringFieldWidth: ScreenTools.defaultFontPixelWidth * 30

    function sectionVisible(index) {
        switch (index) {
        case 3: return (QGroundControl.settingsManager.ntripSettings.ntripGgaPositionSource.userVisible || QGroundControl.settingsManager.ntripSettings.ntripGgaIntervalSec.userVisible)
        case 4: return (QGroundControl.settingsManager.ntripSettings.ntripWhitelist.userVisible)
        case 5: return (QGroundControl.settingsManager.ntripSettings.ntripUdpForwardEnabled.userVisible || QGroundControl.settingsManager.ntripSettings.ntripUdpTargetAddress.userVisible || QGroundControl.settingsManager.ntripSettings.ntripUdpTargetPort.userVisible)
        case 6: return (QGroundControl.settingsManager.ntripSettings.rtcmUdpInputEnabled.userVisible || QGroundControl.settingsManager.ntripSettings.rtcmUdpInputPort.userVisible || QGroundControl.settingsManager.ntripSettings.rtcmUdpValidate.userVisible)
        default: return true
        }
    }

    ColumnLayout {
        Layout.fillWidth: true
        spacing: 0
        visible: (sectionFilter === -1 || sectionFilter === 0)

        NtripConnectionSettings {
            Layout.fillWidth: true
        }
    }

    ColumnLayout {
        Layout.fillWidth: true
        spacing: 0
        visible: (sectionFilter === -1 || sectionFilter === 1)

        NtripServerSettings {
            Layout.fillWidth: true
        }
    }

    ColumnLayout {
        Layout.fillWidth: true
        spacing: 0
        visible: (sectionFilter === -1 || sectionFilter === 2)

        NtripMountpointBrowser {
            Layout.fillWidth: true
        }
    }

    SettingsGroupLayout {
        objectName: "settingsGroup_GGAPositionReporting"
        Layout.fillWidth: true
        heading: qsTranslate("NTRIP.SettingsUI.json", "GGA Position Reporting")
        visible: (sectionFilter === -1 || sectionFilter === 3) && (QGroundControl.settingsManager.ntripSettings.ntripGgaPositionSource.userVisible || QGroundControl.settingsManager.ntripSettings.ntripGgaIntervalSec.userVisible)

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.ntripSettings.ntripGgaPositionSource.userVisible

            LabelledFactComboBox {
                label: fact.label
                Layout.fillWidth: true
                fact: QGroundControl.settingsManager.ntripSettings.ntripGgaPositionSource
                indexModel: false
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.ntripSettings.ntripGgaPositionSource.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.ntripSettings.ntripGgaIntervalSec.userVisible

            LabelledFactTextField {
                label: fact.label
                Layout.fillWidth: true
                fact: QGroundControl.settingsManager.ntripSettings.ntripGgaIntervalSec
                objectName: "settingsTextField_ntripGgaIntervalSec"
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.ntripSettings.ntripGgaIntervalSec.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }
    }

    SettingsGroupLayout {
        objectName: "settingsGroup_Options"
        Layout.fillWidth: true
        heading: qsTranslate("NTRIP.SettingsUI.json", "Options")
        visible: (sectionFilter === -1 || sectionFilter === 4) && (QGroundControl.settingsManager.ntripSettings.ntripWhitelist.userVisible)

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.ntripSettings.ntripWhitelist.userVisible

            LabelledFactTextField {
                label: fact.label
                Layout.fillWidth: true
                fact: QGroundControl.settingsManager.ntripSettings.ntripWhitelist
                textField.placeholderText: qsTranslate("NTRIP.SettingsUI.json", "e.g. 1005,1077,1087")
                objectName: "settingsTextField_ntripWhitelist"
                textFieldPreferredWidth: _stringFieldWidth
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.ntripSettings.ntripWhitelist.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }
    }

    SettingsGroupLayout {
        objectName: "settingsGroup_UDPForwarding"
        Layout.fillWidth: true
        heading: qsTranslate("NTRIP.SettingsUI.json", "UDP Forwarding")
        visible: (sectionFilter === -1 || sectionFilter === 5) && (QGroundControl.settingsManager.ntripSettings.ntripUdpForwardEnabled.userVisible || QGroundControl.settingsManager.ntripSettings.ntripUdpTargetAddress.userVisible || QGroundControl.settingsManager.ntripSettings.ntripUdpTargetPort.userVisible)

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.ntripSettings.ntripUdpForwardEnabled.userVisible

            FactCheckBoxSlider {
                objectName: "settingsCheckBox_ntripUdpForwardEnabled"
                Layout.fillWidth: true
                text: fact.label
                fact: QGroundControl.settingsManager.ntripSettings.ntripUdpForwardEnabled
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.ntripSettings.ntripUdpForwardEnabled.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.ntripSettings.ntripUdpTargetAddress.userVisible

            LabelledFactTextField {
                label: fact.label
                Layout.fillWidth: true
                fact: QGroundControl.settingsManager.ntripSettings.ntripUdpTargetAddress
                enabled: QGroundControl.settingsManager.ntripSettings.ntripUdpForwardEnabled.rawValue
                objectName: "settingsTextField_ntripUdpTargetAddress"
                textFieldPreferredWidth: _stringFieldWidth
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.ntripSettings.ntripUdpTargetAddress.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.ntripSettings.ntripUdpTargetPort.userVisible

            LabelledFactTextField {
                label: fact.label
                Layout.fillWidth: true
                fact: QGroundControl.settingsManager.ntripSettings.ntripUdpTargetPort
                enabled: QGroundControl.settingsManager.ntripSettings.ntripUdpForwardEnabled.rawValue
                objectName: "settingsTextField_ntripUdpTargetPort"
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.ntripSettings.ntripUdpTargetPort.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }
    }

    SettingsGroupLayout {
        objectName: "settingsGroup_UDPRTCMInput"
        Layout.fillWidth: true
        heading: qsTranslate("NTRIP.SettingsUI.json", "UDP RTCM Input")
        visible: (sectionFilter === -1 || sectionFilter === 6) && (QGroundControl.settingsManager.ntripSettings.rtcmUdpInputEnabled.userVisible || QGroundControl.settingsManager.ntripSettings.rtcmUdpInputPort.userVisible || QGroundControl.settingsManager.ntripSettings.rtcmUdpValidate.userVisible)

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.ntripSettings.rtcmUdpInputEnabled.userVisible

            FactCheckBoxSlider {
                objectName: "settingsCheckBox_rtcmUdpInputEnabled"
                Layout.fillWidth: true
                text: fact.label
                fact: QGroundControl.settingsManager.ntripSettings.rtcmUdpInputEnabled
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.ntripSettings.rtcmUdpInputEnabled.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.ntripSettings.rtcmUdpInputPort.userVisible

            LabelledFactTextField {
                label: fact.label
                Layout.fillWidth: true
                fact: QGroundControl.settingsManager.ntripSettings.rtcmUdpInputPort
                enabled: QGroundControl.settingsManager.ntripSettings.rtcmUdpInputEnabled.rawValue
                objectName: "settingsTextField_rtcmUdpInputPort"
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.ntripSettings.rtcmUdpInputPort.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.ntripSettings.rtcmUdpValidate.userVisible

            FactCheckBoxSlider {
                objectName: "settingsCheckBox_rtcmUdpValidate"
                Layout.fillWidth: true
                text: fact.label
                fact: QGroundControl.settingsManager.ntripSettings.rtcmUdpValidate
                enabled: QGroundControl.settingsManager.ntripSettings.rtcmUdpInputEnabled.rawValue
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.ntripSettings.rtcmUdpValidate.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }
    }
}
