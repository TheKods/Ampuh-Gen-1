import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import QGroundControl
import QGroundControl.FactControls
import QGroundControl.Controls

SettingsPage {
    objectName: "settingsPage_AppLogging"
    property var settingsManager: QGroundControl.settingsManager
    property var logSettings: settingsManager.logManagerSettings
    property var diskLoggingEnabledValue: logSettings.diskLoggingEnabled.rawValue
    property var logSavePath: settingsManager.appSettings.logSavePath

    function sectionVisible(index) {
        switch (index) {
        case 0: return (QGroundControl.settingsManager.logManagerSettings.diskLoggingEnabled.userVisible || QGroundControl.settingsManager.logManagerSettings.diskLoggingMaxFileSizeMB.userVisible || QGroundControl.settingsManager.logManagerSettings.diskLoggingMaxBackupFiles.userVisible || QGroundControl.settingsManager.logManagerSettings.saveFormat.userVisible)
        case 1: return (QGroundControl.settingsManager.appSettings.showAppLogTimestampAsElapsedTime.userVisible || QGroundControl.settingsManager.appSettings.gstDebugLevel.userVisible)
        default: return true
        }
    }

    SettingsGroupLayout {
        objectName: "settingsGroup_SaveToDisk"
        Layout.fillWidth: true
        heading: qsTranslate("Logging.SettingsUI.json", "Save To Disk")
        visible: (sectionFilter === -1 || sectionFilter === 0) && (QGroundControl.settingsManager.logManagerSettings.diskLoggingEnabled.userVisible || QGroundControl.settingsManager.logManagerSettings.diskLoggingMaxFileSizeMB.userVisible || QGroundControl.settingsManager.logManagerSettings.diskLoggingMaxBackupFiles.userVisible || QGroundControl.settingsManager.logManagerSettings.saveFormat.userVisible)

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.logManagerSettings.diskLoggingEnabled.userVisible

            FactCheckBoxSlider {
                objectName: "settingsCheckBox_diskLoggingEnabled"
                Layout.fillWidth: true
                text: fact.label
                fact: QGroundControl.settingsManager.logManagerSettings.diskLoggingEnabled
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.logManagerSettings.diskLoggingEnabled.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.logManagerSettings.diskLoggingMaxFileSizeMB.userVisible

            LabelledFactTextField {
                label: fact.label
                Layout.fillWidth: true
                fact: QGroundControl.settingsManager.logManagerSettings.diskLoggingMaxFileSizeMB
                enabled: diskLoggingEnabledValue
                objectName: "settingsTextField_diskLoggingMaxFileSizeMB"
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.logManagerSettings.diskLoggingMaxFileSizeMB.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.logManagerSettings.diskLoggingMaxBackupFiles.userVisible

            LabelledFactTextField {
                label: fact.label
                Layout.fillWidth: true
                fact: QGroundControl.settingsManager.logManagerSettings.diskLoggingMaxBackupFiles
                enabled: diskLoggingEnabledValue
                objectName: "settingsTextField_diskLoggingMaxBackupFiles"
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.logManagerSettings.diskLoggingMaxBackupFiles.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.logManagerSettings.saveFormat.userVisible

            LabelledFactComboBox {
                label: fact.label
                Layout.fillWidth: true
                fact: QGroundControl.settingsManager.logManagerSettings.saveFormat
                indexModel: false
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.logManagerSettings.saveFormat.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }
    }

    SettingsGroupLayout {
        objectName: "settingsGroup_LogViewer"
        Layout.fillWidth: true
        heading: qsTranslate("Logging.SettingsUI.json", "Log Viewer")
        visible: (sectionFilter === -1 || sectionFilter === 1) && (QGroundControl.settingsManager.appSettings.showAppLogTimestampAsElapsedTime.userVisible || QGroundControl.settingsManager.appSettings.gstDebugLevel.userVisible)

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.appSettings.showAppLogTimestampAsElapsedTime.userVisible

            FactCheckBoxSlider {
                objectName: "settingsCheckBox_showAppLogTimestampAsElapsedTime"
                Layout.fillWidth: true
                text: fact.label
                fact: QGroundControl.settingsManager.appSettings.showAppLogTimestampAsElapsedTime
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.appSettings.showAppLogTimestampAsElapsedTime.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.appSettings.gstDebugLevel.userVisible

            LabelledFactComboBox {
                label: fact.label
                Layout.fillWidth: true
                fact: QGroundControl.settingsManager.appSettings.gstDebugLevel
                indexModel: false
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.appSettings.gstDebugLevel.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }
    }
}
