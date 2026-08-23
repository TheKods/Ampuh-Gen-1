#pragma once

#include <QtCore/QObject>
#include <QtCore/QString>
#include <QtPositioning/QGeoCoordinate>
#include <QtQmlIntegration/QtQmlIntegration>

class AIDetectionBox : public QObject
{
    Q_OBJECT
    QML_ELEMENT

    Q_PROPERTY(int targetId READ targetId CONSTANT)
    Q_PROPERTY(QString className READ className NOTIFY classNameChanged)
    Q_PROPERTY(double confidence READ confidence NOTIFY confidenceChanged)
    Q_PROPERTY(double x READ x NOTIFY geometryChanged)
    Q_PROPERTY(double y READ y NOTIFY geometryChanged)
    Q_PROPERTY(double width READ width NOTIFY geometryChanged)
    Q_PROPERTY(double height READ height NOTIFY geometryChanged)
    Q_PROPERTY(bool isLocked READ isLocked WRITE setIsLocked NOTIFY isLockedChanged)
    Q_PROPERTY(QString trackingStatus READ trackingStatus NOTIFY trackingStatusChanged)
    Q_PROPERTY(QGeoCoordinate coordinate READ coordinate NOTIFY coordinateChanged)
    Q_PROPERTY(double rangeMeters READ rangeMeters NOTIFY rangeMetersChanged)
    Q_PROPERTY(double estimatedSpeedKmh READ estimatedSpeedKmh NOTIFY estimatedSpeedKmhChanged)
    Q_PROPERTY(QString boxColorHex READ boxColorHex NOTIFY boxColorChanged)

public:
    explicit AIDetectionBox(QObject *parent = nullptr);
    AIDetectionBox(int targetId, const QString &className, double confidence,
                   double x, double y, double width, double height,
                   const QString &trackingStatus = QStringLiteral("TRACKING"),
                   QObject *parent = nullptr);
    ~AIDetectionBox() override = default;

    [[nodiscard]] int targetId() const { return _targetId; }
    [[nodiscard]] QString className() const { return _className; }
    [[nodiscard]] double confidence() const { return _confidence; }
    [[nodiscard]] double x() const { return _x; }
    [[nodiscard]] double y() const { return _y; }
    [[nodiscard]] double width() const { return _width; }
    [[nodiscard]] double height() const { return _height; }
    [[nodiscard]] bool isLocked() const { return _isLocked; }
    [[nodiscard]] QString trackingStatus() const { return _trackingStatus; }
    [[nodiscard]] QGeoCoordinate coordinate() const { return _coordinate; }
    [[nodiscard]] double rangeMeters() const { return _rangeMeters; }
    [[nodiscard]] double estimatedSpeedKmh() const { return _estimatedSpeedKmh; }
    [[nodiscard]] QString boxColorHex() const;

    void updateData(const QString &className, double confidence,
                    double x, double y, double width, double height,
                    const QString &trackingStatus);
    void setIsLocked(bool locked);
    void setCoordinate(const QGeoCoordinate &coord);
    void setRangeMeters(double range);
    void setEstimatedSpeedKmh(double speed);

signals:
    void classNameChanged();
    void confidenceChanged();
    void geometryChanged();
    void isLockedChanged();
    void trackingStatusChanged();
    void coordinateChanged();
    void rangeMetersChanged();
    void estimatedSpeedKmhChanged();
    void boxColorChanged();

private:
    int _targetId = -1;
    QString _className;
    double _confidence = 0.0;
    double _x = 0.0;
    double _y = 0.0;
    double _width = 0.0;
    double _height = 0.0;
    bool _isLocked = false;
    QString _trackingStatus = QStringLiteral("TRACKING");
    QGeoCoordinate _coordinate;
    double _rangeMeters = 0.0;
    double _estimatedSpeedKmh = 0.0;
};
