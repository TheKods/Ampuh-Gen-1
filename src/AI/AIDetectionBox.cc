#include "AIDetectionBox.h"

AIDetectionBox::AIDetectionBox(QObject *parent)
    : QObject(parent)
{
}

AIDetectionBox::AIDetectionBox(int targetId, const QString &className, double confidence,
                               double x, double y, double width, double height,
                               const QString &trackingStatus, QObject *parent)
    : QObject(parent)
    , _targetId(targetId)
    , _className(className)
    , _confidence(confidence)
    , _x(x)
    , _y(y)
    , _width(width)
    , _height(height)
    , _trackingStatus(trackingStatus)
{
}

QString AIDetectionBox::boxColorHex() const
{
    if (_isLocked) {
        return QStringLiteral("#FF3B30"); // Tactical Red
    }

    const QString lower = _className.toLower();
    if (lower.contains(QStringLiteral("person")) || lower.contains(QStringLiteral("human")) || lower.contains(QStringLiteral("sar"))) {
        return QStringLiteral("#00FF66"); // Neon Emerald
    }
    if (lower.contains(QStringLiteral("boat")) || lower.contains(QStringLiteral("ship")) || lower.contains(QStringLiteral("vessel"))) {
        return QStringLiteral("#FFD600"); // Gold Amber
    }
    if (lower.contains(QStringLiteral("plane")) || lower.contains(QStringLiteral("drone")) || lower.contains(QStringLiteral("aircraft"))) {
        return QStringLiteral("#E040FB"); // Neon Magenta
    }

    return QStringLiteral("#00E5FF"); // Neon Cyan for Vehicles/Default
}

void AIDetectionBox::updateData(const QString &className, double confidence,
                                double x, double y, double width, double height,
                                const QString &trackingStatus)
{
    if (_className != className) {
        _className = className;
        emit classNameChanged();
        emit boxColorChanged();
    }
    if (!qFuzzyCompare(_confidence, confidence)) {
        _confidence = confidence;
        emit confidenceChanged();
    }
    if (!qFuzzyCompare(_x, x) || !qFuzzyCompare(_y, y) ||
        !qFuzzyCompare(_width, width) || !qFuzzyCompare(_height, height)) {
        _x = x;
        _y = y;
        _width = width;
        _height = height;
        emit geometryChanged();
    }
    if (_trackingStatus != trackingStatus) {
        _trackingStatus = trackingStatus;
        emit trackingStatusChanged();
    }
}

void AIDetectionBox::setIsLocked(bool locked)
{
    if (_isLocked != locked) {
        _isLocked = locked;
        emit isLockedChanged();
        emit boxColorChanged();
    }
}

void AIDetectionBox::setCoordinate(const QGeoCoordinate &coord)
{
    if (_coordinate != coord) {
        _coordinate = coord;
        emit coordinateChanged();
    }
}

void AIDetectionBox::setRangeMeters(double range)
{
    if (!qFuzzyCompare(_rangeMeters, range)) {
        _rangeMeters = range;
        emit rangeMetersChanged();
    }
}

void AIDetectionBox::setEstimatedSpeedKmh(double speed)
{
    if (!qFuzzyCompare(_estimatedSpeedKmh, speed)) {
        _estimatedSpeedKmh = speed;
        emit estimatedSpeedKmhChanged();
    }
}
