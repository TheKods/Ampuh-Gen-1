import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import QGroundControl
import QGroundControl.FactControls
import QGroundControl.Controls

SettingsPage {
    objectName: "settingsPage_FlyView"
    property var hasChecklist: QGroundControl.corePlugin.options.preFlightChecklistUrl.toString().length
    property var useChecklistValue: QGroundControl.settingsManager.appSettings.useChecklist.value
    property var virtualJoystickOn: QGroundControl.settingsManager.appSettings.virtualJoystick.rawValue

    function sectionVisible(index) {
        switch (index) {
        case 0: return (QGroundControl.settingsManager.appSettings.useChecklist.userVisible || QGroundControl.settingsManager.appSettings.enforceChecklist.userVisible || QGroundControl.settingsManager.appSettings.enableMultiVehiclePanel.userVisible || QGroundControl.settingsManager.flyViewSettings.keepMapCenteredOnVehicle.userVisible || QGroundControl.settingsManager.flyViewSettings.showLogReplayStatusBar.userVisible || QGroundControl.settingsManager.flyViewSettings.showSimpleCameraControl.userVisible || QGroundControl.settingsManager.flyViewSettings.updateHomePosition.userVisible || QGroundControl.settingsManager.flyViewSettings.enableAutomaticMissionPopups.userVisible)
        case 1: return (QGroundControl.settingsManager.flyViewSettings.guidedMinimumAltitude.userVisible || QGroundControl.settingsManager.flyViewSettings.guidedMaximumAltitude.userVisible || QGroundControl.settingsManager.flyViewSettings.maxGoToLocationDistance.userVisible || QGroundControl.settingsManager.flyViewSettings.forwardFlightGoToLocationLoiterRad.userVisible || QGroundControl.settingsManager.flyViewSettings.goToLocationRequiresConfirmInGuided.userVisible)
        case 3: return (QGroundControl.settingsManager.appSettings.virtualJoystick.userVisible || QGroundControl.settingsManager.appSettings.virtualJoystickAutoCenterThrottle.userVisible || QGroundControl.settingsManager.appSettings.virtualJoystickLeftHandedMode.userVisible)
        case 4: return (QGroundControl.settingsManager.flyViewSettings.showAdditionalIndicatorsCompass.userVisible || QGroundControl.settingsManager.flyViewSettings.lockNoseUpCompass.userVisible || QGroundControl.settingsManager.flyViewSettings.instrumentQmlFile2.userVisible)
        default: return true
        }
    }

    SettingsGroupLayout {
        objectName: "settingsGroup_General"
        Layout.fillWidth: true
        heading: qsTranslate("FlyView.SettingsUI.json", "General")
        visible: (sectionFilter === -1 || sectionFilter === 0) && (QGroundControl.settingsManager.appSettings.useChecklist.userVisible || QGroundControl.settingsManager.appSettings.enforceChecklist.userVisible || QGroundControl.settingsManager.appSettings.enableMultiVehiclePanel.userVisible || QGroundControl.settingsManager.flyViewSettings.keepMapCenteredOnVehicle.userVisible || QGroundControl.settingsManager.flyViewSettings.showLogReplayStatusBar.userVisible || QGroundControl.settingsManager.flyViewSettings.showSimpleCameraControl.userVisible || QGroundControl.settingsManager.flyViewSettings.updateHomePosition.userVisible || QGroundControl.settingsManager.flyViewSettings.enableAutomaticMissionPopups.userVisible)

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: (hasChecklist) && QGroundControl.settingsManager.appSettings.useChecklist.userVisible

            FactCheckBoxSlider {
                objectName: "settingsCheckBox_useChecklist"
                Layout.fillWidth: true
                text: fact.label
                fact: QGroundControl.settingsManager.appSettings.useChecklist
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.appSettings.useChecklist.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: (hasChecklist && QGroundControl.settingsManager.appSettings.useChecklist.userVisible) && QGroundControl.settingsManager.appSettings.enforceChecklist.userVisible

            FactCheckBoxSlider {
                objectName: "settingsCheckBox_enforceChecklist"
                Layout.fillWidth: true
                text: fact.label
                fact: QGroundControl.settingsManager.appSettings.enforceChecklist
                enabled: useChecklistValue
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.appSettings.enforceChecklist.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.appSettings.enableMultiVehiclePanel.userVisible

            FactCheckBoxSlider {
                objectName: "settingsCheckBox_enableMultiVehiclePanel"
                Layout.fillWidth: true
                text: fact.label
                fact: QGroundControl.settingsManager.appSettings.enableMultiVehiclePanel
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.appSettings.enableMultiVehiclePanel.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.flyViewSettings.keepMapCenteredOnVehicle.userVisible

            FactCheckBoxSlider {
                objectName: "settingsCheckBox_keepMapCenteredOnVehicle"
                Layout.fillWidth: true
                text: fact.label
                fact: QGroundControl.settingsManager.flyViewSettings.keepMapCenteredOnVehicle
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.flyViewSettings.keepMapCenteredOnVehicle.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.flyViewSettings.showLogReplayStatusBar.userVisible

            FactCheckBoxSlider {
                objectName: "settingsCheckBox_showLogReplayStatusBar"
                Layout.fillWidth: true
                text: fact.label
                fact: QGroundControl.settingsManager.flyViewSettings.showLogReplayStatusBar
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.flyViewSettings.showLogReplayStatusBar.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.flyViewSettings.showSimpleCameraControl.userVisible

            FactCheckBoxSlider {
                objectName: "settingsCheckBox_showSimpleCameraControl"
                Layout.fillWidth: true
                text: fact.label
                fact: QGroundControl.settingsManager.flyViewSettings.showSimpleCameraControl
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.flyViewSettings.showSimpleCameraControl.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.flyViewSettings.updateHomePosition.userVisible

            FactCheckBoxSlider {
                objectName: "settingsCheckBox_updateHomePosition"
                Layout.fillWidth: true
                text: fact.label
                fact: QGroundControl.settingsManager.flyViewSettings.updateHomePosition
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.flyViewSettings.updateHomePosition.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.flyViewSettings.enableAutomaticMissionPopups.userVisible

            FactCheckBoxSlider {
                objectName: "settingsCheckBox_enableAutomaticMissionPopups"
                Layout.fillWidth: true
                text: fact.label
                fact: QGroundControl.settingsManager.flyViewSettings.enableAutomaticMissionPopups
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.flyViewSettings.enableAutomaticMissionPopups.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }
    }

    SettingsGroupLayout {
        objectName: "settingsGroup_GuidedCommands"
        Layout.fillWidth: true
        heading: qsTranslate("FlyView.SettingsUI.json", "Guided Commands")
        visible: (sectionFilter === -1 || sectionFilter === 1) && (QGroundControl.settingsManager.flyViewSettings.guidedMinimumAltitude.userVisible || QGroundControl.settingsManager.flyViewSettings.guidedMaximumAltitude.userVisible || QGroundControl.settingsManager.flyViewSettings.maxGoToLocationDistance.userVisible || QGroundControl.settingsManager.flyViewSettings.forwardFlightGoToLocationLoiterRad.userVisible || QGroundControl.settingsManager.flyViewSettings.goToLocationRequiresConfirmInGuided.userVisible)

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.flyViewSettings.guidedMinimumAltitude.userVisible

            LabelledFactTextField {
                label: fact.label
                Layout.fillWidth: true
                fact: QGroundControl.settingsManager.flyViewSettings.guidedMinimumAltitude
                objectName: "settingsTextField_guidedMinimumAltitude"
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.flyViewSettings.guidedMinimumAltitude.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.flyViewSettings.guidedMaximumAltitude.userVisible

            LabelledFactTextField {
                label: fact.label
                Layout.fillWidth: true
                fact: QGroundControl.settingsManager.flyViewSettings.guidedMaximumAltitude
                objectName: "settingsTextField_guidedMaximumAltitude"
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.flyViewSettings.guidedMaximumAltitude.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.flyViewSettings.maxGoToLocationDistance.userVisible

            LabelledFactTextField {
                label: fact.label
                Layout.fillWidth: true
                fact: QGroundControl.settingsManager.flyViewSettings.maxGoToLocationDistance
                objectName: "settingsTextField_maxGoToLocationDistance"
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.flyViewSettings.maxGoToLocationDistance.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.flyViewSettings.forwardFlightGoToLocationLoiterRad.userVisible

            LabelledFactTextField {
                label: fact.label
                Layout.fillWidth: true
                fact: QGroundControl.settingsManager.flyViewSettings.forwardFlightGoToLocationLoiterRad
                objectName: "settingsTextField_forwardFlightGoToLocationLoiterRad"
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.flyViewSettings.forwardFlightGoToLocationLoiterRad.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.flyViewSettings.goToLocationRequiresConfirmInGuided.userVisible

            FactCheckBoxSlider {
                objectName: "settingsCheckBox_goToLocationRequiresConfirmInGuided"
                Layout.fillWidth: true
                text: fact.label
                fact: QGroundControl.settingsManager.flyViewSettings.goToLocationRequiresConfirmInGuided
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.flyViewSettings.goToLocationRequiresConfirmInGuided.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }
    }

    ColumnLayout {
        Layout.fillWidth: true
        spacing: 0
        visible: (sectionFilter === -1 || sectionFilter === 2)

        MavlinkActionSettings {
            Layout.fillWidth: true
        }
    }

    SettingsGroupLayout {
        objectName: "settingsGroup_VirtualJoystick"
        Layout.fillWidth: true
        heading: qsTranslate("FlyView.SettingsUI.json", "Virtual Joystick")
        visible: (sectionFilter === -1 || sectionFilter === 3) && (QGroundControl.settingsManager.appSettings.virtualJoystick.userVisible || QGroundControl.settingsManager.appSettings.virtualJoystickAutoCenterThrottle.userVisible || QGroundControl.settingsManager.appSettings.virtualJoystickLeftHandedMode.userVisible)

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.appSettings.virtualJoystick.userVisible

            FactCheckBoxSlider {
                objectName: "settingsCheckBox_virtualJoystick"
                Layout.fillWidth: true
                text: fact.label
                fact: QGroundControl.settingsManager.appSettings.virtualJoystick
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.appSettings.virtualJoystick.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.appSettings.virtualJoystickAutoCenterThrottle.userVisible

            FactCheckBoxSlider {
                objectName: "settingsCheckBox_virtualJoystickAutoCenterThrottle"
                Layout.fillWidth: true
                text: fact.label
                fact: QGroundControl.settingsManager.appSettings.virtualJoystickAutoCenterThrottle
                enabled: virtualJoystickOn
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.appSettings.virtualJoystickAutoCenterThrottle.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.appSettings.virtualJoystickLeftHandedMode.userVisible

            FactCheckBoxSlider {
                objectName: "settingsCheckBox_virtualJoystickLeftHandedMode"
                Layout.fillWidth: true
                text: fact.label
                fact: QGroundControl.settingsManager.appSettings.virtualJoystickLeftHandedMode
                enabled: virtualJoystickOn
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.appSettings.virtualJoystickLeftHandedMode.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }
    }

    SettingsGroupLayout {
        objectName: "settingsGroup_InstrumentPanel"
        Layout.fillWidth: true
        heading: qsTranslate("FlyView.SettingsUI.json", "Instrument Panel")
        visible: (sectionFilter === -1 || sectionFilter === 4) && (QGroundControl.settingsManager.flyViewSettings.showAdditionalIndicatorsCompass.userVisible || QGroundControl.settingsManager.flyViewSettings.lockNoseUpCompass.userVisible || QGroundControl.settingsManager.flyViewSettings.instrumentQmlFile2.userVisible)

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.flyViewSettings.showAdditionalIndicatorsCompass.userVisible

            FactCheckBoxSlider {
                objectName: "settingsCheckBox_showAdditionalIndicatorsCompass"
                Layout.fillWidth: true
                text: fact.label
                fact: QGroundControl.settingsManager.flyViewSettings.showAdditionalIndicatorsCompass
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.flyViewSettings.showAdditionalIndicatorsCompass.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.flyViewSettings.lockNoseUpCompass.userVisible

            FactCheckBoxSlider {
                objectName: "settingsCheckBox_lockNoseUpCompass"
                Layout.fillWidth: true
                text: fact.label
                fact: QGroundControl.settingsManager.flyViewSettings.lockNoseUpCompass
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.flyViewSettings.lockNoseUpCompass.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.flyViewSettings.instrumentQmlFile2.userVisible

            LabelledFactComboBox {
                label: fact.label
                Layout.fillWidth: true
                fact: QGroundControl.settingsManager.flyViewSettings.instrumentQmlFile2
                indexModel: false
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.flyViewSettings.instrumentQmlFile2.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }
    }
}
