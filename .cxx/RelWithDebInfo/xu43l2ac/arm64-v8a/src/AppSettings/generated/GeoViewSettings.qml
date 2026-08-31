import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import QGroundControl
import QGroundControl.FactControls
import QGroundControl.Controls

SettingsPage {
    objectName: "settingsPage_GeoView"

    function sectionVisible(index) {
        switch (index) {
        case 0: return (QGroundControl.settingsManager.geoViewSettings.enabled.userVisible)
        default: return true
        }
    }

    SettingsGroupLayout {
        objectName: "settingsGroup_General"
        Layout.fillWidth: true
        heading: qsTranslate("GeoView.SettingsUI.json", "General")
        visible: (sectionFilter === -1 || sectionFilter === 0) && (QGroundControl.settingsManager.geoViewSettings.enabled.userVisible)

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.geoViewSettings.enabled.userVisible

            FactCheckBoxSlider {
                objectName: "settingsCheckBox_enabled"
                Layout.fillWidth: true
                text: fact.label
                fact: QGroundControl.settingsManager.geoViewSettings.enabled
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.geoViewSettings.enabled.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }
    }
}
