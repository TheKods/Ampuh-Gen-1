#include "AIDetectionBox.h"

#include <QtCore/QtMath>
#include <algorithm>

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
    , _prevCenterX(x + width / 2.0)
    , _prevCenterY(y + height / 2.0)
{
    calculateThreatScore();
}

QString AIDetectionBox::threatLevel() const
{
    if (_threatScore >= 80) return QStringLiteral("CRITICAL");
    if (_threatScore >= 50) return QStringLiteral("HIGH");
    return QStringLiteral("MONITOR");
}

QString AIDetectionBox::boxColorHex() const
{
    if (_isGhost) {
        return QStringLiteral("#AAAAAA"); // Ghost Dotted Grey
    }

    if (_isLocked) {
        return QStringLiteral("#FF3B30"); // Tactical Red
    }

    if (_threatScore >= 80) {
        return QStringLiteral("#FF0055"); // Critical Threat Hot Pink/Red
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
    _isGhost = false;
    _ghostFrames = 0;

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

        const double curCenterX = x + (width / 2.0);
        const double curCenterY = y + (height / 2.0);
        _velX = curCenterX - _prevCenterX;
        _velY = curCenterY - _prevCenterY;

        if (std::hypot(_velX, _velY) > 0.003) {
            const double angle = qRadiansToDegrees(std::atan2(_velY, _velX));
            setHeadingDeg(angle >= 0 ? angle : angle + 360.0);
            _prevCenterX = curCenterX;
            _prevCenterY = curCenterY;
        }

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

    calculateThreatScore();
}

void AIDetectionBox::setIsLocked(bool locked)
{
    if (_isLocked != locked) {
        _isLocked = locked;
        emit isLockedChanged();
        emit boxColorChanged();
        calculateThreatScore();
    }
}

void AIDetectionBox::setIsGhost(bool ghost)
{
    if (_isGhost != ghost) {
        _isGhost = ghost;
        emit isGhostChanged();
        emit boxColorChanged();
    }
}

void AIDetectionBox::extrapolateGhostPosition()
{
    _ghostFrames++;
    if (_ghostFrames > 90) return; // Expire after ~3 seconds

    setIsGhost(true);
    _x = std::clamp(_x + _velX, 0.02, 0.95 - _width);
    _y = std::clamp(_y + _velY, 0.02, 0.95 - _height);
    emit geometryChanged();
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
        calculateThreatScore();
    }
}

void AIDetectionBox::setEstimatedSpeedKmh(double speed)
{
    if (!qFuzzyCompare(_estimatedSpeedKmh, speed)) {
        _estimatedSpeedKmh = speed;
        emit estimatedSpeedKmhChanged();
        calculateThreatScore();
    }
}

void AIDetectionBox::setHeadingDeg(double heading)
{
    if (!qFuzzyCompare(_headingDeg, heading)) {
        _headingDeg = heading;
        emit headingDegChanged();
    }
}

void AIDetectionBox::calculateThreatScore()
{
    // Speed factor: 0-40 pts (up to 80 km/h)
    const double speedScore = std::min(_estimatedSpeedKmh / 80.0 * 40.0, 40.0);

    // Range factor: 0-40 pts (closer than 250m increases score)
    const double rangeScore = std::max((250.0 - std::min(_rangeMeters, 250.0)) / 250.0 * 40.0, 0.0);

    // Lock factor: 20 pts
    const double lockScore = _isLocked ? 20.0 : 0.0;

    const int newScore = std::clamp(static_cast<int>(speedScore + rangeScore + lockScore), 10, 99);
    if (_threatScore != newScore) {
        _threatScore = newScore;
        emit threatScoreChanged();
        emit boxColorChanged();
    }
}
