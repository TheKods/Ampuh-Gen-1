import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import QGroundControl
import QGroundControl.FactControls
import QGroundControl.Controls

SettingsPage {
    objectName: "settingsPage_Video"
    property real _stringFieldWidth: ScreenTools.defaultFontPixelWidth * 30
    property var videoSource: QGroundControl.settingsManager.videoSettings.videoSource.rawValue
    property var autoStreamConfig: QGroundControl.videoManager.autoStreamConfigured
    property bool sourceDisabled: videoSource === QGroundControl.settingsManager.videoSettings.disabledVideoSource
    property var isStreamSource: QGroundControl.videoManager.isStreamSource
    property var rtpLatencyVisible: !QGroundControl.settingsManager.videoSettings.lowLatencyMode.rawValue

    function sectionVisible(index) {
        switch (index) {
        case 0: return (QGroundControl.settingsManager.videoSettings.videoSource.userVisible)
        case 1: return (!sourceDisabled && !autoStreamConfig) && (QGroundControl.settingsManager.videoSettings.rtspUrl.userVisible || QGroundControl.settingsManager.videoSettings.tcpUrl.userVisible || QGroundControl.settingsManager.videoSettings.udpUrl.userVisible)
        case 2: return (!sourceDisabled) && (QGroundControl.settingsManager.videoSettings.aspectRatio.userVisible || QGroundControl.settingsManager.videoSettings.disableWhenDisarmed.userVisible || QGroundControl.settingsManager.videoSettings.lowLatencyMode.userVisible || QGroundControl.settingsManager.videoSettings.rtpJitterLatencyMs.userVisible || QGroundControl.settingsManager.videoSettings.rtspAutoReconnect.userVisible || QGroundControl.settingsManager.videoSettings.forceCpuVideoPath.userVisible || QGroundControl.settingsManager.videoSettings.forceVideoDecoder.userVisible)
        case 3: return (QGroundControl.settingsManager.videoSettings.recordingFormat.userVisible || QGroundControl.settingsManager.videoSettings.enableStorageLimit.userVisible || QGroundControl.settingsManager.videoSettings.maxVideoSize.userVisible)
        default: return true
        }
    }

    SettingsGroupLayout {
        objectName: "settingsGroup_VideoSource"
        Layout.fillWidth: true
        heading: qsTranslate("Video.SettingsUI.json", "Video Source")
        headingDescription: autoStreamConfig ? qsTr("Mavlink camera stream is automatically configured") : ""
        visible: (sectionFilter === -1 || sectionFilter === 0) && (QGroundControl.settingsManager.videoSettings.videoSource.userVisible)
        enabled: !autoStreamConfig

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.videoSettings.videoSource.userVisible

            LabelledFactComboBox {
                label: fact.label
                Layout.fillWidth: true
                fact: QGroundControl.settingsManager.videoSettings.videoSource
                indexModel: false
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.videoSettings.videoSource.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }
    }

    SettingsGroupLayout {
        objectName: "settingsGroup_Connection"
        Layout.fillWidth: true
        heading: qsTranslate("Video.SettingsUI.json", "Connection")
        visible: (sectionFilter === -1 || sectionFilter === 1) && (!sourceDisabled && !autoStreamConfig) && (QGroundControl.settingsManager.videoSettings.rtspUrl.userVisible || QGroundControl.settingsManager.videoSettings.tcpUrl.userVisible || QGroundControl.settingsManager.videoSettings.udpUrl.userVisible)

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: (videoSource === QGroundControl.settingsManager.videoSettings.rtspVideoSource) && QGroundControl.settingsManager.videoSettings.rtspUrl.userVisible

            LabelledFactTextField {
                label: fact.label
                Layout.fillWidth: true
                fact: QGroundControl.settingsManager.videoSettings.rtspUrl
                objectName: "settingsTextField_rtspUrl"
                textFieldPreferredWidth: _stringFieldWidth
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.videoSettings.rtspUrl.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: (videoSource === QGroundControl.settingsManager.videoSettings.tcpVideoSource) && QGroundControl.settingsManager.videoSettings.tcpUrl.userVisible

            LabelledFactTextField {
                label: fact.label
                Layout.fillWidth: true
                fact: QGroundControl.settingsManager.videoSettings.tcpUrl
                objectName: "settingsTextField_tcpUrl"
                textFieldPreferredWidth: _stringFieldWidth
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.videoSettings.tcpUrl.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: (videoSource === QGroundControl.settingsManager.videoSettings.udp264VideoSource || videoSource === QGroundControl.settingsManager.videoSettings.udp265VideoSource || videoSource === QGroundControl.settingsManager.videoSettings.mpegtsVideoSource) && QGroundControl.settingsManager.videoSettings.udpUrl.userVisible

            LabelledFactTextField {
                label: fact.label
                Layout.fillWidth: true
                fact: QGroundControl.settingsManager.videoSettings.udpUrl
                objectName: "settingsTextField_udpUrl"
                textFieldPreferredWidth: _stringFieldWidth
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.videoSettings.udpUrl.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }
    }

    SettingsGroupLayout {
        objectName: "settingsGroup_Settings"
        Layout.fillWidth: true
        heading: qsTranslate("Video.SettingsUI.json", "Settings")
        visible: (sectionFilter === -1 || sectionFilter === 2) && (!sourceDisabled) && (QGroundControl.settingsManager.videoSettings.aspectRatio.userVisible || QGroundControl.settingsManager.videoSettings.disableWhenDisarmed.userVisible || QGroundControl.settingsManager.videoSettings.lowLatencyMode.userVisible || QGroundControl.settingsManager.videoSettings.rtpJitterLatencyMs.userVisible || QGroundControl.settingsManager.videoSettings.rtspAutoReconnect.userVisible || QGroundControl.settingsManager.videoSettings.forceCpuVideoPath.userVisible || QGroundControl.settingsManager.videoSettings.forceVideoDecoder.userVisible)

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: (!autoStreamConfig && isStreamSource) && QGroundControl.settingsManager.videoSettings.aspectRatio.userVisible

            LabelledFactTextField {
                label: fact.label
                Layout.fillWidth: true
                fact: QGroundControl.settingsManager.videoSettings.aspectRatio
                objectName: "settingsTextField_aspectRatio"
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.videoSettings.aspectRatio.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: (!autoStreamConfig && isStreamSource) && QGroundControl.settingsManager.videoSettings.disableWhenDisarmed.userVisible

            FactCheckBoxSlider {
                objectName: "settingsCheckBox_disableWhenDisarmed"
                Layout.fillWidth: true
                text: fact.label
                fact: QGroundControl.settingsManager.videoSettings.disableWhenDisarmed
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.videoSettings.disableWhenDisarmed.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: (!autoStreamConfig && isStreamSource && QGroundControl.settingsManager.videoSettings.lowLatencyMode.userVisible) && QGroundControl.settingsManager.videoSettings.lowLatencyMode.userVisible

            FactCheckBoxSlider {
                objectName: "settingsCheckBox_lowLatencyMode"
                Layout.fillWidth: true
                text: fact.label
                fact: QGroundControl.settingsManager.videoSettings.lowLatencyMode
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.videoSettings.lowLatencyMode.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: (!autoStreamConfig && isStreamSource && rtpLatencyVisible && QGroundControl.settingsManager.videoSettings.rtpJitterLatencyMs.userVisible) && QGroundControl.settingsManager.videoSettings.rtpJitterLatencyMs.userVisible

            LabelledFactTextField {
                label: fact.label
                Layout.fillWidth: true
                fact: QGroundControl.settingsManager.videoSettings.rtpJitterLatencyMs
                objectName: "settingsTextField_rtpJitterLatencyMs"
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.videoSettings.rtpJitterLatencyMs.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: (!autoStreamConfig && isStreamSource) && QGroundControl.settingsManager.videoSettings.rtspAutoReconnect.userVisible

            FactCheckBoxSlider {
                objectName: "settingsCheckBox_rtspAutoReconnect"
                Layout.fillWidth: true
                text: fact.label
                fact: QGroundControl.settingsManager.videoSettings.rtspAutoReconnect
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.videoSettings.rtspAutoReconnect.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: (QGroundControl.settingsManager.videoSettings.forceCpuVideoPath.userVisible) && QGroundControl.settingsManager.videoSettings.forceCpuVideoPath.userVisible

            FactCheckBoxSlider {
                objectName: "settingsCheckBox_forceCpuVideoPath"
                Layout.fillWidth: true
                text: fact.label
                fact: QGroundControl.settingsManager.videoSettings.forceCpuVideoPath
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.videoSettings.forceCpuVideoPath.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.videoSettings.forceVideoDecoder.userVisible

            LabelledFactComboBox {
                label: fact.label
                Layout.fillWidth: true
                fact: QGroundControl.settingsManager.videoSettings.forceVideoDecoder
                indexModel: false
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.videoSettings.forceVideoDecoder.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }
    }

    SettingsGroupLayout {
        objectName: "settingsGroup_LocalVideoStorage"
        Layout.fillWidth: true
        heading: qsTranslate("Video.SettingsUI.json", "Local Video Storage")
        visible: (sectionFilter === -1 || sectionFilter === 3) && (QGroundControl.settingsManager.videoSettings.recordingFormat.userVisible || QGroundControl.settingsManager.videoSettings.enableStorageLimit.userVisible || QGroundControl.settingsManager.videoSettings.maxVideoSize.userVisible)

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.videoSettings.recordingFormat.userVisible

            LabelledFactComboBox {
                label: fact.label
                Layout.fillWidth: true
                fact: QGroundControl.settingsManager.videoSettings.recordingFormat
                indexModel: false
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.videoSettings.recordingFormat.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.videoSettings.enableStorageLimit.userVisible

            FactCheckBoxSlider {
                objectName: "settingsCheckBox_enableStorageLimit"
                Layout.fillWidth: true
                text: fact.label
                fact: QGroundControl.settingsManager.videoSettings.enableStorageLimit
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.videoSettings.enableStorageLimit.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: ScreenTools.defaultFontPixelHeight / 4
            visible: QGroundControl.settingsManager.videoSettings.maxVideoSize.userVisible

            LabelledFactTextField {
                label: fact.label
                Layout.fillWidth: true
                fact: QGroundControl.settingsManager.videoSettings.maxVideoSize
                enabled: QGroundControl.settingsManager.videoSettings.enableStorageLimit.rawValue
                objectName: "settingsTextField_maxVideoSize"
            }

            QGCLabel {
                Layout.fillWidth: true
                text: QGroundControl.settingsManager.videoSettings.maxVideoSize.shortDescription
                visible: text !== ""
                font.pointSize: ScreenTools.smallFontPointSize
                wrapMode: Text.WordWrap
            }
        }
    }
}
