import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import QGroundControl
import QGroundControl.FactControls
import QGroundControl.Controls

SettingsPage {
    objectName: "settingsPage_RemoteID"
    property real _stringFieldWidth: ScreenTools.defaultFontPixelWidth * 30
    property var ridSettings: QGroundControl.settingsManager.remoteIDSettings
    property bool isEURegion: ridSettings.region.rawValue === RemoteIDSettings.RegionOperation.EU
    property bool isFAARegion: ridSettings.region.rawValue === RemoteIDSettings.RegionOperation.FAA
    property var sendBasicIDOn: ridSettings.sendBasicID.rawValue
    property var sendSelfIDOn: ridSettings.sendSelfID.rawValue
    property bool locationIsFixed: ridSettings.locationType.rawValue === RemoteIDSettings.LocationType.FIXED
    property bool classificationIsEU: ridSettings.classificationType.rawValue === RemoteIDSettings.ClassificationType.EU

    function sectionVisible(index) {
        switch (index) {
        case 0: return (QGroundControl.settingsManager.remoteIDSettings.region.userVisible)
        case 1: return (QGroundControl.settingsManager.remoteIDSettings.sendBasicID.userVisible || QGroundControl.settingsManager.remoteIDSettings.basicIDType.userVisible || QGroundControl.settingsManager.remoteIDSettings.basicIDUaType.userVisible || QGroundControl.settingsManager.remoteIDSettings.basicID.userVisible)
        case 2: return (QGroundControl.settingsManager.remoteIDSettings.sendOperatorID.userVisible || QGroundControl.settingsManager.remoteIDSettings.operatorIDType.userVisible || QGroundControl.settingsManager.remoteIDSettings.operatorIDEU.userVisible || QGroundControl.settingsManager.remoteIDSettings.operatorIDFAA.userVisible)
        case 3: return (QGroundControl.settingsManager.remoteIDSettings.sendSelfID.userVisible || QGroundControl.settingsManager.remoteIDSettings.selfIDType.userVisible || QGroundControl.settingsManager.remoteIDSettings.selfIDFree.userVisible || QGroundControl.settingsManager.remoteIDSettings.selfIDExtended.userVisible || QGroundControl.settingsManager.remoteIDSettings.selfIDEmergency.userVisible)
        case 4: return (QGroundControl.settingsManager.remoteIDSettings.locationType.userVisible || QGroundControl.settingsManager.remoteIDSettings.latitudeFixed.userVisible || QGroundControl.settingsManager.remoteIDSettings.longitudeFixed.userVisible || QGroundControl.settingsManager.remoteIDSettings.altitudeFixed.userVisible)
        case 7: return (isEURegion) && (QGroundControl.settingsManager.remoteIDSettings.classificationType.userVisible || QGroundControl.settingsManager.remoteIDSettings.categoryEU.userVisible || QGroundControl.settingsManager.remoteIDSettings.classEU.userVisible)
        default: return true
        }
    }

    SettingsGroupLayout {
        objectName: "settingsGroup_Region"
        Layout.fillWidth: true
        heading: qsTranslate("RemoteID.SettingsUI.json", "Region")
        visible: (sectionFilter === -1 || sectionFilter === 0) && (QGroundControl.settingsManager.remoteIDSettings.region.userVisible)

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.remoteIDSettings.region.userVisible

            LabelledFactComboBox {
                label: fact.label
                Layout.fillWidth: true
                fact: QGroundControl.settingsManager.remoteIDSettings.region
                indexModel: false
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.remoteIDSettings.region.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }
    }

    SettingsGroupLayout {
        objectName: "settingsGroup_BasicID"
        Layout.fillWidth: true
        heading: qsTranslate("RemoteID.SettingsUI.json", "Basic ID")
        visible: (sectionFilter === -1 || sectionFilter === 1) && (QGroundControl.settingsManager.remoteIDSettings.sendBasicID.userVisible || QGroundControl.settingsManager.remoteIDSettings.basicIDType.userVisible || QGroundControl.settingsManager.remoteIDSettings.basicIDUaType.userVisible || QGroundControl.settingsManager.remoteIDSettings.basicID.userVisible)

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.remoteIDSettings.sendBasicID.userVisible

            FactCheckBoxSlider {
                objectName: "settingsCheckBox_sendBasicID"
                Layout.fillWidth: true
                text: fact.label
                fact: QGroundControl.settingsManager.remoteIDSettings.sendBasicID
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.remoteIDSettings.sendBasicID.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.remoteIDSettings.basicIDType.userVisible

            LabelledFactComboBox {
                label: fact.label
                Layout.fillWidth: true
                fact: QGroundControl.settingsManager.remoteIDSettings.basicIDType
                indexModel: false
                enabled: sendBasicIDOn
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.remoteIDSettings.basicIDType.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.remoteIDSettings.basicIDUaType.userVisible

            LabelledFactComboBox {
                label: fact.label
                Layout.fillWidth: true
                fact: QGroundControl.settingsManager.remoteIDSettings.basicIDUaType
                indexModel: false
                enabled: sendBasicIDOn
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.remoteIDSettings.basicIDUaType.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.remoteIDSettings.basicID.userVisible

            LabelledFactTextField {
                label: fact.label
                Layout.fillWidth: true
                fact: QGroundControl.settingsManager.remoteIDSettings.basicID
                enabled: sendBasicIDOn
                objectName: "settingsTextField_basicID"
                textFieldPreferredWidth: _stringFieldWidth
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.remoteIDSettings.basicID.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }
    }

    SettingsGroupLayout {
        objectName: "settingsGroup_OperatorID"
        Layout.fillWidth: true
        heading: qsTranslate("RemoteID.SettingsUI.json", "Operator ID")
        visible: (sectionFilter === -1 || sectionFilter === 2) && (QGroundControl.settingsManager.remoteIDSettings.sendOperatorID.userVisible || QGroundControl.settingsManager.remoteIDSettings.operatorIDType.userVisible || QGroundControl.settingsManager.remoteIDSettings.operatorIDEU.userVisible || QGroundControl.settingsManager.remoteIDSettings.operatorIDFAA.userVisible)

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.remoteIDSettings.sendOperatorID.userVisible

            FactCheckBoxSlider {
                objectName: "settingsCheckBox_sendOperatorID"
                Layout.fillWidth: true
                text: fact.label
                fact: QGroundControl.settingsManager.remoteIDSettings.sendOperatorID
                enabled: isFAARegion
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.remoteIDSettings.sendOperatorID.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: (ridSettings.operatorIDType.enumValues.length > 1) && QGroundControl.settingsManager.remoteIDSettings.operatorIDType.userVisible

            LabelledFactComboBox {
                label: fact.label
                Layout.fillWidth: true
                fact: QGroundControl.settingsManager.remoteIDSettings.operatorIDType
                indexModel: false
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.remoteIDSettings.operatorIDType.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: (isEURegion) && QGroundControl.settingsManager.remoteIDSettings.operatorIDEU.userVisible

            LabelledFactTextField {
                label: fact.label
                Layout.fillWidth: true
                fact: QGroundControl.settingsManager.remoteIDSettings.operatorIDEU
                objectName: "settingsTextField_operatorIDEU"
                textFieldPreferredWidth: _stringFieldWidth
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.remoteIDSettings.operatorIDEU.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: (!isEURegion) && QGroundControl.settingsManager.remoteIDSettings.operatorIDFAA.userVisible

            LabelledFactTextField {
                label: fact.label
                Layout.fillWidth: true
                fact: QGroundControl.settingsManager.remoteIDSettings.operatorIDFAA
                objectName: "settingsTextField_operatorIDFAA"
                textFieldPreferredWidth: _stringFieldWidth
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.remoteIDSettings.operatorIDFAA.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }
    }

    SettingsGroupLayout {
        objectName: "settingsGroup_SelfID"
        Layout.fillWidth: true
        heading: qsTranslate("RemoteID.SettingsUI.json", "Self ID")
        visible: (sectionFilter === -1 || sectionFilter === 3) && (QGroundControl.settingsManager.remoteIDSettings.sendSelfID.userVisible || QGroundControl.settingsManager.remoteIDSettings.selfIDType.userVisible || QGroundControl.settingsManager.remoteIDSettings.selfIDFree.userVisible || QGroundControl.settingsManager.remoteIDSettings.selfIDExtended.userVisible || QGroundControl.settingsManager.remoteIDSettings.selfIDEmergency.userVisible)

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.remoteIDSettings.sendSelfID.userVisible

            FactCheckBoxSlider {
                objectName: "settingsCheckBox_sendSelfID"
                Layout.fillWidth: true
                text: fact.label
                fact: QGroundControl.settingsManager.remoteIDSettings.sendSelfID
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.remoteIDSettings.sendSelfID.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.remoteIDSettings.selfIDType.userVisible

            LabelledFactComboBox {
                label: fact.label
                Layout.fillWidth: true
                fact: QGroundControl.settingsManager.remoteIDSettings.selfIDType
                indexModel: false
                enabled: sendSelfIDOn
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.remoteIDSettings.selfIDType.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.remoteIDSettings.selfIDFree.userVisible

            LabelledFactTextField {
                label: fact.label
                Layout.fillWidth: true
                fact: QGroundControl.settingsManager.remoteIDSettings.selfIDFree
                enabled: sendSelfIDOn
                objectName: "settingsTextField_selfIDFree"
                textFieldPreferredWidth: _stringFieldWidth
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.remoteIDSettings.selfIDFree.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.remoteIDSettings.selfIDExtended.userVisible

            LabelledFactTextField {
                label: fact.label
                Layout.fillWidth: true
                fact: QGroundControl.settingsManager.remoteIDSettings.selfIDExtended
                enabled: sendSelfIDOn
                objectName: "settingsTextField_selfIDExtended"
                textFieldPreferredWidth: _stringFieldWidth
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.remoteIDSettings.selfIDExtended.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.remoteIDSettings.selfIDEmergency.userVisible

            LabelledFactTextField {
                label: fact.label
                Layout.fillWidth: true
                fact: QGroundControl.settingsManager.remoteIDSettings.selfIDEmergency
                objectName: "settingsTextField_selfIDEmergency"
                textFieldPreferredWidth: _stringFieldWidth
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.remoteIDSettings.selfIDEmergency.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }
    }

    SettingsGroupLayout {
        objectName: "settingsGroup_GroundStationLocation"
        Layout.fillWidth: true
        heading: qsTranslate("RemoteID.SettingsUI.json", "GroundStation Location")
        visible: (sectionFilter === -1 || sectionFilter === 4) && (QGroundControl.settingsManager.remoteIDSettings.locationType.userVisible || QGroundControl.settingsManager.remoteIDSettings.latitudeFixed.userVisible || QGroundControl.settingsManager.remoteIDSettings.longitudeFixed.userVisible || QGroundControl.settingsManager.remoteIDSettings.altitudeFixed.userVisible)

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.remoteIDSettings.locationType.userVisible

            LabelledFactComboBox {
                label: fact.label
                Layout.fillWidth: true
                fact: QGroundControl.settingsManager.remoteIDSettings.locationType
                indexModel: false
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.remoteIDSettings.locationType.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.remoteIDSettings.latitudeFixed.userVisible

            LabelledFactTextField {
                label: fact.label
                Layout.fillWidth: true
                fact: QGroundControl.settingsManager.remoteIDSettings.latitudeFixed
                enabled: locationIsFixed
                objectName: "settingsTextField_latitudeFixed"
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.remoteIDSettings.latitudeFixed.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.remoteIDSettings.longitudeFixed.userVisible

            LabelledFactTextField {
                label: fact.label
                Layout.fillWidth: true
                fact: QGroundControl.settingsManager.remoteIDSettings.longitudeFixed
                enabled: locationIsFixed
                objectName: "settingsTextField_longitudeFixed"
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.remoteIDSettings.longitudeFixed.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.remoteIDSettings.altitudeFixed.userVisible

            LabelledFactTextField {
                label: fact.label
                Layout.fillWidth: true
                fact: QGroundControl.settingsManager.remoteIDSettings.altitudeFixed
                enabled: locationIsFixed
                objectName: "settingsTextField_altitudeFixed"
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.remoteIDSettings.altitudeFixed.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }
    }

    ColumnLayout {
        Layout.fillWidth: true
        spacing: 0
        visible: (sectionFilter === -1 || sectionFilter === 5)

        GcsPositionStatus {
            Layout.fillWidth: true
        }
    }

    ColumnLayout {
        Layout.fillWidth: true
        spacing: 0
        visible: (sectionFilter === -1 || sectionFilter === 6)

        RemoteIDGpsLocation {
            Layout.fillWidth: true
        }
    }

    SettingsGroupLayout {
        objectName: "settingsGroup_EUVehicleInfo"
        Layout.fillWidth: true
        heading: qsTranslate("RemoteID.SettingsUI.json", "EU Vehicle Info")
        visible: (sectionFilter === -1 || sectionFilter === 7) && (isEURegion) && (QGroundControl.settingsManager.remoteIDSettings.classificationType.userVisible || QGroundControl.settingsManager.remoteIDSettings.categoryEU.userVisible || QGroundControl.settingsManager.remoteIDSettings.classEU.userVisible)

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.remoteIDSettings.classificationType.userVisible

            LabelledFactComboBox {
                label: fact.label
                Layout.fillWidth: true
                fact: QGroundControl.settingsManager.remoteIDSettings.classificationType
                indexModel: false
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.remoteIDSettings.classificationType.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.remoteIDSettings.categoryEU.userVisible

            LabelledFactComboBox {
                label: fact.label
                Layout.fillWidth: true
                fact: QGroundControl.settingsManager.remoteIDSettings.categoryEU
                indexModel: false
                enabled: classificationIsEU
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.remoteIDSettings.categoryEU.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.remoteIDSettings.classEU.userVisible

            LabelledFactComboBox {
                label: fact.label
                Layout.fillWidth: true
                fact: QGroundControl.settingsManager.remoteIDSettings.classEU
                indexModel: false
                enabled: classificationIsEU
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.remoteIDSettings.classEU.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }
    }
}
