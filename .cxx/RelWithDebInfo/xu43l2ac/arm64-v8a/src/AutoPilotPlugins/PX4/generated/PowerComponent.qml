// This file is auto-generated. Do not edit.
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import QGroundControl
import QGroundControl.FactControls
import QGroundControl.Controls

import QGroundControl.AutoPilotPlugins.PX4

SetupPage {
    id: configPage
    pageComponent: pageComponent

    Component {
        id: pageComponent

        Item {
            width: Math.max(availableWidth, outerColumn.width)
            height: outerColumn.height

            PowerComponentController {
                id: controller
            }

            property real _margins: ScreenTools.defaultFontPixelHeight

            property var _uavcanEnable: controller.getParameterFact(-1, "UAVCAN_ENABLE", false)
            property var _uavcanAvailable: controller.parameterExists(-1, "UAVCAN_ENABLE")

            property int _batteryCount: {
                var _i = 1
                while (true) {
                    var _idx = _i
                    if (!controller.parameterExists(-1, "BAT" + _idx + "_SOURCE"))
                        return _i - 1
                    _i++
                }
            }

            property string sectionNameFilter: ""

            readonly property var _searchTerms: ({
                "Battery": ["_a_per_v", "_capacity", "_n_cells", "_source", "_v_charged", "_v_div", "_v_empty", "amps per volt", "battery", "battery capacity (mah)", "cells", "current", "empty voltage (per cell)", "full voltage (per cell)", "lipo", "number of cells (in series)", "power module", "sensor", "source", "voltage", "voltage divider"],
                "ESC PWM Calibration": ["calibration", "electronic speed controller", "esc", "motor", "pwm", "warning: propellers must be removed from vehicle prior to performing esc calibration.", "you must use usb connection for this operation."],
                "UAVCAN Bus Configuration": ["bus", "can bus", "configuration", "dronecan", "esc", "esc parameters will only be accessible in the editor after assignment.", "node", "start the process, then turn each motor into its turn direction, in the order of their motor indices.", "uavcan", "uavcan_enable", "warning: propellers must be removed from vehicle prior to performing uavcan esc configuration."]
            })

            readonly property var _translatableSearchTerms: ({
                "Battery": ["Amps per volt", "Battery", "Battery capacity (mAh)", "Empty voltage (per cell)", "Full voltage (per cell)", "Number of cells (in series)", "Source", "Voltage divider", "battery", "cells", "current", "lipo", "power module", "sensor", "voltage"],
                "ESC PWM Calibration": ["ESC PWM Calibration", "WARNING: Propellers must be removed from vehicle prior to performing ESC calibration.", "You must use USB connection for this operation.", "calibration", "electronic speed controller", "esc", "motor", "pwm"],
                "UAVCAN Bus Configuration": ["ESC parameters will only be accessible in the editor after assignment.", "Start the process, then turn each motor into its turn direction, in the order of their motor indices.", "UAVCAN", "UAVCAN Bus Configuration", "WARNING: Propellers must be removed from vehicle prior to performing UAVCAN ESC configuration.", "can bus", "dronecan", "esc", "node", "uavcan"]
            })

            function sectionMatchesFilter(sectionTitle) {
                if (sectionNameFilter === "") return true
                if (sectionNameFilter === sectionTitle) return true
                var filter = sectionNameFilter.toLowerCase()
                var terms = _searchTerms[sectionTitle]
                if (terms) {
                    for (var i = 0; i < terms.length; i++) {
                        if (terms[i].indexOf(filter) >= 0) return true
                    }
                }
                var trTerms = _translatableSearchTerms[sectionTitle]
                if (trTerms) {
                    for (var j = 0; j < trTerms.length; j++) {
                        if (qsTranslate("Power.VehicleConfig.json", trTerms[j]).toLowerCase().indexOf(filter) >= 0) return true
                    }
                }
                return false
            }

            function sectionVisible(name) {
                if (name === "UAVCAN Bus Configuration") return _uavcanAvailable && _uavcanEnable.rawValue !== 0
                return true
            }

            property real _maxLeftMargin: ScreenTools.defaultFontPixelWidth * 20

            ColumnLayout {
                id: outerColumn
                spacing: _margins * 1.25
                anchors.left: parent.left
                anchors.leftMargin: Math.min((parent.width - width) / 2, _maxLeftMargin)

                Repeater {
                    model: _batteryCount

                    ConfigSection {
                        Layout.fillWidth: true
                        visible: sectionMatchesFilter(heading)
                        heading: _batteryCount > 1 ? qsTranslate("Power.VehicleConfig.json", "Battery") + " " + _displayIndex : qsTranslate("Power.VehicleConfig.json", "Battery")
                        iconSource: "/qmlimages/Battery.svg"

                        property int _rawIndex: index + 1
                        property string _indexStr: String(_rawIndex)
                        property string _displayIndex: String(_rawIndex)
                        function _fullParamName(postfix) { return "BAT" + _indexStr + postfix }

                        LabelledFactComboBox {
                            visible: fact !== null
                            label: qsTranslate("Power.VehicleConfig.json", "Source")
                            Layout.fillWidth: true
                            comboBoxPreferredWidth: ScreenTools.defaultFontPixelWidth * 30
                            fact: controller.getParameterFact(-1, _fullParamName("_SOURCE"), false)
                            indexModel: false
                        }

                        LabelledFactTextField {
                            visible: fact !== null && (controller.parameterExists(-1, _fullParamName("_N_CELLS")))
                            label: qsTranslate("Power.VehicleConfig.json", "Number of cells (in series)")
                            Layout.fillWidth: true
                            fact: controller.getParameterFact(-1, _fullParamName("_N_CELLS"), false)
                        }

                        ColumnLayout {
                            visible: controller.getParameterFact(-1, _fullParamName("_CAPACITY"), false) !== null && (controller.parameterExists(-1, _fullParamName("_CAPACITY")))
                            Layout.fillWidth: true
                            Layout.preferredWidth: 0
                            spacing: ScreenTools.defaultFontPixelHeight / 4
                            LabelledFactTextField {
                                label: qsTranslate("Power.VehicleConfig.json", "Battery capacity (mAh)")
                                Layout.fillWidth: true
                                fact: controller.getParameterFact(-1, _fullParamName("_CAPACITY"), false)
                            }
                            QGCLabel {
                                Layout.fillWidth: true
                                Layout.preferredWidth: 0
                                text: qsTranslate("Power.VehicleConfig.json", "Set to -1 to disable. When set to a positive value, enables coulomb counting for more accurate state-of-charge and time-remaining estimates.")
                                font.pointSize: ScreenTools.smallFontPointSize
                                wrapMode: Text.WordWrap
                            }
                        }

                        LabelledFactTextField {
                            visible: fact !== null && (controller.parameterExists(-1, _fullParamName("_V_EMPTY")))
                            label: qsTranslate("Power.VehicleConfig.json", "Empty voltage (per cell)")
                            Layout.fillWidth: true
                            fact: controller.getParameterFact(-1, _fullParamName("_V_EMPTY"), false)
                        }

                        LabelledFactTextField {
                            visible: fact !== null && (controller.parameterExists(-1, _fullParamName("_V_CHARGED")))
                            label: qsTranslate("Power.VehicleConfig.json", "Full voltage (per cell)")
                            Layout.fillWidth: true
                            fact: controller.getParameterFact(-1, _fullParamName("_V_CHARGED"), false)
                        }

                        ColumnLayout {
                            visible: controller.getParameterFact(-1, _fullParamName("_V_DIV"), false) !== null && (controller.parameterExists(-1, _fullParamName("_V_DIV")))
                            QGCPopupDialogFactory {
                                id: _dlgFactory0
                                dialogComponent: _dlgFactory0Component
                            }
                            Component {
                                id: _dlgFactory0Component
                                CalcVoltageDividerDialog { }
                            }
                            RowLayout {
                                Layout.fillWidth: true
                                spacing: ScreenTools.defaultFontPixelWidth
                                QGCLabel {
                                    text: qsTranslate("Power.VehicleConfig.json", "Voltage divider")
                                    Layout.fillWidth: true
                                }
                                QGCButton {
                                    text: qsTranslate("Power.VehicleConfig.json", "Calculate")
                                    onClicked: _dlgFactory0.open({ "batteryIndex": _rawIndex })
                                }
                                FactTextField {
                                    fact: controller.getParameterFact(-1, _fullParamName("_V_DIV"), false)
                                }
                            }
                        }

                        ColumnLayout {
                            visible: controller.getParameterFact(-1, _fullParamName("_A_PER_V"), false) !== null && (controller.parameterExists(-1, _fullParamName("_A_PER_V")))
                            QGCPopupDialogFactory {
                                id: _dlgFactory1
                                dialogComponent: _dlgFactory1Component
                            }
                            Component {
                                id: _dlgFactory1Component
                                CalcAmpsPerVoltDialog { }
                            }
                            RowLayout {
                                Layout.fillWidth: true
                                spacing: ScreenTools.defaultFontPixelWidth
                                QGCLabel {
                                    text: qsTranslate("Power.VehicleConfig.json", "Amps per volt")
                                    Layout.fillWidth: true
                                }
                                QGCButton {
                                    text: qsTranslate("Power.VehicleConfig.json", "Calculate")
                                    onClicked: _dlgFactory1.open({ "batteryIndex": _rawIndex })
                                }
                                FactTextField {
                                    fact: controller.getParameterFact(-1, _fullParamName("_A_PER_V"), false)
                                }
                            }
                        }
                    }
                }

                ConfigSection {
                    Layout.fillWidth: true
                    visible: sectionMatchesFilter("ESC PWM Calibration")
                    heading: qsTranslate("Power.VehicleConfig.json", "ESC PWM Calibration")
                    iconSource: "/qmlimages/Gears.svg"

                    QGCLabel {
                        text: qsTranslate("Power.VehicleConfig.json", "WARNING: Propellers must be removed from vehicle prior to performing ESC calibration.")
                        wrapMode: Text.WordWrap
                        Layout.fillWidth: true
                        Layout.preferredWidth: 0
                        color: qgcPal.warningText
                    }

                    QGCLabel {
                        text: qsTranslate("Power.VehicleConfig.json", "You must use USB connection for this operation.")
                        wrapMode: Text.WordWrap
                        Layout.fillWidth: true
                        Layout.preferredWidth: 0
                    }

                    QGCPopupDialogFactory {
                        id: _dlgFactory0
                        dialogComponent: _dlgFactory0Component
                    }
                    Component {
                        id: _dlgFactory0Component
                        ESCCalibrationDialog { }
                    }
                    QGCButton {
                        text: qsTranslate("Power.VehicleConfig.json", "Calibrate")
                        onClicked: _dlgFactory0.open()
                    }
                }

                ConfigSection {
                    Layout.fillWidth: true
                    visible: sectionMatchesFilter("UAVCAN Bus Configuration") && _uavcanAvailable && _uavcanEnable.rawValue !== 0
                    heading: qsTranslate("Power.VehicleConfig.json", "UAVCAN Bus Configuration")
                    iconSource: "/qmlimages/Gears.svg"

                    LabelledFactComboBox {
                        visible: fact !== null
                        label: qsTranslate("Power.VehicleConfig.json", "UAVCAN")
                        Layout.fillWidth: true
                        comboBoxPreferredWidth: ScreenTools.defaultFontPixelWidth * 30
                        fact: controller.getParameterFact(-1, "UAVCAN_ENABLE", false)
                        indexModel: false
                    }

                    QGCLabel {
                        text: qsTranslate("Power.VehicleConfig.json", "WARNING: Propellers must be removed from vehicle prior to performing UAVCAN ESC configuration.")
                        wrapMode: Text.WordWrap
                        Layout.fillWidth: true
                        Layout.preferredWidth: 0
                        color: qgcPal.warningText
                    }

                    QGCLabel {
                        text: qsTranslate("Power.VehicleConfig.json", "ESC parameters will only be accessible in the editor after assignment.")
                        wrapMode: Text.WordWrap
                        Layout.fillWidth: true
                        Layout.preferredWidth: 0
                    }

                    QGCLabel {
                        text: qsTranslate("Power.VehicleConfig.json", "Start the process, then turn each motor into its turn direction, in the order of their motor indices.")
                        wrapMode: Text.WordWrap
                        Layout.fillWidth: true
                        Layout.preferredWidth: 0
                    }

                    QGCButton {
                        text: qsTranslate("Power.VehicleConfig.json", "Start Assignment")
                        onClicked: controller.startBusConfigureActuators()
                    }

                    QGCButton {
                        text: qsTranslate("Power.VehicleConfig.json", "Stop Assignment")
                        onClicked: controller.stopBusConfigureActuators()
                    }
                }
            }
        }
    }
}
