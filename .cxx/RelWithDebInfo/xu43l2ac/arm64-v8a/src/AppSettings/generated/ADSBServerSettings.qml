import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import QGroundControl
import QGroundControl.FactControls
import QGroundControl.Controls

SettingsPage {
    objectName: "settingsPage_ADSBServer"
    property real _stringFieldWidth: ScreenTools.defaultFontPixelWidth * 30

    function sectionVisible(index) {
        switch (index) {
        case 0: return (QGroundControl.settingsManager.adsbVehicleManagerSettings.adsbServerConnectEnabled.userVisible || QGroundControl.settingsManager.adsbVehicleManagerSettings.adsbServerHostAddress.userVisible || QGroundControl.settingsManager.adsbVehicleManagerSettings.adsbServerPort.userVisible)
        default: return true
        }
    }

    SettingsGroupLayout {
        objectName: "settingsGroup_ADSBServer"
        Layout.fillWidth: true
        heading: qsTranslate("ADSBVehicleManager.SettingsUI.json", "ADSB Server")
        visible: (sectionFilter === -1 || sectionFilter === 0) && (QGroundControl.settingsManager.adsbVehicleManagerSettings.adsbServerConnectEnabled.userVisible || QGroundControl.settingsManager.adsbVehicleManagerSettings.adsbServerHostAddress.userVisible || QGroundControl.settingsManager.adsbVehicleManagerSettings.adsbServerPort.userVisible)

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.adsbVehicleManagerSettings.adsbServerConnectEnabled.userVisible

            FactCheckBoxSlider {
                objectName: "settingsCheckBox_adsbServerConnectEnabled"
                Layout.fillWidth: true
                text: fact.label
                fact: QGroundControl.settingsManager.adsbVehicleManagerSettings.adsbServerConnectEnabled
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.adsbVehicleManagerSettings.adsbServerConnectEnabled.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.adsbVehicleManagerSettings.adsbServerHostAddress.userVisible

            LabelledFactTextField {
                label: fact.label
                Layout.fillWidth: true
                fact: QGroundControl.settingsManager.adsbVehicleManagerSettings.adsbServerHostAddress
                objectName: "settingsTextField_adsbServerHostAddress"
                textFieldPreferredWidth: _stringFieldWidth
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.adsbVehicleManagerSettings.adsbServerHostAddress.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.adsbVehicleManagerSettings.adsbServerPort.userVisible

            LabelledFactTextField {
                label: fact.label
                Layout.fillWidth: true
                fact: QGroundControl.settingsManager.adsbVehicleManagerSettings.adsbServerPort
                objectName: "settingsTextField_adsbServerPort"
                textFieldPreferredWidth: _stringFieldWidth
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.adsbVehicleManagerSettings.adsbServerPort.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }
    }
}
