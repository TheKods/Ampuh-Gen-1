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

            readonly property var _monitorParamValueDisabled: 0
            readonly property var _copterGcsParamValueRtl: 1
            readonly property var _copterGcsParamValueSmartRtlOrRtl: 3
            readonly property var _copterGcsParamValueSmartRtlOrLand: 4
            readonly property var _copterGcsParamValueLand: 5
            readonly property var _copterGcsParamValueAutoDoLandOrRtl: 6
            readonly property var _copterGcsParamValueBrakeOrLand: 7
            readonly property var _copterThrParamValueRtl: 1
            readonly property var _copterThrParamValueLand: 3
            readonly property var _copterThrParamValueSmartRtlOrRtl: 4
            readonly property var _copterThrParamValueSmartRtlOrLand: 5
            readonly property var _copterThrParamValueAutoDoLandOrRtl: 6
            readonly property var _copterThrParamValueBrakeOrLand: 7
            readonly property var _planeGcsParamValueHeartbeat: 1
            readonly property var _planeGcsParamValueHeartbeatAndRssi: 2
            readonly property var _planeGcsParamValueHeartbeatAndAuto: 3
            readonly property var _planeThrFsParamValueEnabled: 1
            readonly property var _roverFsParamValueEnabled: 1
            readonly property var _roverFsParamValueEnabledIgnoreAuto: 2
            readonly property var _roverFsActionParamValueNothing: 0
            readonly property var _roverFsActionParamValueRtl: 1
            readonly property var _roverFsActionParamValueHold: 2
            readonly property var _roverFsActionParamValueSmartRtlOrRtl: 3
            readonly property var _roverFsActionParamValueSmartRtlOrHold: 4
            readonly property var _roverFsActionParamValueTerminate: 5
            readonly property var _roverFsActionParamValueLoiterOrHold: 6
            readonly property var _copterEkfParamValueLandIfPosRequired: 1
            readonly property var _copterEkfParamValueAltHoldIfPosRequired: 2
            readonly property var _copterEkfParamValueLandAllModes: 3
            readonly property var _roverEkfParamValueHold: 1
            readonly property var _roverEkfParamValueReportOnly: 2
            readonly property var _drParamValueLand: 1
            readonly property var _drParamValueRtl: 2
            readonly property var _drParamValueSmartRtlOrRtl: 3
            readonly property var _drParamValueSmartRtlOrLand: 4
            readonly property var _drParamValueAutoLandOrRtl: 6
            readonly property var _roverCrashParamValueHold: 1
            readonly property var _roverCrashParamValueHoldAndDisarm: 2

            property var _roverFirmware: controller.parameterExists(-1, "MODE1")
            property var _fsOptionsAvailable: controller.parameterExists(-1, "FS_OPTIONS")
            property var _copterGcsEnable: controller.getParameterFact(-1, "FS_GCS_ENABLE", false)
            property var _planeGcsEnable: controller.getParameterFact(-1, "FS_GCS_ENABL", false)
            property var _roverGcsEnable: controller.getParameterFact(-1, "FS_GCS_ENABLE", false)
            property var _planeThrFailsafe: controller.getParameterFact(-1, "THR_FAILSAFE", false)
            property var _copterThrEnable: controller.getParameterFact(-1, "FS_THR_ENABLE", false)
            property var _roverThrEnable: controller.getParameterFact(-1, "FS_THR_ENABLE", false)
            property var _roverFsAction: controller.getParameterFact(-1, "FS_ACTION", false)
            property var _copterEkfAction: controller.getParameterFact(-1, "FS_EKF_ACTION", false)
            property var _roverEkfAction: controller.getParameterFact(-1, "FS_EKF_ACTION", false)
            property var _drEnable: controller.getParameterFact(-1, "FS_DR_ENABLE", false)
            property var _roverCrashCheck: controller.getParameterFact(-1, "FS_CRASH_CHECK", false)

            property var _copterGcsEnabled: _copterGcsEnable && _copterGcsEnable.rawValue !== 0
            property var _planeGcsEnabled: _planeGcsEnable && _planeGcsEnable.rawValue !== 0
            property var _roverGcsEnabled: _roverGcsEnable && _roverGcsEnable.rawValue !== 0
            property var _copterThrEnabled: _copterThrEnable && _copterThrEnable.rawValue !== 0
            property var _roverThrEnabled: _roverThrEnable && _roverThrEnable.rawValue !== 0
            property var _planeThrEnabled: _planeThrFailsafe && _planeThrFailsafe.value === _planeThrFsParamValueEnabled
            property var _copterEkfEnabled: _copterEkfAction && _copterEkfAction.rawValue !== 0
            property var _roverEkfEnabled: _roverEkfAction && _roverEkfAction.rawValue !== 0
            property var _drEnabled: _drEnable && _drEnable.rawValue !== 0
            property var _roverCrashEnabled: _roverCrashCheck && _roverCrashCheck.rawValue !== 0

            function _battPrefixForIndex(_i) {
                if (_i === 0) return "BATT_"
                if (_i <= 8) return "BATT" + (_i + 1) + "_"
                return "BATT" + String.fromCharCode(65 + _i - 9) + "_"
            }
            function _battLabelForIndex(_i) {
                if (_i <= 8) return String(_i + 1)
                return String.fromCharCode(65 + _i - 9)
            }
            property int _battery_failsafeCount: {
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
                "Battery Failsafe": ["battery", "capacity", "critical action", "critical battery", "critical mah threshold", "critical voltage threshold", "crt_mah", "crt_volt", "failsafe", "fs_crt_act", "fs_low_act", "lipo", "low action", "low battery", "low mah threshold", "low voltage threshold", "low_mah", "low_volt", "mah", "power", "voltage"],
                "Ground Station Failsafe": ["disconnect", "enabled", "failsafe", "fs_gcs_timeout", "fs_options", "gcs", "ground", "ground station", "heartbeat", "ignore failsafe if:", "in auto mode", "in hold mode", "link loss", "rssi", "station", "telemetry", "timeout"],
                "Failsafe Triggers": ["failsafe", "fs_long_actn", "fs_long_timeout", "fs_short_actn", "long failsafe", "long failsafe action", "long failsafe timeout", "pwm", "pwm threshold", "q_trans_fail", "q_trans_fail_act", "short failsafe", "short failsafe action", "thr_fs_value", "throttle", "throttle pwm threshold", "triggers", "vtol transition", "vtol transition failure action", "vtol transition failure timeout"],
                "RC Failsafe": ["always enabled", "failsafe", "fs_options", "ignore failsafe if:", "in auto mode", "in guided mode", "landing", "radio", "rc", "rc loss", "receiver", "signal loss", "transmitter"],
                "Throttle Failsafe": ["action:", "enabled", "failsafe", "fs_action", "fs_options", "fs_thr_value", "fs_timeout", "ignore failsafe if:", "in auto mode", "in hold mode", "pwm", "pwm threshold", "rc loss", "receiver", "signal loss", "throttle", "timeout"],
                "EKF Failsafe": ["action:", "ekf", "enabled", "extended kalman filter", "failsafe", "fs_ekf_action", "fs_ekf_thresh", "gps loss", "navigation", "position estimate", "threshold"],
                "Dead Reckoning Failsafe": ["action:", "dead", "dead reckoning", "enabled", "failsafe", "fs_dr_enable", "fs_dr_timeout", "fs_options", "gps loss", "ignore failsafe if:", "landing", "navigation", "position estimate", "reckoning", "timeout"],
                "Other Failsafe Options": ["action:", "crash", "crash check failsafe", "failsafe", "fs_crash_check", "gripper", "options", "other", "vibration"]
            })

            readonly property var _translatableSearchTerms: ({
                "Battery Failsafe": ["Battery Failsafe", "Critical action", "Critical mAh threshold", "Critical voltage threshold", "Low action", "Low mAh threshold", "Low voltage threshold", "capacity", "critical battery", "lipo", "low battery", "mah", "power", "voltage"],
                "Ground Station Failsafe": ["Enabled", "Ground Station Failsafe", "Ignore failsafe if:", "In Auto mode", "In Hold mode", "Timeout", "disconnect", "gcs", "ground station", "heartbeat", "link loss", "rssi", "telemetry"],
                "Failsafe Triggers": ["Failsafe Triggers", "Long failsafe action", "Long failsafe timeout", "PWM threshold", "Short failsafe action", "Throttle PWM threshold", "VTOL transition failure action", "VTOL transition failure timeout", "long failsafe", "pwm", "short failsafe", "throttle", "vtol transition"],
                "RC Failsafe": ["Always enabled", "Ignore failsafe if:", "In Auto mode", "In Guided mode", "Landing", "RC Failsafe", "radio", "rc loss", "receiver", "signal loss", "transmitter"],
                "Throttle Failsafe": ["Action:", "Enabled", "Ignore failsafe if:", "In Auto mode", "In Hold mode", "PWM threshold", "Throttle Failsafe", "Timeout", "pwm", "rc loss", "receiver", "signal loss", "throttle"],
                "EKF Failsafe": ["Action:", "EKF Failsafe", "Enabled", "Threshold", "ekf", "extended kalman filter", "gps loss", "navigation", "position estimate"],
                "Dead Reckoning Failsafe": ["Action:", "Dead Reckoning Failsafe", "Enabled", "Ignore failsafe if:", "Landing", "Timeout", "dead reckoning", "gps loss", "navigation", "position estimate"],
                "Other Failsafe Options": ["Action:", "Crash check failsafe", "Other Failsafe Options", "crash", "gripper", "vibration"]
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
                        if (qsTranslate("APMFailsafes.VehicleConfig.json", trTerms[j]).toLowerCase().indexOf(filter) >= 0) return true
                    }
                }
                return false
            }

            function sectionVisible(name) {
                if (name === "Ground Station Failsafe") return controller.vehicle.multiRotor || controller.vehicle.fixedWing || _roverFirmware
                if (name === "Failsafe Triggers") return controller.vehicle.fixedWing
                if (name === "RC Failsafe") return controller.vehicle.multiRotor
                if (name === "Throttle Failsafe") return controller.vehicle.multiRotor || _roverFirmware
                if (name === "EKF Failsafe") return controller.vehicle.multiRotor || _roverFirmware
                if (name === "Dead Reckoning Failsafe") return controller.vehicle.multiRotor && controller.parameterExists(-1, "FS_DR_ENABLE")
                if (name === "Other Failsafe Options") return controller.vehicle.multiRotor || _roverFirmware
                return true
            }

            property real _maxLeftMargin: ScreenTools.defaultFontPixelWidth * 20

            ColumnLayout {
                id: outerColumn
                spacing: _margins * 1.25
                anchors.left: parent.left
                anchors.leftMargin: Math.min((parent.width - width) / 2, _maxLeftMargin)

                Repeater {
                    model: _battery_failsafeCount

                    ConfigSection {
                        Layout.fillWidth: true
                        visible: sectionMatchesFilter(heading) && controller.getParameterFact(-1, _fullParamName("MONITOR")).value !== _monitorParamValueDisabled
                        heading: _battery_failsafeCount > 1 ? qsTranslate("APMFailsafes.VehicleConfig.json", "Battery Failsafe") + " " + _displayIndex : qsTranslate("APMFailsafes.VehicleConfig.json", "Battery Failsafe")
                        iconSource: "/qmlimages/Battery.svg"

                        property int _rawIndex: index
                        property string _prefix: _battPrefixForIndex(_rawIndex)
                        property string _displayIndex: _battLabelForIndex(_rawIndex)
                        function _fullParamName(postfix) { return _prefix + postfix }

                        LabelledFactComboBox {
                            visible: fact !== null && (controller.parameterExists(-1, _fullParamName("FS_LOW_ACT")))
                            label: qsTranslate("APMFailsafes.VehicleConfig.json", "Low action")
                            Layout.fillWidth: true
                            comboBoxPreferredWidth: ScreenTools.defaultFontPixelWidth * 30
                            fact: controller.getParameterFact(-1, _fullParamName("FS_LOW_ACT"), false)
                            indexModel: false
                        }

                        LabelledFactComboBox {
                            visible: fact !== null && (controller.parameterExists(-1, _fullParamName("FS_CRT_ACT")))
                            label: qsTranslate("APMFailsafes.VehicleConfig.json", "Critical action")
                            Layout.fillWidth: true
                            comboBoxPreferredWidth: ScreenTools.defaultFontPixelWidth * 30
                            fact: controller.getParameterFact(-1, _fullParamName("FS_CRT_ACT"), false)
                            indexModel: false
                        }

                        LabelledFactTextField {
                            visible: fact !== null && (controller.parameterExists(-1, _fullParamName("LOW_VOLT")))
                            label: qsTranslate("APMFailsafes.VehicleConfig.json", "Low voltage threshold")
                            Layout.fillWidth: true
                            fact: controller.getParameterFact(-1, _fullParamName("LOW_VOLT"), false)
                        }

                        LabelledFactTextField {
                            visible: fact !== null && (controller.parameterExists(-1, _fullParamName("CRT_VOLT")))
                            label: qsTranslate("APMFailsafes.VehicleConfig.json", "Critical voltage threshold")
                            Layout.fillWidth: true
                            fact: controller.getParameterFact(-1, _fullParamName("CRT_VOLT"), false)
                        }

                        LabelledFactTextField {
                            visible: fact !== null && (controller.parameterExists(-1, _fullParamName("LOW_MAH")))
                            label: qsTranslate("APMFailsafes.VehicleConfig.json", "Low mAh threshold")
                            Layout.fillWidth: true
                            fact: controller.getParameterFact(-1, _fullParamName("LOW_MAH"), false)
                        }

                        LabelledFactTextField {
                            visible: fact !== null && (controller.parameterExists(-1, _fullParamName("CRT_MAH")))
                            label: qsTranslate("APMFailsafes.VehicleConfig.json", "Critical mAh threshold")
                            Layout.fillWidth: true
                            fact: controller.getParameterFact(-1, _fullParamName("CRT_MAH"), false)
                        }
                    }
                }

                ConfigSection {
                    Layout.fillWidth: true
                    visible: sectionMatchesFilter("Ground Station Failsafe") && controller.vehicle.multiRotor
                    heading: qsTranslate("APMFailsafes.VehicleConfig.json", "Ground Station Failsafe")

                    QGCCheckBoxSlider {
                        Layout.fillWidth: true
                        text: qsTranslate("APMFailsafes.VehicleConfig.json", "Enabled")
                        checked: _copterGcsEnabled
                        onClicked: if (checked) { _copterGcsEnable.rawValue = _copterGcsParamValueRtl } else { _copterGcsEnable.rawValue = 0 }
                    }

                    LabelledFactTextField {
                        visible: fact !== null && (_copterGcsEnabled)
                        label: qsTranslate("APMFailsafes.VehicleConfig.json", "Timeout")
                        Layout.fillWidth: true
                        fact: controller.getParameterFact(-1, "FS_GCS_TIMEOUT", false)
                    }

                    ColumnLayout {
                        visible: controller.getParameterFact(-1, "FS_GCS_ENABLE", false) !== null && (_copterGcsEnabled)
                        spacing: 0
                        QGCLabel {
                            text: qsTranslate("APMFailsafes.VehicleConfig.json", "Action:")
                        }
                        ColumnLayout {
                            spacing: 0
                            QGCRadioButton {
                                text: qsTranslate("APMFailsafes.VehicleConfig.json", "RTL")
                                checked: controller.getParameterFact(-1, "FS_GCS_ENABLE", false) ? _copterGcsEnable.rawValue === _copterGcsParamValueRtl : false
                                onClicked: if (controller.getParameterFact(-1, "FS_GCS_ENABLE", false)) { controller.getParameterFact(-1, "FS_GCS_ENABLE", false).rawValue = _copterGcsParamValueRtl }
                            }
                            QGCRadioButton {
                                text: qsTranslate("APMFailsafes.VehicleConfig.json", "Land")
                                checked: controller.getParameterFact(-1, "FS_GCS_ENABLE", false) ? _copterGcsEnable.rawValue === _copterGcsParamValueLand : false
                                onClicked: if (controller.getParameterFact(-1, "FS_GCS_ENABLE", false)) { controller.getParameterFact(-1, "FS_GCS_ENABLE", false).rawValue = _copterGcsParamValueLand }
                            }
                            QGCRadioButton {
                                text: qsTranslate("APMFailsafes.VehicleConfig.json", "SmartRTL or RTL")
                                checked: controller.getParameterFact(-1, "FS_GCS_ENABLE", false) ? _copterGcsEnable.rawValue === _copterGcsParamValueSmartRtlOrRtl : false
                                onClicked: if (controller.getParameterFact(-1, "FS_GCS_ENABLE", false)) { controller.getParameterFact(-1, "FS_GCS_ENABLE", false).rawValue = _copterGcsParamValueSmartRtlOrRtl }
                            }
                            QGCRadioButton {
                                text: qsTranslate("APMFailsafes.VehicleConfig.json", "SmartRTL or Land")
                                checked: controller.getParameterFact(-1, "FS_GCS_ENABLE", false) ? _copterGcsEnable.rawValue === _copterGcsParamValueSmartRtlOrLand : false
                                onClicked: if (controller.getParameterFact(-1, "FS_GCS_ENABLE", false)) { controller.getParameterFact(-1, "FS_GCS_ENABLE", false).rawValue = _copterGcsParamValueSmartRtlOrLand }
                            }
                            QGCRadioButton {
                                text: qsTranslate("APMFailsafes.VehicleConfig.json", "Auto DO_LAND_START or RTL")
                                checked: controller.getParameterFact(-1, "FS_GCS_ENABLE", false) ? _copterGcsEnable.rawValue === _copterGcsParamValueAutoDoLandOrRtl : false
                                onClicked: if (controller.getParameterFact(-1, "FS_GCS_ENABLE", false)) { controller.getParameterFact(-1, "FS_GCS_ENABLE", false).rawValue = _copterGcsParamValueAutoDoLandOrRtl }
                            }
                            QGCRadioButton {
                                text: qsTranslate("APMFailsafes.VehicleConfig.json", "Brake or Land")
                                checked: controller.getParameterFact(-1, "FS_GCS_ENABLE", false) ? _copterGcsEnable.rawValue === _copterGcsParamValueBrakeOrLand : false
                                onClicked: if (controller.getParameterFact(-1, "FS_GCS_ENABLE", false)) { controller.getParameterFact(-1, "FS_GCS_ENABLE", false).rawValue = _copterGcsParamValueBrakeOrLand }
                            }
                        }
                    }

                    QGCLabel {
                        visible: _fsOptionsAvailable && _copterGcsEnabled
                        text: qsTranslate("APMFailsafes.VehicleConfig.json", "Ignore failsafe if:")
                        wrapMode: Text.WordWrap
                        Layout.fillWidth: true
                        Layout.preferredWidth: 0
                    }

                    FactBitMaskCheckBoxSlider {
                        Layout.leftMargin: ScreenTools.defaultFontPixelWidth * 2
                        visible: fact !== null && (_fsOptionsAvailable && _copterGcsEnabled)
                        Layout.fillWidth: true
                        text: qsTranslate("APMFailsafes.VehicleConfig.json", "In Auto mode")
                        fact: controller.getParameterFact(-1, "FS_OPTIONS", false)
                        bitMask: 2
                    }

                    FactBitMaskCheckBoxSlider {
                        Layout.leftMargin: ScreenTools.defaultFontPixelWidth * 2
                        visible: fact !== null && (_fsOptionsAvailable && _copterGcsEnabled)
                        Layout.fillWidth: true
                        text: qsTranslate("APMFailsafes.VehicleConfig.json", "In pilot control")
                        fact: controller.getParameterFact(-1, "FS_OPTIONS", false)
                        bitMask: 16
                    }
                }

                ConfigSection {
                    Layout.fillWidth: true
                    visible: sectionMatchesFilter("Ground Station Failsafe") && controller.vehicle.fixedWing
                    heading: qsTranslate("APMFailsafes.VehicleConfig.json", "Ground Station Failsafe")

                    QGCCheckBoxSlider {
                        Layout.fillWidth: true
                        text: qsTranslate("APMFailsafes.VehicleConfig.json", "Enabled")
                        checked: _planeGcsEnabled
                        onClicked: if (checked) { _planeGcsEnable.rawValue = _planeGcsParamValueHeartbeat } else { _planeGcsEnable.rawValue = 0 }
                    }

                    ColumnLayout {
                        visible: controller.getParameterFact(-1, "FS_GCS_ENABL", false) !== null && (_planeGcsEnabled)
                        spacing: 0
                        QGCLabel {
                            text: qsTranslate("APMFailsafes.VehicleConfig.json", "Trigger:")
                        }
                        ColumnLayout {
                            spacing: 0
                            QGCRadioButton {
                                text: qsTranslate("APMFailsafes.VehicleConfig.json", "Heartbeat")
                                checked: controller.getParameterFact(-1, "FS_GCS_ENABL", false) ? _planeGcsEnable && _planeGcsEnable.rawValue === _planeGcsParamValueHeartbeat : false
                                onClicked: if (controller.getParameterFact(-1, "FS_GCS_ENABL", false)) { controller.getParameterFact(-1, "FS_GCS_ENABL", false).rawValue = _planeGcsParamValueHeartbeat }
                            }
                            QGCRadioButton {
                                text: qsTranslate("APMFailsafes.VehicleConfig.json", "Heartbeat and Remote RSSI")
                                checked: controller.getParameterFact(-1, "FS_GCS_ENABL", false) ? _planeGcsEnable && _planeGcsEnable.rawValue === _planeGcsParamValueHeartbeatAndRssi : false
                                onClicked: if (controller.getParameterFact(-1, "FS_GCS_ENABL", false)) { controller.getParameterFact(-1, "FS_GCS_ENABL", false).rawValue = _planeGcsParamValueHeartbeatAndRssi }
                            }
                            QGCRadioButton {
                                text: qsTranslate("APMFailsafes.VehicleConfig.json", "Heartbeat and AUTO")
                                checked: controller.getParameterFact(-1, "FS_GCS_ENABL", false) ? _planeGcsEnable && _planeGcsEnable.rawValue === _planeGcsParamValueHeartbeatAndAuto : false
                                onClicked: if (controller.getParameterFact(-1, "FS_GCS_ENABL", false)) { controller.getParameterFact(-1, "FS_GCS_ENABL", false).rawValue = _planeGcsParamValueHeartbeatAndAuto }
                            }
                        }
                    }
                }

                ConfigSection {
                    Layout.fillWidth: true
                    visible: sectionMatchesFilter("Ground Station Failsafe") && _roverFirmware
                    heading: qsTranslate("APMFailsafes.VehicleConfig.json", "Ground Station Failsafe")

                    QGCCheckBoxSlider {
                        Layout.fillWidth: true
                        text: qsTranslate("APMFailsafes.VehicleConfig.json", "Enabled")
                        checked: _roverGcsEnabled
                        onClicked: if (checked) { _roverGcsEnable.rawValue = _roverFsParamValueEnabled } else { _roverGcsEnable.rawValue = 0 }
                    }

                    LabelledFactTextField {
                        visible: fact !== null && (_roverGcsEnabled)
                        label: qsTranslate("APMFailsafes.VehicleConfig.json", "Timeout")
                        Layout.fillWidth: true
                        fact: controller.getParameterFact(-1, "FS_GCS_TIMEOUT", false)
                    }

                    QGCLabel {
                        visible: _roverGcsEnabled
                        text: qsTranslate("APMFailsafes.VehicleConfig.json", "Ignore failsafe if:")
                        wrapMode: Text.WordWrap
                        Layout.fillWidth: true
                        Layout.preferredWidth: 0
                    }

                    QGCCheckBoxSlider {
                        Layout.leftMargin: ScreenTools.defaultFontPixelWidth * 2
                        visible: _roverGcsEnabled
                        Layout.fillWidth: true
                        text: qsTranslate("APMFailsafes.VehicleConfig.json", "In Auto mode")
                        checked: _roverGcsEnable ? _roverGcsEnable.rawValue === _roverFsParamValueEnabledIgnoreAuto : false
                        onClicked: if (checked) { _roverGcsEnable.rawValue = _roverFsParamValueEnabledIgnoreAuto } else { _roverGcsEnable.rawValue = _roverFsParamValueEnabled }
                    }

                    FactBitMaskCheckBoxSlider {
                        Layout.leftMargin: ScreenTools.defaultFontPixelWidth * 2
                        visible: fact !== null && (_fsOptionsAvailable && _roverGcsEnabled)
                        Layout.fillWidth: true
                        text: qsTranslate("APMFailsafes.VehicleConfig.json", "In Hold mode")
                        fact: controller.getParameterFact(-1, "FS_OPTIONS", false)
                        bitMask: 1
                    }
                }

                ConfigSection {
                    Layout.fillWidth: true
                    visible: sectionMatchesFilter("Failsafe Triggers") && controller.vehicle.fixedWing
                    heading: qsTranslate("APMFailsafes.VehicleConfig.json", "Failsafe Triggers")

                    QGCCheckBoxSlider {
                        Layout.fillWidth: true
                        text: qsTranslate("APMFailsafes.VehicleConfig.json", "Throttle PWM threshold")
                        checked: _planeThrEnabled
                        onClicked: if (checked) { _planeThrFailsafe.value = _planeThrFsParamValueEnabled } else { _planeThrFailsafe.value = 0 }
                    }

                    LabelledFactTextField {
                        visible: fact !== null && (_planeThrEnabled)
                        label: qsTranslate("APMFailsafes.VehicleConfig.json", "PWM threshold")
                        Layout.fillWidth: true
                        fact: controller.getParameterFact(-1, "THR_FS_VALUE", false)
                    }

                    LabelledFactComboBox {
                        visible: fact !== null
                        label: qsTranslate("APMFailsafes.VehicleConfig.json", "Short failsafe action")
                        Layout.fillWidth: true
                        comboBoxPreferredWidth: ScreenTools.defaultFontPixelWidth * 30
                        fact: controller.getParameterFact(-1, "FS_SHORT_ACTN", false)
                        indexModel: false
                    }

                    LabelledFactComboBox {
                        visible: fact !== null
                        label: qsTranslate("APMFailsafes.VehicleConfig.json", "Long failsafe action")
                        Layout.fillWidth: true
                        comboBoxPreferredWidth: ScreenTools.defaultFontPixelWidth * 30
                        fact: controller.getParameterFact(-1, "FS_LONG_ACTN", false)
                        indexModel: false
                    }

                    LabelledFactTextField {
                        visible: fact !== null
                        label: qsTranslate("APMFailsafes.VehicleConfig.json", "Long failsafe timeout")
                        Layout.fillWidth: true
                        fact: controller.getParameterFact(-1, "FS_LONG_TIMEOUT", false)
                    }

                    LabelledFactComboBox {
                        visible: fact !== null && (controller.parameterExists(-1, "Q_TRANS_FAIL"))
                        label: qsTranslate("APMFailsafes.VehicleConfig.json", "VTOL transition failure action")
                        Layout.fillWidth: true
                        comboBoxPreferredWidth: ScreenTools.defaultFontPixelWidth * 30
                        fact: controller.getParameterFact(-1, "Q_TRANS_FAIL_ACT", false)
                        indexModel: false
                    }

                    LabelledFactTextField {
                        visible: fact !== null && (controller.parameterExists(-1, "Q_TRANS_FAIL"))
                        label: qsTranslate("APMFailsafes.VehicleConfig.json", "VTOL transition failure timeout")
                        Layout.fillWidth: true
                        fact: controller.getParameterFact(-1, "Q_TRANS_FAIL", false)
                    }
                }

                ConfigSection {
                    Layout.fillWidth: true
                    visible: sectionMatchesFilter("RC Failsafe") && controller.vehicle.multiRotor
                    heading: qsTranslate("APMFailsafes.VehicleConfig.json", "RC Failsafe")

                    QGCLabel {
                        text: qsTranslate("APMFailsafes.VehicleConfig.json", "Always enabled")
                        wrapMode: Text.WordWrap
                        Layout.fillWidth: true
                        Layout.preferredWidth: 0
                    }

                    QGCLabel {
                        visible: _fsOptionsAvailable
                        text: qsTranslate("APMFailsafes.VehicleConfig.json", "Ignore failsafe if:")
                        wrapMode: Text.WordWrap
                        Layout.fillWidth: true
                        Layout.preferredWidth: 0
                    }

                    FactBitMaskCheckBoxSlider {
                        Layout.leftMargin: ScreenTools.defaultFontPixelWidth * 2
                        visible: fact !== null && (_fsOptionsAvailable)
                        Layout.fillWidth: true
                        text: qsTranslate("APMFailsafes.VehicleConfig.json", "In Auto mode")
                        fact: controller.getParameterFact(-1, "FS_OPTIONS", false)
                        bitMask: 1
                    }

                    FactBitMaskCheckBoxSlider {
                        Layout.leftMargin: ScreenTools.defaultFontPixelWidth * 2
                        visible: fact !== null && (_fsOptionsAvailable)
                        Layout.fillWidth: true
                        text: qsTranslate("APMFailsafes.VehicleConfig.json", "In Guided mode")
                        fact: controller.getParameterFact(-1, "FS_OPTIONS", false)
                        bitMask: 4
                    }

                    FactBitMaskCheckBoxSlider {
                        Layout.leftMargin: ScreenTools.defaultFontPixelWidth * 2
                        visible: fact !== null && (_fsOptionsAvailable)
                        Layout.fillWidth: true
                        text: qsTranslate("APMFailsafes.VehicleConfig.json", "Landing")
                        fact: controller.getParameterFact(-1, "FS_OPTIONS", false)
                        bitMask: 8
                    }
                }

                ConfigSection {
                    Layout.fillWidth: true
                    visible: sectionMatchesFilter("Throttle Failsafe") && controller.vehicle.multiRotor
                    heading: qsTranslate("APMFailsafes.VehicleConfig.json", "Throttle Failsafe")

                    QGCCheckBoxSlider {
                        Layout.fillWidth: true
                        text: qsTranslate("APMFailsafes.VehicleConfig.json", "Enabled")
                        checked: _copterThrEnabled
                        onClicked: if (checked) { _copterThrEnable.rawValue = _copterThrParamValueRtl } else { _copterThrEnable.rawValue = 0 }
                    }

                    LabelledFactTextField {
                        visible: fact !== null && (_copterThrEnabled)
                        label: qsTranslate("APMFailsafes.VehicleConfig.json", "PWM threshold")
                        Layout.fillWidth: true
                        fact: controller.getParameterFact(-1, "FS_THR_VALUE", false)
                    }

                    ColumnLayout {
                        visible: controller.getParameterFact(-1, "FS_THR_ENABLE", false) !== null && (_copterThrEnabled)
                        spacing: 0
                        QGCLabel {
                            text: qsTranslate("APMFailsafes.VehicleConfig.json", "Action:")
                        }
                        ColumnLayout {
                            spacing: 0
                            QGCRadioButton {
                                text: qsTranslate("APMFailsafes.VehicleConfig.json", "Always RTL")
                                checked: controller.getParameterFact(-1, "FS_THR_ENABLE", false) ? _copterThrEnable.rawValue === _copterThrParamValueRtl : false
                                onClicked: if (controller.getParameterFact(-1, "FS_THR_ENABLE", false)) { controller.getParameterFact(-1, "FS_THR_ENABLE", false).rawValue = _copterThrParamValueRtl }
                            }
                            QGCRadioButton {
                                text: qsTranslate("APMFailsafes.VehicleConfig.json", "Always Land")
                                checked: controller.getParameterFact(-1, "FS_THR_ENABLE", false) ? _copterThrEnable.rawValue === _copterThrParamValueLand : false
                                onClicked: if (controller.getParameterFact(-1, "FS_THR_ENABLE", false)) { controller.getParameterFact(-1, "FS_THR_ENABLE", false).rawValue = _copterThrParamValueLand }
                            }
                            QGCRadioButton {
                                text: qsTranslate("APMFailsafes.VehicleConfig.json", "Always SmartRTL or RTL")
                                checked: controller.getParameterFact(-1, "FS_THR_ENABLE", false) ? _copterThrEnable.rawValue === _copterThrParamValueSmartRtlOrRtl : false
                                onClicked: if (controller.getParameterFact(-1, "FS_THR_ENABLE", false)) { controller.getParameterFact(-1, "FS_THR_ENABLE", false).rawValue = _copterThrParamValueSmartRtlOrRtl }
                            }
                            QGCRadioButton {
                                text: qsTranslate("APMFailsafes.VehicleConfig.json", "Always SmartRTL or Land")
                                checked: controller.getParameterFact(-1, "FS_THR_ENABLE", false) ? _copterThrEnable.rawValue === _copterThrParamValueSmartRtlOrLand : false
                                onClicked: if (controller.getParameterFact(-1, "FS_THR_ENABLE", false)) { controller.getParameterFact(-1, "FS_THR_ENABLE", false).rawValue = _copterThrParamValueSmartRtlOrLand }
                            }
                            QGCRadioButton {
                                text: qsTranslate("APMFailsafes.VehicleConfig.json", "Auto DO_LAND_START or RTL")
                                checked: controller.getParameterFact(-1, "FS_THR_ENABLE", false) ? _copterThrEnable.rawValue === _copterThrParamValueAutoDoLandOrRtl : false
                                onClicked: if (controller.getParameterFact(-1, "FS_THR_ENABLE", false)) { controller.getParameterFact(-1, "FS_THR_ENABLE", false).rawValue = _copterThrParamValueAutoDoLandOrRtl }
                            }
                            QGCRadioButton {
                                text: qsTranslate("APMFailsafes.VehicleConfig.json", "Always Brake or Land")
                                checked: controller.getParameterFact(-1, "FS_THR_ENABLE", false) ? _copterThrEnable.rawValue === _copterThrParamValueBrakeOrLand : false
                                onClicked: if (controller.getParameterFact(-1, "FS_THR_ENABLE", false)) { controller.getParameterFact(-1, "FS_THR_ENABLE", false).rawValue = _copterThrParamValueBrakeOrLand }
                            }
                        }
                    }

                    QGCLabel {
                        visible: _fsOptionsAvailable && _copterThrEnabled
                        text: qsTranslate("APMFailsafes.VehicleConfig.json", "Ignore failsafe if:")
                        wrapMode: Text.WordWrap
                        Layout.fillWidth: true
                        Layout.preferredWidth: 0
                    }

                    FactBitMaskCheckBoxSlider {
                        Layout.leftMargin: ScreenTools.defaultFontPixelWidth * 2
                        visible: fact !== null && (_fsOptionsAvailable && _copterThrEnabled)
                        Layout.fillWidth: true
                        text: qsTranslate("APMFailsafes.VehicleConfig.json", "In Auto mode")
                        fact: controller.getParameterFact(-1, "FS_OPTIONS", false)
                        bitMask: 1
                    }

                    FactBitMaskCheckBoxSlider {
                        Layout.leftMargin: ScreenTools.defaultFontPixelWidth * 2
                        visible: fact !== null && (_fsOptionsAvailable && _copterThrEnabled)
                        Layout.fillWidth: true
                        text: qsTranslate("APMFailsafes.VehicleConfig.json", "In Guided mode")
                        fact: controller.getParameterFact(-1, "FS_OPTIONS", false)
                        bitMask: 4
                    }

                    FactBitMaskCheckBoxSlider {
                        Layout.leftMargin: ScreenTools.defaultFontPixelWidth * 2
                        visible: fact !== null && (_fsOptionsAvailable && _copterThrEnabled)
                        Layout.fillWidth: true
                        text: qsTranslate("APMFailsafes.VehicleConfig.json", "Landing")
                        fact: controller.getParameterFact(-1, "FS_OPTIONS", false)
                        bitMask: 8
                    }
                }

                ConfigSection {
                    Layout.fillWidth: true
                    visible: sectionMatchesFilter("Throttle Failsafe") && _roverFirmware
                    heading: qsTranslate("APMFailsafes.VehicleConfig.json", "Throttle Failsafe")

                    QGCCheckBoxSlider {
                        Layout.fillWidth: true
                        text: qsTranslate("APMFailsafes.VehicleConfig.json", "Enabled")
                        checked: _roverThrEnabled
                        onClicked: if (checked) { _roverThrEnable.rawValue = _roverFsParamValueEnabled } else { _roverThrEnable.rawValue = 0 }
                    }

                    LabelledFactTextField {
                        visible: fact !== null && (_roverThrEnabled)
                        label: qsTranslate("APMFailsafes.VehicleConfig.json", "PWM threshold")
                        Layout.fillWidth: true
                        fact: controller.getParameterFact(-1, "FS_THR_VALUE", false)
                    }

                    LabelledFactTextField {
                        visible: fact !== null && (_roverThrEnabled)
                        label: qsTranslate("APMFailsafes.VehicleConfig.json", "Timeout")
                        Layout.fillWidth: true
                        fact: controller.getParameterFact(-1, "FS_TIMEOUT", false)
                    }

                    ColumnLayout {
                        visible: controller.getParameterFact(-1, "FS_ACTION", false) !== null && (_roverThrEnabled)
                        spacing: 0
                        QGCLabel {
                            text: qsTranslate("APMFailsafes.VehicleConfig.json", "Action:")
                        }
                        ColumnLayout {
                            spacing: 0
                            QGCRadioButton {
                                text: qsTranslate("APMFailsafes.VehicleConfig.json", "Nothing")
                                checked: controller.getParameterFact(-1, "FS_ACTION", false) ? _roverFsAction && _roverFsAction.rawValue === _roverFsActionParamValueNothing : false
                                onClicked: if (controller.getParameterFact(-1, "FS_ACTION", false)) { controller.getParameterFact(-1, "FS_ACTION", false).rawValue = _roverFsActionParamValueNothing }
                            }
                            QGCRadioButton {
                                text: qsTranslate("APMFailsafes.VehicleConfig.json", "RTL")
                                checked: controller.getParameterFact(-1, "FS_ACTION", false) ? _roverFsAction && _roverFsAction.rawValue === _roverFsActionParamValueRtl : false
                                onClicked: if (controller.getParameterFact(-1, "FS_ACTION", false)) { controller.getParameterFact(-1, "FS_ACTION", false).rawValue = _roverFsActionParamValueRtl }
                            }
                            QGCRadioButton {
                                text: qsTranslate("APMFailsafes.VehicleConfig.json", "Hold")
                                checked: controller.getParameterFact(-1, "FS_ACTION", false) ? _roverFsAction && _roverFsAction.rawValue === _roverFsActionParamValueHold : false
                                onClicked: if (controller.getParameterFact(-1, "FS_ACTION", false)) { controller.getParameterFact(-1, "FS_ACTION", false).rawValue = _roverFsActionParamValueHold }
                            }
                            QGCRadioButton {
                                text: qsTranslate("APMFailsafes.VehicleConfig.json", "SmartRTL or RTL")
                                checked: controller.getParameterFact(-1, "FS_ACTION", false) ? _roverFsAction && _roverFsAction.rawValue === _roverFsActionParamValueSmartRtlOrRtl : false
                                onClicked: if (controller.getParameterFact(-1, "FS_ACTION", false)) { controller.getParameterFact(-1, "FS_ACTION", false).rawValue = _roverFsActionParamValueSmartRtlOrRtl }
                            }
                            QGCRadioButton {
                                text: qsTranslate("APMFailsafes.VehicleConfig.json", "SmartRTL or Hold")
                                checked: controller.getParameterFact(-1, "FS_ACTION", false) ? _roverFsAction && _roverFsAction.rawValue === _roverFsActionParamValueSmartRtlOrHold : false
                                onClicked: if (controller.getParameterFact(-1, "FS_ACTION", false)) { controller.getParameterFact(-1, "FS_ACTION", false).rawValue = _roverFsActionParamValueSmartRtlOrHold }
                            }
                            QGCRadioButton {
                                text: qsTranslate("APMFailsafes.VehicleConfig.json", "Terminate")
                                checked: controller.getParameterFact(-1, "FS_ACTION", false) ? _roverFsAction && _roverFsAction.rawValue === _roverFsActionParamValueTerminate : false
                                onClicked: if (controller.getParameterFact(-1, "FS_ACTION", false)) { controller.getParameterFact(-1, "FS_ACTION", false).rawValue = _roverFsActionParamValueTerminate }
                            }
                            QGCRadioButton {
                                text: qsTranslate("APMFailsafes.VehicleConfig.json", "Loiter or Hold")
                                checked: controller.getParameterFact(-1, "FS_ACTION", false) ? _roverFsAction && _roverFsAction.rawValue === _roverFsActionParamValueLoiterOrHold : false
                                onClicked: if (controller.getParameterFact(-1, "FS_ACTION", false)) { controller.getParameterFact(-1, "FS_ACTION", false).rawValue = _roverFsActionParamValueLoiterOrHold }
                            }
                        }
                    }

                    QGCLabel {
                        visible: _roverThrEnabled
                        text: qsTranslate("APMFailsafes.VehicleConfig.json", "Ignore failsafe if:")
                        wrapMode: Text.WordWrap
                        Layout.fillWidth: true
                        Layout.preferredWidth: 0
                    }

                    QGCCheckBoxSlider {
                        Layout.leftMargin: ScreenTools.defaultFontPixelWidth * 2
                        visible: _roverThrEnabled
                        Layout.fillWidth: true
                        text: qsTranslate("APMFailsafes.VehicleConfig.json", "In Auto mode")
                        checked: _roverThrEnable ? _roverThrEnable.rawValue === _roverFsParamValueEnabledIgnoreAuto : false
                        onClicked: if (checked) { _roverThrEnable.rawValue = _roverFsParamValueEnabledIgnoreAuto } else { _roverThrEnable.rawValue = _roverFsParamValueEnabled }
                    }

                    FactBitMaskCheckBoxSlider {
                        Layout.leftMargin: ScreenTools.defaultFontPixelWidth * 2
                        visible: fact !== null && (_fsOptionsAvailable && _roverThrEnabled)
                        Layout.fillWidth: true
                        text: qsTranslate("APMFailsafes.VehicleConfig.json", "In Hold mode")
                        fact: controller.getParameterFact(-1, "FS_OPTIONS", false)
                        bitMask: 1
                    }
                }

                ConfigSection {
                    Layout.fillWidth: true
                    visible: sectionMatchesFilter("EKF Failsafe") && controller.vehicle.multiRotor
                    heading: qsTranslate("APMFailsafes.VehicleConfig.json", "EKF Failsafe")

                    QGCCheckBoxSlider {
                        Layout.fillWidth: true
                        text: qsTranslate("APMFailsafes.VehicleConfig.json", "Enabled")
                        checked: _copterEkfEnabled
                        onClicked: if (checked) { _copterEkfAction.rawValue = _copterEkfParamValueLandIfPosRequired } else { _copterEkfAction.rawValue = 0 }
                    }

                    LabelledFactTextField {
                        visible: fact !== null && (_copterEkfEnabled)
                        label: qsTranslate("APMFailsafes.VehicleConfig.json", "Threshold")
                        Layout.fillWidth: true
                        fact: controller.getParameterFact(-1, "FS_EKF_THRESH", false)
                    }

                    ColumnLayout {
                        visible: controller.getParameterFact(-1, "FS_EKF_ACTION", false) !== null && (_copterEkfEnabled)
                        spacing: 0
                        QGCLabel {
                            text: qsTranslate("APMFailsafes.VehicleConfig.json", "Action:")
                        }
                        ColumnLayout {
                            spacing: 0
                            QGCRadioButton {
                                text: qsTranslate("APMFailsafes.VehicleConfig.json", "Land if position required")
                                checked: controller.getParameterFact(-1, "FS_EKF_ACTION", false) ? _copterEkfAction.rawValue === _copterEkfParamValueLandIfPosRequired : false
                                onClicked: if (controller.getParameterFact(-1, "FS_EKF_ACTION", false)) { controller.getParameterFact(-1, "FS_EKF_ACTION", false).rawValue = _copterEkfParamValueLandIfPosRequired }
                            }
                            QGCRadioButton {
                                text: qsTranslate("APMFailsafes.VehicleConfig.json", "AltHold if position required")
                                checked: controller.getParameterFact(-1, "FS_EKF_ACTION", false) ? _copterEkfAction.rawValue === _copterEkfParamValueAltHoldIfPosRequired : false
                                onClicked: if (controller.getParameterFact(-1, "FS_EKF_ACTION", false)) { controller.getParameterFact(-1, "FS_EKF_ACTION", false).rawValue = _copterEkfParamValueAltHoldIfPosRequired }
                            }
                            QGCRadioButton {
                                text: qsTranslate("APMFailsafes.VehicleConfig.json", "Land from all modes")
                                checked: controller.getParameterFact(-1, "FS_EKF_ACTION", false) ? _copterEkfAction.rawValue === _copterEkfParamValueLandAllModes : false
                                onClicked: if (controller.getParameterFact(-1, "FS_EKF_ACTION", false)) { controller.getParameterFact(-1, "FS_EKF_ACTION", false).rawValue = _copterEkfParamValueLandAllModes }
                            }
                        }
                    }

                    QGCLabel {
                        visible: _fsOptionsAvailable && _copterEkfEnabled
                        text: qsTranslate("APMFailsafes.VehicleConfig.json", "Ignore failsafe if:")
                        wrapMode: Text.WordWrap
                        Layout.fillWidth: true
                        Layout.preferredWidth: 0
                    }

                    FactBitMaskCheckBoxSlider {
                        Layout.leftMargin: ScreenTools.defaultFontPixelWidth * 2
                        visible: fact !== null && (_fsOptionsAvailable && _copterEkfEnabled)
                        Layout.fillWidth: true
                        text: qsTranslate("APMFailsafes.VehicleConfig.json", "Landing")
                        fact: controller.getParameterFact(-1, "FS_OPTIONS", false)
                        bitMask: 8
                    }
                }

                ConfigSection {
                    Layout.fillWidth: true
                    visible: sectionMatchesFilter("EKF Failsafe") && _roverFirmware
                    heading: qsTranslate("APMFailsafes.VehicleConfig.json", "EKF Failsafe")

                    QGCCheckBoxSlider {
                        Layout.fillWidth: true
                        text: qsTranslate("APMFailsafes.VehicleConfig.json", "Enabled")
                        checked: _roverEkfEnabled
                        onClicked: if (checked) { _roverEkfAction.rawValue = _roverEkfParamValueHold } else { _roverEkfAction.rawValue = 0 }
                    }

                    LabelledFactTextField {
                        visible: fact !== null && (_roverEkfEnabled)
                        label: qsTranslate("APMFailsafes.VehicleConfig.json", "Threshold")
                        Layout.fillWidth: true
                        fact: controller.getParameterFact(-1, "FS_EKF_THRESH", false)
                    }

                    ColumnLayout {
                        visible: controller.getParameterFact(-1, "FS_EKF_ACTION", false) !== null && (_roverEkfEnabled)
                        spacing: 0
                        QGCLabel {
                            text: qsTranslate("APMFailsafes.VehicleConfig.json", "Action:")
                        }
                        ColumnLayout {
                            spacing: 0
                            QGCRadioButton {
                                text: qsTranslate("APMFailsafes.VehicleConfig.json", "Hold")
                                checked: controller.getParameterFact(-1, "FS_EKF_ACTION", false) ? _roverEkfAction && _roverEkfAction.rawValue === _roverEkfParamValueHold : false
                                onClicked: if (controller.getParameterFact(-1, "FS_EKF_ACTION", false)) { controller.getParameterFact(-1, "FS_EKF_ACTION", false).rawValue = _roverEkfParamValueHold }
                            }
                            QGCRadioButton {
                                text: qsTranslate("APMFailsafes.VehicleConfig.json", "Report only")
                                checked: controller.getParameterFact(-1, "FS_EKF_ACTION", false) ? _roverEkfAction && _roverEkfAction.rawValue === _roverEkfParamValueReportOnly : false
                                onClicked: if (controller.getParameterFact(-1, "FS_EKF_ACTION", false)) { controller.getParameterFact(-1, "FS_EKF_ACTION", false).rawValue = _roverEkfParamValueReportOnly }
                            }
                        }
                    }
                }

                ConfigSection {
                    Layout.fillWidth: true
                    visible: sectionMatchesFilter("Dead Reckoning Failsafe") && controller.vehicle.multiRotor && controller.parameterExists(-1, "FS_DR_ENABLE")
                    heading: qsTranslate("APMFailsafes.VehicleConfig.json", "Dead Reckoning Failsafe")

                    QGCCheckBoxSlider {
                        Layout.fillWidth: true
                        text: qsTranslate("APMFailsafes.VehicleConfig.json", "Enabled")
                        checked: _drEnabled
                        onClicked: if (checked) { _drEnable.rawValue = _drParamValueLand } else { _drEnable.rawValue = 0 }
                    }

                    LabelledFactTextField {
                        visible: fact !== null && (_drEnabled)
                        label: qsTranslate("APMFailsafes.VehicleConfig.json", "Timeout")
                        Layout.fillWidth: true
                        fact: controller.getParameterFact(-1, "FS_DR_TIMEOUT", false)
                    }

                    ColumnLayout {
                        visible: controller.getParameterFact(-1, "FS_DR_ENABLE", false) !== null && (_drEnabled)
                        spacing: 0
                        QGCLabel {
                            text: qsTranslate("APMFailsafes.VehicleConfig.json", "Action:")
                        }
                        ColumnLayout {
                            spacing: 0
                            QGCRadioButton {
                                text: qsTranslate("APMFailsafes.VehicleConfig.json", "Land")
                                checked: controller.getParameterFact(-1, "FS_DR_ENABLE", false) ? _drEnable.rawValue === _drParamValueLand : false
                                onClicked: if (controller.getParameterFact(-1, "FS_DR_ENABLE", false)) { controller.getParameterFact(-1, "FS_DR_ENABLE", false).rawValue = _drParamValueLand }
                            }
                            QGCRadioButton {
                                text: qsTranslate("APMFailsafes.VehicleConfig.json", "RTL")
                                checked: controller.getParameterFact(-1, "FS_DR_ENABLE", false) ? _drEnable.rawValue === _drParamValueRtl : false
                                onClicked: if (controller.getParameterFact(-1, "FS_DR_ENABLE", false)) { controller.getParameterFact(-1, "FS_DR_ENABLE", false).rawValue = _drParamValueRtl }
                            }
                            QGCRadioButton {
                                text: qsTranslate("APMFailsafes.VehicleConfig.json", "SmartRTL or RTL")
                                checked: controller.getParameterFact(-1, "FS_DR_ENABLE", false) ? _drEnable.rawValue === _drParamValueSmartRtlOrRtl : false
                                onClicked: if (controller.getParameterFact(-1, "FS_DR_ENABLE", false)) { controller.getParameterFact(-1, "FS_DR_ENABLE", false).rawValue = _drParamValueSmartRtlOrRtl }
                            }
                            QGCRadioButton {
                                text: qsTranslate("APMFailsafes.VehicleConfig.json", "SmartRTL or Land")
                                checked: controller.getParameterFact(-1, "FS_DR_ENABLE", false) ? _drEnable.rawValue === _drParamValueSmartRtlOrLand : false
                                onClicked: if (controller.getParameterFact(-1, "FS_DR_ENABLE", false)) { controller.getParameterFact(-1, "FS_DR_ENABLE", false).rawValue = _drParamValueSmartRtlOrLand }
                            }
                            QGCRadioButton {
                                text: qsTranslate("APMFailsafes.VehicleConfig.json", "Auto Land/Return or RTL")
                                checked: controller.getParameterFact(-1, "FS_DR_ENABLE", false) ? _drEnable.rawValue === _drParamValueAutoLandOrRtl : false
                                onClicked: if (controller.getParameterFact(-1, "FS_DR_ENABLE", false)) { controller.getParameterFact(-1, "FS_DR_ENABLE", false).rawValue = _drParamValueAutoLandOrRtl }
                            }
                        }
                    }

                    QGCLabel {
                        visible: _fsOptionsAvailable && _drEnabled
                        text: qsTranslate("APMFailsafes.VehicleConfig.json", "Ignore failsafe if:")
                        wrapMode: Text.WordWrap
                        Layout.fillWidth: true
                        Layout.preferredWidth: 0
                    }

                    FactBitMaskCheckBoxSlider {
                        Layout.leftMargin: ScreenTools.defaultFontPixelWidth * 2
                        visible: fact !== null && (_fsOptionsAvailable && _drEnabled)
                        Layout.fillWidth: true
                        text: qsTranslate("APMFailsafes.VehicleConfig.json", "Landing")
                        fact: controller.getParameterFact(-1, "FS_OPTIONS", false)
                        bitMask: 8
                    }
                }

                ConfigSection {
                    Layout.fillWidth: true
                    visible: sectionMatchesFilter("Other Failsafe Options") && controller.vehicle.multiRotor
                    heading: qsTranslate("APMFailsafes.VehicleConfig.json", "Other Failsafe Options")

                    FactCheckBoxSlider {
                        visible: fact !== null
                        Layout.fillWidth: true
                        text: qsTranslate("APMFailsafes.VehicleConfig.json", "Crash check failsafe")
                        fact: controller.getParameterFact(-1, "FS_CRASH_CHECK", false)
                    }

                    FactCheckBoxSlider {
                        visible: fact !== null
                        Layout.fillWidth: true
                        text: qsTranslate("APMFailsafes.VehicleConfig.json", "Vibration failsafe")
                        fact: controller.getParameterFact(-1, "FS_VIBE_ENABLE", false)
                    }

                    FactBitMaskCheckBoxSlider {
                        visible: fact !== null && (_fsOptionsAvailable)
                        Layout.fillWidth: true
                        text: qsTranslate("APMFailsafes.VehicleConfig.json", "Release gripper on any failsafe")
                        fact: controller.getParameterFact(-1, "FS_OPTIONS", false)
                        bitMask: 32
                    }
                }

                ConfigSection {
                    Layout.fillWidth: true
                    visible: sectionMatchesFilter("Other Failsafe Options") && _roverFirmware
                    heading: qsTranslate("APMFailsafes.VehicleConfig.json", "Other Failsafe Options")

                    QGCCheckBoxSlider {
                        Layout.fillWidth: true
                        text: qsTranslate("APMFailsafes.VehicleConfig.json", "Crash check failsafe")
                        checked: _roverCrashEnabled
                        onClicked: if (checked) { _roverCrashCheck.rawValue = _roverCrashParamValueHold } else { _roverCrashCheck.rawValue = 0 }
                    }

                    ColumnLayout {
                        visible: controller.getParameterFact(-1, "FS_CRASH_CHECK", false) !== null && (_roverCrashEnabled)
                        spacing: 0
                        QGCLabel {
                            text: qsTranslate("APMFailsafes.VehicleConfig.json", "Action:")
                        }
                        ColumnLayout {
                            spacing: 0
                            QGCRadioButton {
                                text: qsTranslate("APMFailsafes.VehicleConfig.json", "Hold")
                                checked: controller.getParameterFact(-1, "FS_CRASH_CHECK", false) ? _roverCrashCheck.rawValue === _roverCrashParamValueHold : false
                                onClicked: if (controller.getParameterFact(-1, "FS_CRASH_CHECK", false)) { controller.getParameterFact(-1, "FS_CRASH_CHECK", false).rawValue = _roverCrashParamValueHold }
                            }
                            QGCRadioButton {
                                text: qsTranslate("APMFailsafes.VehicleConfig.json", "Hold and Disarm")
                                checked: controller.getParameterFact(-1, "FS_CRASH_CHECK", false) ? _roverCrashCheck.rawValue === _roverCrashParamValueHoldAndDisarm : false
                                onClicked: if (controller.getParameterFact(-1, "FS_CRASH_CHECK", false)) { controller.getParameterFact(-1, "FS_CRASH_CHECK", false).rawValue = _roverCrashParamValueHoldAndDisarm }
                            }
                        }
                    }
                }
            }
        }
    }
}
