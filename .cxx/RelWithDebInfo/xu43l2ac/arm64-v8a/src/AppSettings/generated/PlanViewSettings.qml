import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import QGroundControl
import QGroundControl.FactControls
import QGroundControl.Controls

SettingsPage {
    objectName: "settingsPage_PlanView"

    function sectionVisible(index) {
        switch (index) {
        case 0: return (QGroundControl.settingsManager.appSettings.defaultMissionItemAltitude.userVisible || QGroundControl.settingsManager.planViewSettings.vtolTransitionDistance.userVisible || QGroundControl.settingsManager.planViewSettings.useConditionGate.userVisible || QGroundControl.settingsManager.planViewSettings.takeoffItemNotRequired.userVisible || QGroundControl.settingsManager.planViewSettings.allowMultipleLandingPatterns.userVisible)
        default: return true
        }
    }

    SettingsGroupLayout {
        objectName: "settingsGroup_General"
        Layout.fillWidth: true
        heading: qsTranslate("PlanView.SettingsUI.json", "General")
        visible: (sectionFilter === -1 || sectionFilter === 0) && (QGroundControl.settingsManager.appSettings.defaultMissionItemAltitude.userVisible || QGroundControl.settingsManager.planViewSettings.vtolTransitionDistance.userVisible || QGroundControl.settingsManager.planViewSettings.useConditionGate.userVisible || QGroundControl.settingsManager.planViewSettings.takeoffItemNotRequired.userVisible || QGroundControl.settingsManager.planViewSettings.allowMultipleLandingPatterns.userVisible)

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.appSettings.defaultMissionItemAltitude.userVisible

            LabelledFactTextField {
                label: fact.label
                Layout.fillWidth: true
                fact: QGroundControl.settingsManager.appSettings.defaultMissionItemAltitude
                objectName: "settingsTextField_defaultMissionItemAltitude"
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.appSettings.defaultMissionItemAltitude.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.planViewSettings.vtolTransitionDistance.userVisible

            LabelledFactTextField {
                label: fact.label
                Layout.fillWidth: true
                fact: QGroundControl.settingsManager.planViewSettings.vtolTransitionDistance
                objectName: "settingsTextField_vtolTransitionDistance"
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.planViewSettings.vtolTransitionDistance.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.planViewSettings.useConditionGate.userVisible

            FactCheckBoxSlider {
                objectName: "settingsCheckBox_useConditionGate"
                Layout.fillWidth: true
                text: fact.label
                fact: QGroundControl.settingsManager.planViewSettings.useConditionGate
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.planViewSettings.useConditionGate.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.planViewSettings.takeoffItemNotRequired.userVisible

            FactCheckBoxSlider {
                objectName: "settingsCheckBox_takeoffItemNotRequired"
                Layout.fillWidth: true
                text: fact.label
                fact: QGroundControl.settingsManager.planViewSettings.takeoffItemNotRequired
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.planViewSettings.takeoffItemNotRequired.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.planViewSettings.allowMultipleLandingPatterns.userVisible

            FactCheckBoxSlider {
                objectName: "settingsCheckBox_allowMultipleLandingPatterns"
                Layout.fillWidth: true
                text: fact.label
                fact: QGroundControl.settingsManager.planViewSettings.allowMultipleLandingPatterns
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.planViewSettings.allowMultipleLandingPatterns.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }
    }
}
