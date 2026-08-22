// AMPUH Gen 1 Guided Actions Controller

import QtQml
import QGroundControl

QtObject {
    id: _root
    readonly property int actionCustomButton: _guidedController.customActionStart + 0
    readonly property string customButtonTitle: qsTr("AMPUH Action")
    readonly property string customButtonMessage: qsTr("Eksekusi aksi taktis AMPUH Gen 1.")

    function customConfirmAction(actionCode, actionData, mapIndicator, confirmDialog) {
        switch (actionCode) {
        case actionCustomButton:
            confirmDialog.hideTrigger = true
            confirmDialog.title = customButtonTitle
            confirmDialog.message = customButtonMessage
            break
        default:
            return false // false = action not handled here
        }

        return true // true = action handled here
    }

    function customExecuteAction(actionCode, actionData, sliderOutputValue, optionCheckedode) {
        switch (actionCode) {
        case actionCustomButton:
            QGroundControl.showMessageDialog(mainWindow, "AMPUH Tactical Action", "Aksi taktis AMPUH berhasil dieksekusi.")
            break
        default:
            return false // false = action not handled here
        }

        return true // true = action handled here
    }
}
