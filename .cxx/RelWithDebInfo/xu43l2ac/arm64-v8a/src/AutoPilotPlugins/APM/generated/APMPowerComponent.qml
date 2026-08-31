// This file is auto-generated. Do not edit.
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import QGroundControl
import QGroundControl.FactControls
import QGroundControl.Controls

import QGroundControl.AutoPilotPlugins.APM
import QGroundControl.AutoPilotPlugins.Common

SetupPage {
    id: configPage
    pageComponent: pageComponent

    Component {
        id: pageComponent

        Item {
            width: Math.max(availableWidth, outerColumn.width)
            height: outerColumn.height

            PowerModulePresetController {
                id: controller
            }

            property real _margins: ScreenTools.defaultFontPixelHeight

            readonly property var _monitorParamValueDisabled: 0
            readonly property var _monitorParamValueAnalogVoltageOnly: 3
            readonly property var _monitorParamValueAnalogVoltageAndCurrent: 4
            readonly property var _monitorParamValueAnalogVoltageSyntheticCurrent: 25
            readonly property var _monitorParamValueAnalogCurrentOnly: 31

            function _battPrefixForIndex(_i) {
                if (_i === 0) return "BATT_"
                if (_i <= 8) return "BATT" + (_i + 1) + "_"
                return "BATT" + String.fromCharCode(65 + _i - 9) + "_"
            }
            function _battLabelForIndex(_i) {
                if (_i <= 8) return String(_i + 1)
                return String.fromCharCode(65 + _i - 9)
            }
            property int _batteryCount: {
                var _i = 0
                while (_i < 16) {
                    if (!controller.parameterExists(-1, _battPrefixForIndex(_i) + "MONITOR"))
                        return _i
                    _i++
                }
                return 16
            }

            property string sectionNameFilter: ""

            readonly property var _searchTerms: ({
                "Battery": ["amp_offset", "amp_pervlt", "amps", "amps offset", "amps per volt", "arm_volt", "batteries", "battery", "battery capacity", "battery monitor", "capacity", "current", "disabled", "minimum arming voltage", "monitor", "power module", "sensor", "volt_mult", "voltage", "voltage multiplier"]
            })

            readonly property var _translatableSearchTerms: ({
                "Battery": ["Amps offset", "Amps per volt", "Battery", "Battery capacity", "Battery monitor", "Disabled Batteries", "Minimum arming voltage", "Voltage multiplier", "amps", "battery", "capacity", "current", "power module", "sensor", "voltage"]
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
                        if (qsTranslate("APMPower.VehicleConfig.json", trTerms[j]).toLowerCase().indexOf(filter) >= 0) return true
                    }
                }
                return false
            }

            function sectionVisible(name) {
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
                        visible: sectionMatchesFilter(heading) && controller.getParameterFact(-1, _fullParamName("MONITOR")).value !== _monitorParamValueDisabled
                        heading: _batteryCount > 1 ? qsTranslate("APMPower.VehicleConfig.json", "Battery") + " " + _displayIndex : qsTranslate("APMPower.VehicleConfig.json", "Battery")
                        iconSource: "/qmlimages/Battery.svg"

                        property int _rawIndex: index
                        property string _prefix: _battPrefixForIndex(_rawIndex)
                        property string _displayIndex: _battLabelForIndex(_rawIndex)
                        function _fullParamName(postfix) { return _prefix + postfix }

                        LabelledFactComboBox {
                            visible: fact !== null
                            label: qsTranslate("APMPower.VehicleConfig.json", "Battery monitor")
                            Layout.fillWidth: true
                            comboBoxPreferredWidth: ScreenTools.defaultFontPixelWidth * 30
                            fact: controller.getParameterFact(-1, _fullParamName("MONITOR"), false)
                            indexModel: false
                        }

                        LabelledFactTextField {
                            visible: fact !== null && (controller.parameterExists(-1, _fullParamName("CAPACITY")))
                            label: qsTranslate("APMPower.VehicleConfig.json", "Battery capacity")
                            Layout.fillWidth: true
                            fact: controller.getParameterFact(-1, _fullParamName("CAPACITY"), false)
                        }

                        LabelledFactTextField {
                            visible: fact !== null && (controller.parameterExists(-1, _fullParamName("ARM_VOLT")))
                            label: qsTranslate("APMPower.VehicleConfig.json", "Minimum arming voltage")
                            Layout.fillWidth: true
                            fact: controller.getParameterFact(-1, _fullParamName("ARM_VOLT"), false)
                        }

                        ColumnLayout {
                            visible: controller.getParameterFact(-1, _fullParamName("VOLT_MULT"), false) !== null && (controller.parameterExists(-1, _fullParamName("VOLT_MULT")) && [_monitorParamValueAnalogVoltageOnly, _monitorParamValueAnalogVoltageAndCurrent, _monitorParamValueAnalogVoltageSyntheticCurrent].includes(controller.getParameterFact(-1, _fullParamName("MONITOR")).rawValue))
                            QGCPopupDialogFactory {
                                id: _dlgFactory0
                                dialogComponent: _dlgFactory0Component
                            }
                            Component {
                                id: _dlgFactory0Component
                                APMCalcVoltageDividerDialog { }
                            }
                            RowLayout {
                                Layout.fillWidth: true
                                spacing: ScreenTools.defaultFontPixelWidth
                                QGCLabel {
                                    text: qsTranslate("APMPower.VehicleConfig.json", "Voltage multiplier")
                                    Layout.fillWidth: true
                                }
                                QGCButton {
                                    text: qsTranslate("APMPower.VehicleConfig.json", "Calculate")
                                    onClicked: _dlgFactory0.open({ "batteryIndex": _rawIndex })
                                }
                                FactTextField {
                                    fact: controller.getParameterFact(-1, _fullParamName("VOLT_MULT"), false)
                                }
                            }
                        }

                        ColumnLayout {
                            visible: controller.getParameterFact(-1, _fullParamName("AMP_PERVLT"), false) !== null && (controller.parameterExists(-1, _fullParamName("AMP_PERVLT")) && [_monitorParamValueAnalogVoltageAndCurrent, _monitorParamValueAnalogCurrentOnly].includes(controller.getParameterFact(-1, _fullParamName("MONITOR")).rawValue))
                            QGCPopupDialogFactory {
                                id: _dlgFactory1
                                dialogComponent: _dlgFactory1Component
                            }
                            Component {
                                id: _dlgFactory1Component
                                APMCalcAmpsPerVoltDialog { }
                            }
                            RowLayout {
                                Layout.fillWidth: true
                                spacing: ScreenTools.defaultFontPixelWidth
                                QGCLabel {
                                    text: qsTranslate("APMPower.VehicleConfig.json", "Amps per volt")
                                    Layout.fillWidth: true
                                }
                                QGCButton {
                                    text: qsTranslate("APMPower.VehicleConfig.json", "Calculate")
                                    onClicked: _dlgFactory1.open({ "batteryIndex": _rawIndex })
                                }
                                FactTextField {
                                    fact: controller.getParameterFact(-1, _fullParamName("AMP_PERVLT"), false)
                                }
                            }
                        }

                        LabelledFactTextField {
                            visible: fact !== null && (controller.parameterExists(-1, _fullParamName("AMP_OFFSET")) && [_monitorParamValueAnalogVoltageAndCurrent, _monitorParamValueAnalogCurrentOnly].includes(controller.getParameterFact(-1, _fullParamName("MONITOR")).rawValue))
                            label: qsTranslate("APMPower.VehicleConfig.json", "Amps offset")
                            Layout.fillWidth: true
                            fact: controller.getParameterFact(-1, _fullParamName("AMP_OFFSET"), false)
                        }
                    }
                }

                ConfigSection {
                    Layout.fillWidth: true
                    visible: sectionMatchesFilter("Disabled Batteries") && _hasDisabledBattery
                    property bool _hasDisabledBattery: {
                        for (var i = 0; i < _batteryCount; i++) {
                            if (controller.getParameterFact(-1, _battPrefixForIndex(i) + "MONITOR").value === _monitorParamValueDisabled)
                                return true
                        }
                        return false
                    }
                    heading: qsTranslate("APMPower.VehicleConfig.json", "Disabled Batteries")

                    Repeater {
                        model: _batteryCount

                        FactCheckBoxSlider {
                            visible: controller.getParameterFact(-1, _battPrefixForIndex(index) + "MONITOR").value === _monitorParamValueDisabled
                            text: _batteryCount > 1 ? qsTranslate("APMPower.VehicleConfig.json", "Battery") + " " + _battLabelForIndex(index) : qsTranslate("APMPower.VehicleConfig.json", "Battery")
                            fact: controller.getParameterFact(-1, _battPrefixForIndex(index) + "MONITOR")
                            checkedValue: _monitorParamValueAnalogVoltageAndCurrent
                            uncheckedValue: _monitorParamValueDisabled
                            Layout.fillWidth: true
                        }
                    }
                }
            }
        }
    }
}
