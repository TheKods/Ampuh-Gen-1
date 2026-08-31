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
                "Storage": ["backend", "bitmask", "free space", "log", "log_backend_type", "log_bitmask", "log_file_mb_free", "log_max_files", "logged data groups", "logging", "logging backends", "mavlink stream", "max files", "maximum retained log files", "minimum free space (mb)", "onboard flash", "sd card", "storage"],
                "Rate Limits": ["block rate", "file rate", "hz", "limit", "limits", "log_blk_ratemax", "log_file_ratemax", "log_mav_ratemax", "logging rate", "mavlink rate", "maximum block logging rate (hz)", "maximum file logging rate (hz)", "maximum mavlink stream rate (hz)", "rate"],
                "Options": ["disarmed", "ek3_log_level", "ekf", "ekf3", "ekf3 logging verbosity", "log extra data for ekf replay", "log options", "log while disarmed", "log_disarmed", "log_file_dsrmrot", "log_replay", "options", "pre-arm", "replay", "rotate", "rotate log file on disarm/rearm"]
            })

            readonly property var _translatableSearchTerms: ({
                "Storage": ["Logged data groups", "Logging backends", "Maximum retained log files", "Minimum free space (MB)", "Storage", "backend", "bitmask", "free space", "log", "logging", "mavlink stream", "max files", "onboard flash", "sd card"],
                "Rate Limits": ["Maximum MAVLink stream rate (Hz)", "Maximum block logging rate (Hz)", "Maximum file logging rate (Hz)", "Rate Limits", "block rate", "file rate", "hz", "limit", "logging rate", "mavlink rate", "rate"],
                "Options": ["EKF3 logging verbosity", "Log extra data for EKF replay", "Log while disarmed", "Options", "Rotate log file on disarm/rearm", "disarmed", "ekf", "ekf3", "log options", "pre-arm", "replay", "rotate"]
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
                        if (qsTranslate("APMLogging.VehicleConfig.json", trTerms[j]).toLowerCase().indexOf(filter) >= 0) return true
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

                ConfigSection {
                    Layout.fillWidth: true
                    visible: sectionMatchesFilter("Storage")
                    heading: qsTranslate("APMLogging.VehicleConfig.json", "Storage")

                    FactBitmask {
                        visible: fact !== null
                        fact: controller.getParameterFact(-1, "LOG_BACKEND_TYPE", false)
                        Layout.preferredWidth: 0
                        Layout.fillWidth: true
                    }

                    FactBitmask {
                        visible: fact !== null
                        fact: controller.getParameterFact(-1, "LOG_BITMASK", false)
                        Layout.preferredWidth: 0
                        Layout.fillWidth: true
                    }

                    LabelledFactTextField {
                        visible: fact !== null
                        label: qsTranslate("APMLogging.VehicleConfig.json", "Maximum retained log files")
                        Layout.fillWidth: true
                        fact: controller.getParameterFact(-1, "LOG_MAX_FILES", false)
                    }

                    LabelledFactTextField {
                        visible: fact !== null
                        label: qsTranslate("APMLogging.VehicleConfig.json", "Minimum free space (MB)")
                        Layout.fillWidth: true
                        fact: controller.getParameterFact(-1, "LOG_FILE_MB_FREE", false)
                    }
                }

                ConfigSection {
                    Layout.fillWidth: true
                    visible: sectionMatchesFilter("Rate Limits")
                    heading: qsTranslate("APMLogging.VehicleConfig.json", "Rate Limits")

                    LabelledFactTextField {
                        visible: fact !== null
                        label: qsTranslate("APMLogging.VehicleConfig.json", "Maximum file logging rate (Hz)")
                        Layout.fillWidth: true
                        fact: controller.getParameterFact(-1, "LOG_FILE_RATEMAX", false)
                    }

                    LabelledFactTextField {
                        visible: fact !== null
                        label: qsTranslate("APMLogging.VehicleConfig.json", "Maximum block logging rate (Hz)")
                        Layout.fillWidth: true
                        fact: controller.getParameterFact(-1, "LOG_BLK_RATEMAX", false)
                    }

                    LabelledFactTextField {
                        visible: fact !== null
                        label: qsTranslate("APMLogging.VehicleConfig.json", "Maximum MAVLink stream rate (Hz)")
                        Layout.fillWidth: true
                        fact: controller.getParameterFact(-1, "LOG_MAV_RATEMAX", false)
                    }
                }

                ConfigSection {
                    Layout.fillWidth: true
                    visible: sectionMatchesFilter("Options")
                    heading: qsTranslate("APMLogging.VehicleConfig.json", "Options")

                    LabelledFactComboBox {
                        visible: fact !== null
                        label: qsTranslate("APMLogging.VehicleConfig.json", "Log while disarmed")
                        Layout.fillWidth: true
                        comboBoxPreferredWidth: ScreenTools.defaultFontPixelWidth * 30
                        fact: controller.getParameterFact(-1, "LOG_DISARMED", false)
                        indexModel: false
                    }

                    LabelledFactComboBox {
                        visible: fact !== null
                        label: qsTranslate("APMLogging.VehicleConfig.json", "Rotate log file on disarm/rearm")
                        Layout.fillWidth: true
                        comboBoxPreferredWidth: ScreenTools.defaultFontPixelWidth * 30
                        fact: controller.getParameterFact(-1, "LOG_FILE_DSRMROT", false)
                        indexModel: false
                    }

                    LabelledFactComboBox {
                        visible: fact !== null
                        label: qsTranslate("APMLogging.VehicleConfig.json", "Log extra data for EKF replay")
                        Layout.fillWidth: true
                        comboBoxPreferredWidth: ScreenTools.defaultFontPixelWidth * 30
                        fact: controller.getParameterFact(-1, "LOG_REPLAY", false)
                        indexModel: false
                    }

                    LabelledComboBox {
                        property var _fact: controller.getParameterFact(-1, "EK3_LOG_LEVEL", false)
                        label: qsTranslate("APMLogging.VehicleConfig.json", "EKF3 logging verbosity")
                        Layout.fillWidth: true
                        comboBoxPreferredWidth: ScreenTools.defaultFontPixelWidth * 30
                        model: [qsTranslate("APMLogging.VehicleConfig.json", "Full logging"), qsTranslate("APMLogging.VehicleConfig.json", "XKF4 scaled innovations only"), qsTranslate("APMLogging.VehicleConfig.json", "XKF4 and GSF"), qsTranslate("APMLogging.VehicleConfig.json", "Disabled")]
                        property var _enumValues: [0, 1, 2, 3]
                        currentIndex: { var v = _fact ? _fact.rawValue : 0; var i = _enumValues.indexOf(v); return i >= 0 ? i : 0 }
                        onActivated: (index) => { if (_fact) _fact.rawValue = _enumValues[index] }
                        visible: _fact !== null
                    }
                }
            }
        }
    }
}
