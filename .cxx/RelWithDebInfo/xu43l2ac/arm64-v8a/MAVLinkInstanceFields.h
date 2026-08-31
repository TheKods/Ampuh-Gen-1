#pragma once

/// @file MAVLinkInstanceFields.h
/// @brief Maps MAVLink message IDs to their instance field names.
///
/// AUTO-GENERATED from MAVLink XML definitions during the build.
/// Do not edit manually. Regenerate via tools/generators/mavlink_instance_fields.py.

#include <QtCore/QMap>
#include <QtCore/QString>

/// Returns the instance field name for a given message ID, or empty QString if none.
inline const QMap<quint32, QString> &mavlinkInstanceFields()
{
    static const QMap<quint32, QString> fields = {
        {27, QStringLiteral("id")},  // RAW_IMU
        {36, QStringLiteral("port")},  // SERVO_OUTPUT_RAW
        {105, QStringLiteral("id")},  // HIGHRES_IMU
        {106, QStringLiteral("sensor_id")},  // OPTICAL_FLOW_RAD
        {132, QStringLiteral("id")},  // DISTANCE_SENSOR
        {147, QStringLiteral("id")},  // BATTERY_STATUS
        {191, QStringLiteral("compass_id")},  // MAG_CAL_PROGRESS
        {192, QStringLiteral("compass_id")},  // MAG_CAL_REPORT
        {194, QStringLiteral("axis")},  // PID_TUNING
        {232, QStringLiteral("gps_id")},  // GPS_INPUT
        {250, QStringLiteral("name")},  // DEBUG_VECT
        {251, QStringLiteral("name")},  // NAMED_VALUE_FLOAT
        {252, QStringLiteral("name")},  // NAMED_VALUE_INT
        {261, QStringLiteral("storage_id")},  // STORAGE_INFORMATION
        {269, QStringLiteral("stream_id")},  // VIDEO_STREAM_INFORMATION
        {270, QStringLiteral("stream_id")},  // VIDEO_STREAM_STATUS
        {277, QStringLiteral("stream_id")},  // CAMERA_THERMAL_RANGE
        {280, QStringLiteral("gimbal_device_id")},  // GIMBAL_MANAGER_INFORMATION
        {281, QStringLiteral("gimbal_device_id")},  // GIMBAL_MANAGER_STATUS
        {282, QStringLiteral("gimbal_device_id")},  // GIMBAL_MANAGER_SET_ATTITUDE
        {287, QStringLiteral("gimbal_device_id")},  // GIMBAL_MANAGER_SET_PITCHYAW
        {288, QStringLiteral("gimbal_device_id")},  // GIMBAL_MANAGER_SET_MANUAL_CONTROL
        {290, QStringLiteral("index")},  // ESC_INFO
        {291, QStringLiteral("index")},  // ESC_STATUS
        {295, QStringLiteral("id")},  // AIRSPEED
        {296, QStringLiteral("id")},  // GLOBAL_POSITION_SENSOR
        {334, QStringLiteral("id")},  // CELLULAR_STATUS
        {350, QStringLiteral("array_id")},  // DEBUG_FLOAT_ARRAY
        {369, QStringLiteral("id")},  // BATTERY_STATUS_V2
        {370, QStringLiteral("id")},  // SMART_BATTERY_INFO
        {371, QStringLiteral("id")},  // FUEL_STATUS
        {372, QStringLiteral("id")},  // BATTERY_INFO
        {441, QStringLiteral("id")},  // GNSS_INTEGRITY
        {511, QStringLiteral("id")},  // TARGET_RELATIVE
        {513, QStringLiteral("beacon_id")},  // RANGING_BEACON
        {10151, QStringLiteral("efi_index")},  // LOWEHEISER_GOV_EFI
        {11010, QStringLiteral("axis")},  // ADAP_TUNING
        {11037, QStringLiteral("obstacle_id")},  // OBSTACLE_DISTANCE_3D
        {11038, QStringLiteral("id")},  // WATER_DEPTH
        {11039, QStringLiteral("id")},  // MCU_STATUS
        {11060, QStringLiteral("name")},  // NAMED_VALUE_STRING
        {12920, QStringLiteral("id")},  // HYGROMETER_SENSOR
        {52505, QStringLiteral("sensor_id")},  // EYE_TRACKING_DATA
        {60010, QStringLiteral("gimbal_id")},  // STORM32_GIMBAL_MANAGER_INFORMATION
        {60011, QStringLiteral("gimbal_id")},  // STORM32_GIMBAL_MANAGER_STATUS
        {60012, QStringLiteral("gimbal_id")},  // STORM32_GIMBAL_MANAGER_CONTROL
        {60013, QStringLiteral("gimbal_id")},  // STORM32_GIMBAL_MANAGER_CONTROL_PITCHYAW
        {60014, QStringLiteral("gimbal_id")},  // STORM32_GIMBAL_MANAGER_CORRECT_ROLL
    };
    return fields;
}
