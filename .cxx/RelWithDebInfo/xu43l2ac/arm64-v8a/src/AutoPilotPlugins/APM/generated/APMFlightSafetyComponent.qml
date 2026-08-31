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

            readonly property var _rtlAltParamValueCurrentAltitude: 0
            readonly property var _rtlLoitTimeParamValueDefault: 60
            readonly property var _planeRtlAltParamValueCurrentAltitude: -1
            readonly property var _planeRtlAltParamValueDefaultSpecified: 10000
            readonly property var _planeFenceActionRtl: 1
            readonly property var _planeFenceActionAutoLandOrRtl: 8

            property var _rtlAltIsMeters: controller.parameterExists(-1, "noremap.RTL_ALT_M")
            property var _rtlAltFact: controller.getParameterFact(-1, "RTL_ALT_M", false)
            property var _rtlLoitTimeFact: controller.getParameterFact(-1, "RTL_LOIT_TIME", false)
            property var _planeRtlAltFact: controller.getParameterFact(-1, "RTL_ALTITUDE", false)
            property var _fenceAction: controller.getParameterFact(-1, "FENCE_ACTION", false)
            property var _fenceEnable: controller.getParameterFact(-1, "FENCE_ENABLE", false)
            property var _fenceRetAlt: controller.getParameterFact(-1, "FENCE_RET_ALT", false)
            property var _fenceType: controller.getParameterFact(-1, "FENCE_TYPE", false)
            property var _armingCheck: controller.getParameterFact(-1, "ARMING_CHECK", false)
            property var _armingSkipCheck: controller.getParameterFact(-1, "ARMING_SKIPCHK", false)

            property var _fenceEnabled: _fenceEnable && _fenceEnable.rawValue !== 0
            property var _fenceActionIsRtl: _fenceAction && (_fenceAction.rawValue === _planeFenceActionRtl || _fenceAction.rawValue === _planeFenceActionAutoLandOrRtl)
            property var _rtlAltParamValueDefaultSpecified: (_rtlAltIsMeters ? 15 : 1500)

            property string sectionNameFilter: ""

            readonly property var _searchTerms: ({
                "Return to Launch": ["0 = use waypoint loiter radius (wp_loiter_rad), negative = counter-clockwise", "altitude", "auto land after rtl", "land", "launch", "loiter", "loiter radius", "return", "return altitude", "return altitude:", "return home", "return to launch", "rtl", "rtl_altitude", "rtl_autoland", "rtl_radius", "to"],
                "GeoFence": ["auto-enable", "boundary", "breach", "breach action", "circle centered on home", "circle radius", "containment", "custom return altitude", "enabled", "exclusion", "fence", "fence margin", "fence_action", "fence_alt_max", "fence_alt_min", "fence_autoenable", "fence_enable", "fence_margin", "fence_radius", "fence_ret_alt", "fence_ret_rally", "fence_type", "geofence", "inclusion", "inclusion/exclusion circles+polygons", "maximum altitude", "minimum altitude", "radius", "rally", "return altitude", "return to nearest rally point"],
                "Arming Checks": ["arming", "arming checks", "arming_check", "arming_skipchk", "checks", "pre-arm", "preflight", "safety check", "skip arming checks", "warning: skipping arming checks can lead to loss of vehicle control."]
            })

            readonly property var _translatableSearchTerms: ({
                "Return to Launch": ["0 = use Waypoint Loiter Radius (WP_LOITER_RAD), negative = counter-clockwise", "Auto land after RTL", "Loiter radius", "Return altitude", "Return altitude:", "Return to Launch", "altitude", "land", "loiter", "return home", "return to launch", "rtl"],
                "GeoFence": ["Auto-enable", "Breach action", "Circle centered on Home", "Circle radius", "Custom return altitude", "Enabled", "Fence margin", "GeoFence", "Inclusion/Exclusion Circles+Polygons", "Maximum Altitude", "Maximum altitude", "Minimum Altitude", "Minimum altitude", "Return altitude", "Return to nearest rally point", "boundary", "breach", "containment", "exclusion", "fence", "geofence", "inclusion", "radius", "rally"],
                "Arming Checks": ["Arming Checks", "Arming checks", "Skip arming checks", "Warning: Skipping arming checks can lead to loss of Vehicle control.", "arming", "pre-arm", "preflight", "safety check"]
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
                        if (qsTranslate("APMFlightSafety.VehicleConfig.json", trTerms[j]).toLowerCase().indexOf(filter) >= 0) return true
                    }
                }
                return false
            }

            function sectionVisible(name) {
                if (name === "Return to Launch") return controller.vehicle.multiRotor || controller.vehicle.fixedWing
                if (name === "GeoFence") return controller.vehicle.multiRotor || controller.vehicle.fixedWing
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
                    visible: sectionMatchesFilter("Return to Launch") && controller.vehicle.multiRotor
                    heading: qsTranslate("APMFlightSafety.VehicleConfig.json", "Return to Launch")
                    iconSource: "/qmlimages/ReturnToHomeAltitude.svg"

                    ColumnLayout {
                        visible: controller.getParameterFact(-1, "RTL_ALT_M", false) !== null
                        spacing: 0
                        QGCLabel {
                            text: qsTranslate("APMFlightSafety.VehicleConfig.json", "Return at specified altitude:")
                        }
                        ColumnLayout {
                            spacing: 0
                            QGCRadioButton {
                                text: qsTranslate("APMFlightSafety.VehicleConfig.json", "Return at current altitude")
                                checked: controller.getParameterFact(-1, "RTL_ALT_M", false) ? _rtlAltFact.value === _rtlAltParamValueCurrentAltitude : false
                                onClicked: if (controller.getParameterFact(-1, "RTL_ALT_M", false)) { controller.getParameterFact(-1, "RTL_ALT_M", false).value = _rtlAltParamValueCurrentAltitude }
                            }
                            QGCRadioButton {
                                text: qsTranslate("APMFlightSafety.VehicleConfig.json", "Return at specified altitude")
                                checked: controller.getParameterFact(-1, "RTL_ALT_M", false) ? _rtlAltFact.value !== _rtlAltParamValueCurrentAltitude : false
                                onClicked: if (controller.getParameterFact(-1, "RTL_ALT_M", false)) { controller.getParameterFact(-1, "RTL_ALT_M", false).value = _rtlAltParamValueDefaultSpecified }
                            }
                        }
                    }

                    LabelledFactTextField {
                        visible: fact !== null
                        label: qsTranslate("APMFlightSafety.VehicleConfig.json", "Return altitude")
                        Layout.fillWidth: true
                        fact: controller.getParameterFact(-1, "RTL_ALT_M", false)
                        enabled: _rtlAltFact && _rtlAltFact.value !== _rtlAltParamValueCurrentAltitude
                    }

                    QGCCheckBoxSlider {
                        visible: controller.getParameterFact(-1, "RTL_LOIT_TIME", false) !== null
                        Layout.fillWidth: true
                        text: qsTranslate("APMFlightSafety.VehicleConfig.json", "Loiter above Home")
                        checked: controller.getParameterFact(-1, "RTL_LOIT_TIME", false) ? _rtlLoitTimeFact.value > 0 : false
                        onClicked: if (controller.getParameterFact(-1, "RTL_LOIT_TIME", false)) { if (checked) { _rtlLoitTimeFact.value = _rtlLoitTimeParamValueDefault } else { _rtlLoitTimeFact.value = 0 } }
                    }

                    LabelledFactTextField {
                        visible: fact !== null
                        label: qsTranslate("APMFlightSafety.VehicleConfig.json", "Loiter time")
                        Layout.fillWidth: true
                        fact: controller.getParameterFact(-1, "RTL_LOIT_TIME", false)
                        enabled: _rtlLoitTimeFact && _rtlLoitTimeFact.value > 0
                    }

                    LabelledFactTextField {
                        visible: fact !== null
                        label: qsTranslate("APMFlightSafety.VehicleConfig.json", "Final land stage altitude")
                        Layout.fillWidth: true
                        fact: controller.getParameterFact(-1, "RTL_ALT_FINAL_M", false)
                    }

                    LabelledFactTextField {
                        visible: fact !== null
                        label: qsTranslate("APMFlightSafety.VehicleConfig.json", "Final land stage descent speed")
                        Layout.fillWidth: true
                        fact: controller.getParameterFact(-1, "LAND_SPD_MS", false)
                    }
                }

                ConfigSection {
                    Layout.fillWidth: true
                    visible: sectionMatchesFilter("Return to Launch") && controller.vehicle.fixedWing
                    heading: qsTranslate("APMFlightSafety.VehicleConfig.json", "Return to Launch")
                    iconSource: "/qmlimages/ReturnToHomeAltitude.svg"

                    ColumnLayout {
                        visible: controller.getParameterFact(-1, "RTL_ALTITUDE", false) !== null
                        spacing: 0
                        QGCLabel {
                            text: qsTranslate("APMFlightSafety.VehicleConfig.json", "Return altitude:")
                        }
                        ColumnLayout {
                            spacing: 0
                            QGCRadioButton {
                                text: qsTranslate("APMFlightSafety.VehicleConfig.json", "Return at current altitude")
                                checked: controller.getParameterFact(-1, "RTL_ALTITUDE", false) ? _planeRtlAltFact && _planeRtlAltFact.value < 0 : false
                                onClicked: if (controller.getParameterFact(-1, "RTL_ALTITUDE", false)) { controller.getParameterFact(-1, "RTL_ALTITUDE", false).value = _planeRtlAltParamValueCurrentAltitude }
                            }
                            QGCRadioButton {
                                text: qsTranslate("APMFlightSafety.VehicleConfig.json", "Return at specified altitude")
                                checked: controller.getParameterFact(-1, "RTL_ALTITUDE", false) ? _planeRtlAltFact && _planeRtlAltFact.value >= 0 : false
                                onClicked: if (controller.getParameterFact(-1, "RTL_ALTITUDE", false)) { controller.getParameterFact(-1, "RTL_ALTITUDE", false).value = _planeRtlAltParamValueDefaultSpecified }
                            }
                        }
                    }

                    LabelledFactTextField {
                        visible: fact !== null
                        label: qsTranslate("APMFlightSafety.VehicleConfig.json", "Return altitude")
                        Layout.fillWidth: true
                        fact: controller.getParameterFact(-1, "RTL_ALTITUDE", false)
                        enabled: _planeRtlAltFact && _planeRtlAltFact.value >= 0
                    }

                    LabelledFactTextField {
                        visible: fact !== null
                        label: qsTranslate("APMFlightSafety.VehicleConfig.json", "Loiter radius")
                        Layout.fillWidth: true
                        fact: controller.getParameterFact(-1, "RTL_RADIUS", false)
                    }

                    QGCLabel {
                        Layout.leftMargin: ScreenTools.defaultFontPixelWidth * 2
                        text: qsTranslate("APMFlightSafety.VehicleConfig.json", "0 = use Waypoint Loiter Radius (WP_LOITER_RAD), negative = counter-clockwise")
                        wrapMode: Text.WordWrap
                        Layout.fillWidth: true
                        Layout.preferredWidth: 0
                        font.pointSize: ScreenTools.smallFontPointSize
                    }

                    LabelledFactComboBox {
                        visible: fact !== null
                        label: qsTranslate("APMFlightSafety.VehicleConfig.json", "Auto land after RTL")
                        Layout.fillWidth: true
                        comboBoxPreferredWidth: ScreenTools.defaultFontPixelWidth * 30
                        fact: controller.getParameterFact(-1, "RTL_AUTOLAND", false)
                        indexModel: false
                    }
                }

                ConfigSection {
                    Layout.fillWidth: true
                    visible: sectionMatchesFilter("GeoFence") && controller.vehicle.multiRotor
                    heading: qsTranslate("APMFlightSafety.VehicleConfig.json", "GeoFence")

                    FactCheckBoxSlider {
                        visible: fact !== null
                        Layout.fillWidth: true
                        text: qsTranslate("APMFlightSafety.VehicleConfig.json", "Enabled")
                        fact: controller.getParameterFact(-1, "FENCE_ENABLE", false)
                    }

                    FactBitMaskCheckBoxSlider {
                        visible: fact !== null && (_fenceEnabled)
                        Layout.fillWidth: true
                        text: qsTranslate("APMFlightSafety.VehicleConfig.json", "Maximum Altitude")
                        fact: controller.getParameterFact(-1, "FENCE_TYPE", false)
                        bitMask: 1
                    }

                    LabelledFactTextField {
                        visible: fact !== null && (_fenceEnabled && _fenceType && (_fenceType.rawValue & 1))
                        label: qsTranslate("APMFlightSafety.VehicleConfig.json", "Maximum altitude")
                        Layout.fillWidth: true
                        fact: controller.getParameterFact(-1, "FENCE_ALT_MAX", false)
                    }

                    FactBitMaskCheckBoxSlider {
                        visible: fact !== null && (_fenceEnabled)
                        Layout.fillWidth: true
                        text: qsTranslate("APMFlightSafety.VehicleConfig.json", "Minimum Altitude")
                        fact: controller.getParameterFact(-1, "FENCE_TYPE", false)
                        bitMask: 8
                    }

                    LabelledFactTextField {
                        visible: fact !== null && (_fenceEnabled && _fenceType && (_fenceType.rawValue & 8))
                        label: qsTranslate("APMFlightSafety.VehicleConfig.json", "Minimum altitude")
                        Layout.fillWidth: true
                        fact: controller.getParameterFact(-1, "FENCE_ALT_MIN", false)
                    }

                    FactBitMaskCheckBoxSlider {
                        visible: fact !== null && (_fenceEnabled)
                        Layout.fillWidth: true
                        text: qsTranslate("APMFlightSafety.VehicleConfig.json", "Circle centered on Home")
                        fact: controller.getParameterFact(-1, "FENCE_TYPE", false)
                        bitMask: 2
                    }

                    LabelledFactTextField {
                        visible: fact !== null && (_fenceEnabled && _fenceType && (_fenceType.rawValue & 2))
                        label: qsTranslate("APMFlightSafety.VehicleConfig.json", "Circle radius")
                        Layout.fillWidth: true
                        fact: controller.getParameterFact(-1, "FENCE_RADIUS", false)
                    }

                    FactBitMaskCheckBoxSlider {
                        visible: fact !== null && (_fenceEnabled)
                        Layout.fillWidth: true
                        text: qsTranslate("APMFlightSafety.VehicleConfig.json", "Inclusion/Exclusion Circles+Polygons")
                        fact: controller.getParameterFact(-1, "FENCE_TYPE", false)
                        bitMask: 4
                    }

                    LabelledFactTextField {
                        visible: fact !== null && (_fenceEnabled)
                        label: qsTranslate("APMFlightSafety.VehicleConfig.json", "Fence margin")
                        Layout.fillWidth: true
                        fact: controller.getParameterFact(-1, "FENCE_MARGIN", false)
                    }

                    LabelledFactComboBox {
                        visible: fact !== null && (_fenceEnabled)
                        label: qsTranslate("APMFlightSafety.VehicleConfig.json", "Auto-enable")
                        Layout.fillWidth: true
                        comboBoxPreferredWidth: ScreenTools.defaultFontPixelWidth * 30
                        fact: controller.getParameterFact(-1, "FENCE_AUTOENABLE", false)
                        indexModel: false
                    }

                    LabelledFactComboBox {
                        visible: fact !== null && (_fenceEnabled)
                        label: qsTranslate("APMFlightSafety.VehicleConfig.json", "Breach action")
                        Layout.fillWidth: true
                        comboBoxPreferredWidth: ScreenTools.defaultFontPixelWidth * 30
                        fact: controller.getParameterFact(-1, "FENCE_ACTION", false)
                        indexModel: false
                    }
                }

                ConfigSection {
                    Layout.fillWidth: true
                    visible: sectionMatchesFilter("GeoFence") && controller.vehicle.fixedWing
                    heading: qsTranslate("APMFlightSafety.VehicleConfig.json", "GeoFence")

                    FactCheckBoxSlider {
                        visible: fact !== null
                        Layout.fillWidth: true
                        text: qsTranslate("APMFlightSafety.VehicleConfig.json", "Enabled")
                        fact: controller.getParameterFact(-1, "FENCE_ENABLE", false)
                    }

                    FactBitMaskCheckBoxSlider {
                        visible: fact !== null && (_fenceEnabled)
                        Layout.fillWidth: true
                        text: qsTranslate("APMFlightSafety.VehicleConfig.json", "Maximum Altitude")
                        fact: controller.getParameterFact(-1, "FENCE_TYPE", false)
                        bitMask: 1
                    }

                    LabelledFactTextField {
                        visible: fact !== null && (_fenceEnabled && _fenceType && (_fenceType.rawValue & 1))
                        label: qsTranslate("APMFlightSafety.VehicleConfig.json", "Maximum altitude")
                        Layout.fillWidth: true
                        fact: controller.getParameterFact(-1, "FENCE_ALT_MAX", false)
                    }

                    FactBitMaskCheckBoxSlider {
                        visible: fact !== null && (_fenceEnabled)
                        Layout.fillWidth: true
                        text: qsTranslate("APMFlightSafety.VehicleConfig.json", "Minimum Altitude")
                        fact: controller.getParameterFact(-1, "FENCE_TYPE", false)
                        bitMask: 8
                    }

                    LabelledFactTextField {
                        visible: fact !== null && (_fenceEnabled && _fenceType && (_fenceType.rawValue & 8))
                        label: qsTranslate("APMFlightSafety.VehicleConfig.json", "Minimum altitude")
                        Layout.fillWidth: true
                        fact: controller.getParameterFact(-1, "FENCE_ALT_MIN", false)
                    }

                    FactBitMaskCheckBoxSlider {
                        visible: fact !== null && (_fenceEnabled)
                        Layout.fillWidth: true
                        text: qsTranslate("APMFlightSafety.VehicleConfig.json", "Circle centered on Home")
                        fact: controller.getParameterFact(-1, "FENCE_TYPE", false)
                        bitMask: 2
                    }

                    LabelledFactTextField {
                        visible: fact !== null && (_fenceEnabled && _fenceType && (_fenceType.rawValue & 2))
                        label: qsTranslate("APMFlightSafety.VehicleConfig.json", "Circle radius")
                        Layout.fillWidth: true
                        fact: controller.getParameterFact(-1, "FENCE_RADIUS", false)
                    }

                    FactBitMaskCheckBoxSlider {
                        visible: fact !== null && (_fenceEnabled)
                        Layout.fillWidth: true
                        text: qsTranslate("APMFlightSafety.VehicleConfig.json", "Inclusion/Exclusion Circles+Polygons")
                        fact: controller.getParameterFact(-1, "FENCE_TYPE", false)
                        bitMask: 4
                    }

                    LabelledFactTextField {
                        visible: fact !== null && (_fenceEnabled)
                        label: qsTranslate("APMFlightSafety.VehicleConfig.json", "Fence margin")
                        Layout.fillWidth: true
                        fact: controller.getParameterFact(-1, "FENCE_MARGIN", false)
                    }

                    LabelledFactComboBox {
                        visible: fact !== null && (_fenceEnabled)
                        label: qsTranslate("APMFlightSafety.VehicleConfig.json", "Auto-enable")
                        Layout.fillWidth: true
                        comboBoxPreferredWidth: ScreenTools.defaultFontPixelWidth * 30
                        fact: controller.getParameterFact(-1, "FENCE_AUTOENABLE", false)
                        indexModel: false
                    }

                    LabelledFactComboBox {
                        visible: fact !== null && (_fenceEnabled)
                        label: qsTranslate("APMFlightSafety.VehicleConfig.json", "Breach action")
                        Layout.fillWidth: true
                        comboBoxPreferredWidth: ScreenTools.defaultFontPixelWidth * 30
                        fact: controller.getParameterFact(-1, "FENCE_ACTION", false)
                        indexModel: false
                    }

                    QGCCheckBoxSlider {
                        Layout.leftMargin: ScreenTools.defaultFontPixelWidth * 2
                        visible: controller.getParameterFact(-1, "FENCE_RET_ALT", false) !== null && (_fenceEnabled && _fenceActionIsRtl)
                        Layout.fillWidth: true
                        text: qsTranslate("APMFlightSafety.VehicleConfig.json", "Custom return altitude")
                        checked: controller.getParameterFact(-1, "FENCE_RET_ALT", false) ? _fenceRetAlt && _fenceRetAlt.value > 0 : false
                        onClicked: if (controller.getParameterFact(-1, "FENCE_RET_ALT", false)) { if (checked) { _fenceRetAlt.value = (_planeRtlAltFact ? _planeRtlAltFact.value : 100) } else { _fenceRetAlt.value = 0 } }
                    }

                    LabelledFactTextField {
                        Layout.leftMargin: ScreenTools.defaultFontPixelWidth * 2
                        visible: fact !== null && (_fenceEnabled && _fenceActionIsRtl && _fenceRetAlt && _fenceRetAlt.value > 0)
                        label: qsTranslate("APMFlightSafety.VehicleConfig.json", "Return altitude")
                        Layout.fillWidth: true
                        fact: controller.getParameterFact(-1, "FENCE_RET_ALT", false)
                    }

                    FactCheckBoxSlider {
                        Layout.leftMargin: ScreenTools.defaultFontPixelWidth * 2
                        visible: fact !== null && (_fenceEnabled && _fenceActionIsRtl)
                        Layout.fillWidth: true
                        text: qsTranslate("APMFlightSafety.VehicleConfig.json", "Return to nearest rally point")
                        fact: controller.getParameterFact(-1, "FENCE_RET_RALLY", false)
                    }
                }

                ConfigSection {
                    Layout.fillWidth: true
                    visible: sectionMatchesFilter("Arming Checks")
                    heading: qsTranslate("APMFlightSafety.VehicleConfig.json", "Arming Checks")

                    QGCLabel {
                        text: qsTranslate("APMFlightSafety.VehicleConfig.json", "Warning: Skipping arming checks can lead to loss of Vehicle control.")
                        wrapMode: Text.WordWrap
                        Layout.fillWidth: true
                        Layout.preferredWidth: 0
                        color: qgcPal.warningText
                    }

                    FactBitmask {
                        visible: fact !== null && (_armingCheck)
                        fact: controller.getParameterFact(-1, "ARMING_CHECK", false)
                        firstEntryIsAll: true
                        Layout.preferredWidth: 0
                        Layout.fillWidth: true
                    }

                    FactBitmask {
                        visible: fact !== null && (!_armingCheck && _armingSkipCheck)
                        fact: controller.getParameterFact(-1, "ARMING_SKIPCHK", false)
                        Layout.preferredWidth: 0
                        Layout.fillWidth: true
                    }
                }
            }
        }
    }
}
