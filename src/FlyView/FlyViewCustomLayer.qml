import QtQuick
import QtQuick.Controls
import QtQuick.Dialogs
import QtQuick.Layouts

import QtLocation
import QtPositioning
import QtQuick.Window
import QtQml.Models

import QGroundControl
import QGroundControl.Controls
import QGroundControl.FlyView
import QGroundControl.FlightMap

import "./AI_HUD"

Item {
    id: _root

    property var parentToolInsets               // These insets tell you what screen real estate is available for positioning the controls in your overlay
    property var totalToolInsets:   _toolInsets // These are the insets for your custom overlay additions
    property var mapControl

    HUDMasterContainer {
        id:                 hudMaster
        anchors.fill:       parent
        parentToolInsets:   _root.parentToolInsets
        mapControl:         _root.mapControl
    }

    QGCToolInsets {
        id:                     _toolInsets
        leftEdgeTopInset:       hudMaster.totalToolInsets.leftEdgeTopInset
        leftEdgeCenterInset:    hudMaster.totalToolInsets.leftEdgeCenterInset
        leftEdgeBottomInset:    hudMaster.totalToolInsets.leftEdgeBottomInset
        rightEdgeTopInset:      hudMaster.totalToolInsets.rightEdgeTopInset
        rightEdgeCenterInset:   hudMaster.totalToolInsets.rightEdgeCenterInset
        rightEdgeBottomInset:   hudMaster.totalToolInsets.rightEdgeBottomInset
        topEdgeLeftInset:       hudMaster.totalToolInsets.topEdgeLeftInset
        topEdgeCenterInset:     hudMaster.totalToolInsets.topEdgeCenterInset
        topEdgeRightInset:      hudMaster.totalToolInsets.topEdgeRightInset
        bottomEdgeLeftInset:    hudMaster.totalToolInsets.bottomEdgeLeftInset
        bottomEdgeCenterInset:  hudMaster.totalToolInsets.bottomEdgeCenterInset
        bottomEdgeRightInset:   hudMaster.totalToolInsets.bottomEdgeRightInset
    }
}
