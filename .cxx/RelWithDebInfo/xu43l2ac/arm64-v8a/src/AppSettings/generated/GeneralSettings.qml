import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import QGroundControl
import QGroundControl.FactControls
import QGroundControl.Controls

SettingsPage {
    objectName: "settingsPage_General"
    property real _stringFieldWidth: ScreenTools.defaultFontPixelWidth * 30
    property var _appSettings: QGroundControl.settingsManager.appSettings

    function sectionVisible(index) {
        switch (index) {
        case 0: return (QGroundControl.settingsManager.appSettings.qLocaleLanguage.userVisible || QGroundControl.settingsManager.appSettings.indoorPalette.userVisible || QGroundControl.settingsManager.appSettings.followTarget.userVisible || QGroundControl.settingsManager.appSettings.audioVolume.userVisible || QGroundControl.settingsManager.appSettings.androidDontSaveToSDCard.userVisible || QGroundControl.settingsManager.appSettings.uiScalePercent.userVisible || QGroundControl.settingsManager.appSettings.savePath.userVisible || QGroundControl.settingsManager.appSettings.clearSettingsNextBoot.userVisible)
        case 1: return (QGroundControl.settingsManager.appSettings.preferredFirmwareClass.userVisible || QGroundControl.settingsManager.appSettings.preferredVehicleClass.userVisible)
        case 2: return (QGroundControl.settingsManager.unitsSettings.userVisible) && (QGroundControl.settingsManager.unitsSettings.horizontalDistanceUnits.userVisible || QGroundControl.settingsManager.unitsSettings.verticalDistanceUnits.userVisible || QGroundControl.settingsManager.unitsSettings.areaUnits.userVisible || QGroundControl.settingsManager.unitsSettings.speedUnits.userVisible || QGroundControl.settingsManager.unitsSettings.temperatureUnits.userVisible)
        default: return true
        }
    }

    SettingsGroupLayout {
        objectName: "settingsGroup_General"
        Layout.fillWidth: true
        heading: qsTranslate("General.SettingsUI.json", "General")
        visible: (sectionFilter === -1 || sectionFilter === 0) && (QGroundControl.settingsManager.appSettings.qLocaleLanguage.userVisible || QGroundControl.settingsManager.appSettings.indoorPalette.userVisible || QGroundControl.settingsManager.appSettings.followTarget.userVisible || QGroundControl.settingsManager.appSettings.audioVolume.userVisible || QGroundControl.settingsManager.appSettings.androidDontSaveToSDCard.userVisible || QGroundControl.settingsManager.appSettings.uiScalePercent.userVisible || QGroundControl.settingsManager.appSettings.savePath.userVisible || QGroundControl.settingsManager.appSettings.clearSettingsNextBoot.userVisible)

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.appSettings.qLocaleLanguage.userVisible

            LabelledFactComboBox {
                label: fact.label
                Layout.fillWidth: true
                fact: QGroundControl.settingsManager.appSettings.qLocaleLanguage
                indexModel: false
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.appSettings.qLocaleLanguage.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.appSettings.indoorPalette.userVisible

            LabelledFactComboBox {
                label: fact.label
                Layout.fillWidth: true
                fact: QGroundControl.settingsManager.appSettings.indoorPalette
                indexModel: false
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.appSettings.indoorPalette.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.appSettings.followTarget.userVisible

            LabelledFactComboBox {
                label: fact.label
                Layout.fillWidth: true
                fact: QGroundControl.settingsManager.appSettings.followTarget
                indexModel: false
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.appSettings.followTarget.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.appSettings.audioVolume.userVisible

            RowLayout {
                Layout.fillWidth: true
                spacing: ScreenTools.defaultFontPixelWidth
                FactTextFieldSlider {
                    Layout.fillWidth: true
                    label: fact.label
                    fact: QGroundControl.settingsManager.appSettings.audioVolume
                    showEnableCheckbox: true
                    enableCheckBoxChecked: !_appSettings.audioMuted.rawValue
                    onEnableCheckboxClicked: { if (enableCheckBoxChecked && _appSettings.audioVolume.rawValue <= 0) _appSettings.audioVolume.rawValue = 75; _appSettings.audioMuted.rawValue = !enableCheckBoxChecked }
                }
                QGCButton {
                    text: qsTranslate("General.SettingsUI.json", "Test")
                    onClicked: QGroundControl.testAudioOutput()
                    enabled: !_appSettings.audioMuted.rawValue && _appSettings.audioVolume.rawValue > 0
                }
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.appSettings.audioVolume.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: (ScreenTools.isMobile) && QGroundControl.settingsManager.appSettings.androidDontSaveToSDCard.userVisible

            FactCheckBoxSlider {
                objectName: "settingsCheckBox_androidDontSaveToSDCard"
                Layout.fillWidth: true
                text: fact.label
                fact: QGroundControl.settingsManager.appSettings.androidDontSaveToSDCard
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.appSettings.androidDontSaveToSDCard.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.appSettings.uiScalePercent.userVisible

            LabelledFactIncrementer {
                Layout.fillWidth: true
                label: fact.label
                fact: QGroundControl.settingsManager.appSettings.uiScalePercent
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.appSettings.uiScalePercent.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: (!ScreenTools.isMobile) && QGroundControl.settingsManager.appSettings.savePath.userVisible

            LabelledFactBrowse {
                Layout.fillWidth: true
                label: fact.label
                fact: QGroundControl.settingsManager.appSettings.savePath
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.appSettings.savePath.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.appSettings.clearSettingsNextBoot.userVisible

            FactCheckBoxSlider {
                objectName: "settingsCheckBox_clearSettingsNextBoot"
                Layout.fillWidth: true
                text: fact.label
                fact: QGroundControl.settingsManager.appSettings.clearSettingsNextBoot
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.appSettings.clearSettingsNextBoot.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }
    }

    SettingsGroupLayout {
        objectName: "settingsGroup_VehiclePreferences"
        Layout.fillWidth: true
        heading: qsTranslate("General.SettingsUI.json", "Vehicle Preferences")
        visible: (sectionFilter === -1 || sectionFilter === 1) && (QGroundControl.settingsManager.appSettings.preferredFirmwareClass.userVisible || QGroundControl.settingsManager.appSettings.preferredVehicleClass.userVisible)

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.appSettings.preferredFirmwareClass.userVisible

            LabelledFactComboBox {
                label: fact.label
                Layout.fillWidth: true
                fact: QGroundControl.settingsManager.appSettings.preferredFirmwareClass
                indexModel: false
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.appSettings.preferredFirmwareClass.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.appSettings.preferredVehicleClass.userVisible

            LabelledFactComboBox {
                label: fact.label
                Layout.fillWidth: true
                fact: QGroundControl.settingsManager.appSettings.preferredVehicleClass
                indexModel: false
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.appSettings.preferredVehicleClass.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }
    }

    SettingsGroupLayout {
        objectName: "settingsGroup_Units"
        Layout.fillWidth: true
        heading: qsTranslate("General.SettingsUI.json", "Units")
        visible: (sectionFilter === -1 || sectionFilter === 2) && (QGroundControl.settingsManager.unitsSettings.userVisible) && (QGroundControl.settingsManager.unitsSettings.horizontalDistanceUnits.userVisible || QGroundControl.settingsManager.unitsSettings.verticalDistanceUnits.userVisible || QGroundControl.settingsManager.unitsSettings.areaUnits.userVisible || QGroundControl.settingsManager.unitsSettings.speedUnits.userVisible || QGroundControl.settingsManager.unitsSettings.temperatureUnits.userVisible)

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.unitsSettings.horizontalDistanceUnits.userVisible

            LabelledFactComboBox {
                label: fact.label
                Layout.fillWidth: true
                fact: QGroundControl.settingsManager.unitsSettings.horizontalDistanceUnits
                indexModel: false
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.unitsSettings.horizontalDistanceUnits.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.unitsSettings.verticalDistanceUnits.userVisible

            LabelledFactComboBox {
                label: fact.label
                Layout.fillWidth: true
                fact: QGroundControl.settingsManager.unitsSettings.verticalDistanceUnits
                indexModel: false
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.unitsSettings.verticalDistanceUnits.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.unitsSettings.areaUnits.userVisible

            LabelledFactComboBox {
                label: fact.label
                Layout.fillWidth: true
                fact: QGroundControl.settingsManager.unitsSettings.areaUnits
                indexModel: false
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.unitsSettings.areaUnits.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.unitsSettings.speedUnits.userVisible

            LabelledFactComboBox {
                label: fact.label
                Layout.fillWidth: true
                fact: QGroundControl.settingsManager.unitsSettings.speedUnits
                indexModel: false
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.unitsSettings.speedUnits.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.unitsSettings.temperatureUnits.userVisible

            LabelledFactComboBox {
                label: fact.label
                Layout.fillWidth: true
                fact: QGroundControl.settingsManager.unitsSettings.temperatureUnits
                indexModel: false
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.unitsSettings.temperatureUnits.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }
    }
}
