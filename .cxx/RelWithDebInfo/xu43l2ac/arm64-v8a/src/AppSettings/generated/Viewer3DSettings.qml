import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import QGroundControl
import QGroundControl.FactControls
import QGroundControl.Controls

SettingsPage {
    objectName: "settingsPage_3DView"
    property real _stringFieldWidth: ScreenTools.defaultFontPixelWidth * 30

    function sectionVisible(index) {
        switch (index) {
        case 0: return (QGroundControl.settingsManager.viewer3DSettings.enabled.userVisible || QGroundControl.settingsManager.viewer3DSettings.mapProvider.userVisible || QGroundControl.settingsManager.viewer3DSettings.keepSceneAlive.userVisible)
        case 1: return (QGroundControl.settingsManager.viewer3DSettings.osmFilePath.userVisible || QGroundControl.settingsManager.viewer3DSettings.osmFilePath.userVisible || QGroundControl.settingsManager.viewer3DSettings.buildingLevelHeight.userVisible || QGroundControl.settingsManager.viewer3DSettings.altitudeBias.userVisible)
        default: return true
        }
    }

    SettingsGroupLayout {
        objectName: "settingsGroup_General"
        Layout.fillWidth: true
        heading: qsTranslate("Viewer3D.SettingsUI.json", "General")
        visible: (sectionFilter === -1 || sectionFilter === 0) && (QGroundControl.settingsManager.viewer3DSettings.enabled.userVisible || QGroundControl.settingsManager.viewer3DSettings.mapProvider.userVisible || QGroundControl.settingsManager.viewer3DSettings.keepSceneAlive.userVisible)

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.viewer3DSettings.enabled.userVisible

            FactCheckBoxSlider {
                objectName: "settingsCheckBox_enabled"
                Layout.fillWidth: true
                text: fact.label
                fact: QGroundControl.settingsManager.viewer3DSettings.enabled
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.viewer3DSettings.enabled.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.viewer3DSettings.mapProvider.userVisible

            LabelledFactComboBox {
                label: fact.label
                Layout.fillWidth: true
                fact: QGroundControl.settingsManager.viewer3DSettings.mapProvider
                indexModel: false
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.viewer3DSettings.mapProvider.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.viewer3DSettings.keepSceneAlive.userVisible

            FactCheckBoxSlider {
                objectName: "settingsCheckBox_keepSceneAlive"
                Layout.fillWidth: true
                text: fact.label
                fact: QGroundControl.settingsManager.viewer3DSettings.keepSceneAlive
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.viewer3DSettings.keepSceneAlive.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }
    }

    SettingsGroupLayout {
        objectName: "settingsGroup_Data"
        Layout.fillWidth: true
        heading: qsTranslate("Viewer3D.SettingsUI.json", "Data")
        visible: (sectionFilter === -1 || sectionFilter === 1) && (QGroundControl.settingsManager.viewer3DSettings.osmFilePath.userVisible || QGroundControl.settingsManager.viewer3DSettings.osmFilePath.userVisible || QGroundControl.settingsManager.viewer3DSettings.buildingLevelHeight.userVisible || QGroundControl.settingsManager.viewer3DSettings.altitudeBias.userVisible)
        enabled: QGroundControl.settingsManager.viewer3DSettings.enabled.rawValue

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: (!ScreenTools.isMobile) && QGroundControl.settingsManager.viewer3DSettings.osmFilePath.userVisible

            LabelledFactBrowse {
                Layout.fillWidth: true
                label: fact.label
                fact: QGroundControl.settingsManager.viewer3DSettings.osmFilePath
                selectFolder: false
                nameFilters: [ qsTr("OpenStreetMap files (*.osm)"), qsTr("All Files (*)") ]
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.viewer3DSettings.osmFilePath.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: (ScreenTools.isMobile) && QGroundControl.settingsManager.viewer3DSettings.osmFilePath.userVisible

            LabelledFactTextField {
                label: fact.label
                Layout.fillWidth: true
                fact: QGroundControl.settingsManager.viewer3DSettings.osmFilePath
                objectName: "settingsTextField_osmFilePath"
                textFieldPreferredWidth: _stringFieldWidth
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.viewer3DSettings.osmFilePath.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.viewer3DSettings.buildingLevelHeight.userVisible

            LabelledFactTextField {
                label: fact.label
                Layout.fillWidth: true
                fact: QGroundControl.settingsManager.viewer3DSettings.buildingLevelHeight
                objectName: "settingsTextField_buildingLevelHeight"
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.viewer3DSettings.buildingLevelHeight.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.viewer3DSettings.altitudeBias.userVisible

            LabelledFactTextField {
                label: fact.label
                Layout.fillWidth: true
                fact: QGroundControl.settingsManager.viewer3DSettings.altitudeBias
                objectName: "settingsTextField_altitudeBias"
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.viewer3DSettings.altitudeBias.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }
    }
}
