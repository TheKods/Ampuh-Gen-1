import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import QGroundControl
import QGroundControl.FactControls
import QGroundControl.Controls

SettingsPage {
    objectName: "settingsPage_Maps"
    property real _stringFieldWidth: ScreenTools.defaultFontPixelWidth * 30

    function sectionVisible(index) {
        switch (index) {
        case 2: return (QGroundControl.settingsManager.appSettings.tiandituToken.userVisible || QGroundControl.settingsManager.appSettings.mapboxToken.userVisible || QGroundControl.settingsManager.appSettings.esriToken.userVisible || QGroundControl.settingsManager.appSettings.vworldToken.userVisible || QGroundControl.settingsManager.appSettings.openaipToken.userVisible)
        case 3: return (QGroundControl.settingsManager.appSettings.mapboxAccount.userVisible || QGroundControl.settingsManager.appSettings.mapboxStyle.userVisible)
        case 4: return (QGroundControl.settingsManager.appSettings.customURL.userVisible)
        case 5: return (QGroundControl.settingsManager.mapsSettings.maxCacheDiskSize.userVisible || QGroundControl.settingsManager.mapsSettings.maxCacheMemorySize.userVisible)
        default: return true
        }
    }

    ColumnLayout {
        Layout.fillWidth: true
        spacing: 0
        visible: (sectionFilter === -1 || sectionFilter === 0)

        MapProviderSettings {
            Layout.fillWidth: true
        }
    }

    ColumnLayout {
        Layout.fillWidth: true
        spacing: 0
        visible: (sectionFilter === -1 || sectionFilter === 1)

        OfflineMapSettings {
            Layout.fillWidth: true
        }
    }

    SettingsGroupLayout {
        objectName: "settingsGroup_Tokens"
        Layout.fillWidth: true
        heading: qsTranslate("Maps.SettingsUI.json", "Tokens")
        headingDescription: qsTr("Allows access to additional providers")
        visible: (sectionFilter === -1 || sectionFilter === 2) && (QGroundControl.settingsManager.appSettings.tiandituToken.userVisible || QGroundControl.settingsManager.appSettings.mapboxToken.userVisible || QGroundControl.settingsManager.appSettings.esriToken.userVisible || QGroundControl.settingsManager.appSettings.vworldToken.userVisible || QGroundControl.settingsManager.appSettings.openaipToken.userVisible)

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.appSettings.tiandituToken.userVisible

            LabelledFactTextField {
                label: fact.label
                Layout.fillWidth: true
                fact: QGroundControl.settingsManager.appSettings.tiandituToken
                objectName: "settingsTextField_tiandituToken"
                textFieldPreferredWidth: _stringFieldWidth
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.appSettings.tiandituToken.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.appSettings.mapboxToken.userVisible

            LabelledFactTextField {
                label: fact.label
                Layout.fillWidth: true
                fact: QGroundControl.settingsManager.appSettings.mapboxToken
                objectName: "settingsTextField_mapboxToken"
                textFieldPreferredWidth: _stringFieldWidth
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.appSettings.mapboxToken.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.appSettings.esriToken.userVisible

            LabelledFactTextField {
                label: fact.label
                Layout.fillWidth: true
                fact: QGroundControl.settingsManager.appSettings.esriToken
                objectName: "settingsTextField_esriToken"
                textFieldPreferredWidth: _stringFieldWidth
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.appSettings.esriToken.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.appSettings.vworldToken.userVisible

            LabelledFactTextField {
                label: fact.label
                Layout.fillWidth: true
                fact: QGroundControl.settingsManager.appSettings.vworldToken
                objectName: "settingsTextField_vworldToken"
                textFieldPreferredWidth: _stringFieldWidth
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.appSettings.vworldToken.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.appSettings.openaipToken.userVisible

            LabelledFactTextField {
                label: fact.label
                Layout.fillWidth: true
                fact: QGroundControl.settingsManager.appSettings.openaipToken
                objectName: "settingsTextField_openaipToken"
                textFieldPreferredWidth: _stringFieldWidth
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.appSettings.openaipToken.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }
    }

    SettingsGroupLayout {
        objectName: "settingsGroup_MapboxLogin"
        Layout.fillWidth: true
        heading: qsTranslate("Maps.SettingsUI.json", "Mapbox Login")
        visible: (sectionFilter === -1 || sectionFilter === 3) && (QGroundControl.settingsManager.appSettings.mapboxAccount.userVisible || QGroundControl.settingsManager.appSettings.mapboxStyle.userVisible)

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.appSettings.mapboxAccount.userVisible

            LabelledFactTextField {
                label: fact.label
                Layout.fillWidth: true
                fact: QGroundControl.settingsManager.appSettings.mapboxAccount
                objectName: "settingsTextField_mapboxAccount"
                textFieldPreferredWidth: _stringFieldWidth
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.appSettings.mapboxAccount.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.appSettings.mapboxStyle.userVisible

            LabelledFactTextField {
                label: fact.label
                Layout.fillWidth: true
                fact: QGroundControl.settingsManager.appSettings.mapboxStyle
                objectName: "settingsTextField_mapboxStyle"
                textFieldPreferredWidth: _stringFieldWidth
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.appSettings.mapboxStyle.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }
    }

    SettingsGroupLayout {
        objectName: "settingsGroup_CustomMapURL"
        Layout.fillWidth: true
        heading: qsTranslate("Maps.SettingsUI.json", "Custom Map URL")
        headingDescription: qsTr("URL with {x} {y} {z} or {zoom} substitutions")
        visible: (sectionFilter === -1 || sectionFilter === 4) && (QGroundControl.settingsManager.appSettings.customURL.userVisible)

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.appSettings.customURL.userVisible

            LabelledFactTextField {
                label: fact.label
                Layout.fillWidth: true
                fact: QGroundControl.settingsManager.appSettings.customURL
                objectName: "settingsTextField_customURL"
                textFieldPreferredWidth: _stringFieldWidth
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.appSettings.customURL.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }
    }

    SettingsGroupLayout {
        objectName: "settingsGroup_TileCache"
        Layout.fillWidth: true
        heading: qsTranslate("Maps.SettingsUI.json", "Tile Cache")
        visible: (sectionFilter === -1 || sectionFilter === 5) && (QGroundControl.settingsManager.mapsSettings.maxCacheDiskSize.userVisible || QGroundControl.settingsManager.mapsSettings.maxCacheMemorySize.userVisible)

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.mapsSettings.maxCacheDiskSize.userVisible

            LabelledFactTextField {
                label: fact.label
                Layout.fillWidth: true
                fact: QGroundControl.settingsManager.mapsSettings.maxCacheDiskSize
                objectName: "settingsTextField_maxCacheDiskSize"
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.mapsSettings.maxCacheDiskSize.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.mapsSettings.maxCacheMemorySize.userVisible

            LabelledFactTextField {
                label: fact.label
                Layout.fillWidth: true
                fact: QGroundControl.settingsManager.mapsSettings.maxCacheMemorySize
                objectName: "settingsTextField_maxCacheMemorySize"
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.mapsSettings.maxCacheMemorySize.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }
    }
}
