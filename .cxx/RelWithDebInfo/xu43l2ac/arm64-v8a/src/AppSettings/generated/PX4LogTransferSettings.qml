import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import QGroundControl
import QGroundControl.FactControls
import QGroundControl.Controls

SettingsPage {
    objectName: "settingsPage_PX4LogTransfer"

    ColumnLayout {
        Layout.fillWidth: true
        spacing: 0
        visible: (sectionFilter === -1 || sectionFilter === 0)

        PX4LogControl {
            Layout.fillWidth: true
        }
    }

    ColumnLayout {
        Layout.fillWidth: true
        spacing: 0
        visible: (sectionFilter === -1 || sectionFilter === 1)

        PX4LogUploadSettings {
            Layout.fillWidth: true
        }
    }

    ColumnLayout {
        Layout.fillWidth: true
        spacing: 0
        visible: (sectionFilter === -1 || sectionFilter === 2)

        PX4LogFileManager {
            Layout.fillWidth: true
        }
    }
}
