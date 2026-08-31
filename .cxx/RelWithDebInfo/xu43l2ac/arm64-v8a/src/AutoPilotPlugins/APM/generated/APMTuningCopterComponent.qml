// This file is auto-generated. Do not edit.
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import QGroundControl
import QGroundControl.FactControls
import QGroundControl.Controls

SetupPage {
    id: configPage
    pageComponent: pageComponent

    Component {
        id: pageComponent

        Item {
            width: Math.max(availableWidth, outerColumn.width)
            height: outerColumn.height

            FactPanelController {
                id: controller
            }

            property real _margins: ScreenTools.defaultFontPixelHeight

            property string sectionNameFilter: ""

            readonly property var _searchTerms: ({
                "Flight Response": ["atc_input_tc", "atc_rat_rll_p", "climb", "climb sensitivity", "flight", "minimum thrust", "mot_spin_arm", "mot_spin_min", "motor", "pid", "pitch", "psc_d_acc_p", "rc roll/pitch feel", "response", "roll", "roll/pitch sensitivity", "sensitivity", "spin while armed", "thrust", "tuning"],
                "AutoTune": ["aggressiveness", "auto tune", "autotune", "autotune_aggr", "autotune_axes", "autotune_min_d", "axes", "axes to autotune", "channel", "minimum d gain", "switch"],
                "In Flight Tuning": ["channel 6", "flight", "in", "in flight tuning", "max", "min", "rc channel 6 option (tuning)", "rc tuning", "tune", "tune_max", "tune_min", "tuning"]
            })

            readonly property var _translatableSearchTerms: ({
                "Flight Response": ["Climb Sensitivity", "Flight Response", "Minimum Thrust", "RC Roll/Pitch Feel", "Roll/Pitch Sensitivity", "Spin While Armed", "climb", "motor", "pid", "pitch", "roll", "sensitivity", "thrust", "tuning"],
                "AutoTune": ["Aggressiveness", "AutoTune", "Axes to AutoTune", "Minimum D gain", "auto tune", "autotune", "axes", "channel", "switch"],
                "In Flight Tuning": ["In Flight Tuning", "Max", "Min", "RC Channel 6 Option (Tuning)", "channel 6", "in flight tuning", "rc tuning", "tune"]
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
                        if (qsTranslate("APMTuningCopter.VehicleConfig.json", trTerms[j]).toLowerCase().indexOf(filter) >= 0) return true
                    }
                }
                return false
            }

            function sectionVisible(name) {
                if (name === "Flight Response") return controller.vehicle.multiRotor
                if (name === "AutoTune") return controller.vehicle.multiRotor
                if (name === "In Flight Tuning") return controller.vehicle.multiRotor
                return true
            }

            property real _maxLeftMargin: ScreenTools.defaultFontPixelWidth * 20

            ColumnLayout {
                id: outerColumn
                spacing: _margins * 1.25
                anchors.left: parent.left
                anchors.leftMargin: Math.min((parent.width - width) / 2, _maxLeftMargin)

                ConfigSection {
                    Layout.fillWidth: true
                    visible: sectionMatchesFilter("Flight Response") && controller.vehicle.multiRotor
                    heading: qsTranslate("APMTuningCopter.VehicleConfig.json", "Flight Response")

                    SettingsGroupLayout {
                        Layout.fillWidth: true
                        Layout.minimumWidth: ScreenTools.defaultFontPixelWidth * 60
                        heading: qsTranslate("APMTuningCopter.VehicleConfig.json", "Roll/Pitch Sensitivity")
                        headingDescription: qsTranslate("APMTuningCopter.VehicleConfig.json", "Slide to the right if the copter is sluggish or slide to the left if the copter is twitchy")
                        visible: controller.getParameterFact(-1, "ATC_RAT_RLL_P", false) !== null

                        FactSlider {
                            Layout.fillWidth: true
                            fact: controller.getParameterFact(-1, "ATC_RAT_RLL_P", false)
                            from: 0.08
                            to: 0.4
                            majorTickStepSize: 0.02
                            decimalPlaces: 3
                            onValueChanged: {
                                controller.getParameterFact(-1, "ATC_RAT_RLL_I").rawValue = value
                                controller.getParameterFact(-1, "ATC_RAT_PIT_P").rawValue = value
                                controller.getParameterFact(-1, "ATC_RAT_PIT_I").rawValue = value
                            }
                        }
                    }

                    SettingsGroupLayout {
                        Layout.fillWidth: true
                        Layout.minimumWidth: ScreenTools.defaultFontPixelWidth * 60
                        heading: qsTranslate("APMTuningCopter.VehicleConfig.json", "Climb Sensitivity")
                        headingDescription: qsTranslate("APMTuningCopter.VehicleConfig.json", "Slide to the right to climb more aggressively or slide to the left to climb more gently")
                        visible: controller.getParameterFact(-1, "PSC_D_ACC_P", false) !== null

                        FactSlider {
                            Layout.fillWidth: true
                            fact: controller.getParameterFact(-1, "PSC_D_ACC_P", false)
                            from: 0.03
                            to: 1.0
                            majorTickStepSize: 0.05
                            decimalPlaces: 3
                            onValueChanged: {
                                controller.getParameterFact(-1, "PSC_D_ACC_I").rawValue = value * 2
                            }
                        }
                    }

                    SettingsGroupLayout {
                        Layout.fillWidth: true
                        Layout.minimumWidth: ScreenTools.defaultFontPixelWidth * 60
                        heading: qsTranslate("APMTuningCopter.VehicleConfig.json", "RC Roll/Pitch Feel")
                        headingDescription: qsTranslate("APMTuningCopter.VehicleConfig.json", "Slide to the left for soft control, slide to the right for crisp control")
                        visible: controller.getParameterFact(-1, "ATC_INPUT_TC", false) !== null

                        FactSlider {
                            Layout.fillWidth: true
                            fact: controller.getParameterFact(-1, "ATC_INPUT_TC", false)
                            majorTickStepSize: fact ? fact.increment : 1
                        }
                    }

                    SettingsGroupLayout {
                        Layout.fillWidth: true
                        Layout.minimumWidth: ScreenTools.defaultFontPixelWidth * 60
                        heading: qsTranslate("APMTuningCopter.VehicleConfig.json", "Spin While Armed")
                        headingDescription: qsTranslate("APMTuningCopter.VehicleConfig.json", "Adjust the amount the motors spin to indicate armed. Should be lower than Minimum Thrust.")
                        visible: controller.getParameterFact(-1, "MOT_SPIN_ARM", false) !== null

                        FactSlider {
                            Layout.fillWidth: true
                            fact: controller.getParameterFact(-1, "MOT_SPIN_ARM", false)
                            from: 0
                            to: 0.3
                            majorTickStepSize: 0.1
                            decimalPlaces: 1
                        }
                    }

                    SettingsGroupLayout {
                        Layout.fillWidth: true
                        Layout.minimumWidth: ScreenTools.defaultFontPixelWidth * 60
                        heading: qsTranslate("APMTuningCopter.VehicleConfig.json", "Minimum Thrust")
                        headingDescription: qsTranslate("APMTuningCopter.VehicleConfig.json", "Adjust the minimum amount of thrust required for the vehicle to move. Should be higher than Spin While Armed.")
                        visible: controller.getParameterFact(-1, "MOT_SPIN_MIN", false) !== null

                        FactSlider {
                            Layout.fillWidth: true
                            fact: controller.getParameterFact(-1, "MOT_SPIN_MIN", false)
                            from: 0
                            to: 0.3
                            majorTickStepSize: 0.1
                            decimalPlaces: 1
                        }
                    }
                }

                ConfigSection {
                    Layout.fillWidth: true
                    visible: sectionMatchesFilter("AutoTune") && controller.vehicle.multiRotor
                    heading: qsTranslate("APMTuningCopter.VehicleConfig.json", "AutoTune")

                    FactBitmask {
                        visible: fact !== null
                        fact: controller.getParameterFact(-1, "AUTOTUNE_AXES", false)
                        Layout.preferredWidth: 0
                        Layout.fillWidth: true
                    }

                    APMAutoTuneChannelSelector {
                        controller: controller
                        Layout.fillWidth: true
                    }

                    LabelledFactTextField {
                        visible: fact !== null
                        label: qsTranslate("APMTuningCopter.VehicleConfig.json", "Aggressiveness")
                        Layout.fillWidth: true
                        fact: controller.getParameterFact(-1, "AUTOTUNE_AGGR", false)
                    }

                    LabelledFactTextField {
                        visible: fact !== null
                        label: qsTranslate("APMTuningCopter.VehicleConfig.json", "Minimum D gain")
                        Layout.fillWidth: true
                        fact: controller.getParameterFact(-1, "AUTOTUNE_MIN_D", false)
                    }
                }

                ConfigSection {
                    Layout.fillWidth: true
                    visible: sectionMatchesFilter("In Flight Tuning") && controller.vehicle.multiRotor
                    heading: qsTranslate("APMTuningCopter.VehicleConfig.json", "In Flight Tuning")

                    LabelledFactComboBox {
                        visible: fact !== null
                        label: qsTranslate("APMTuningCopter.VehicleConfig.json", "RC Channel 6 Option (Tuning)")
                        Layout.fillWidth: true
                        comboBoxPreferredWidth: ScreenTools.defaultFontPixelWidth * 30
                        fact: controller.getParameterFact(-1, "TUNE", false)
                        indexModel: false
                    }

                    LabelledFactTextField {
                        visible: fact !== null
                        label: qsTranslate("APMTuningCopter.VehicleConfig.json", "Min")
                        Layout.fillWidth: true
                        fact: controller.getParameterFact(-1, "TUNE_MIN", false)
                    }

                    LabelledFactTextField {
                        visible: fact !== null
                        label: qsTranslate("APMTuningCopter.VehicleConfig.json", "Max")
                        Layout.fillWidth: true
                        fact: controller.getParameterFact(-1, "TUNE_MAX", false)
                    }
                }
            }
        }
    }
}
