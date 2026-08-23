#pragma once

#include <QtCore/QObject>
#include <QtCore/QList>
#include <QtQmlIntegration/QtQmlIntegration>

#include "AIStatsData.h"

class QmlObjectListModel;
class AIDetectionBox;

class AIDetectionManager : public QObject
{
    Q_OBJECT
    QML_NAMED_ELEMENT(QGCAIDetectionManager)
    QML_SINGLETON
    Q_MOC_INCLUDE("QmlObjectListModel.h")

    Q_PROPERTY(QmlObjectListModel* detectionBoxes READ detectionBoxes CONSTANT)
    Q_PROPERTY(int activeTargetCount READ activeTargetCount NOTIFY activeTargetCountChanged)
    Q_PROPERTY(double averageConfidence READ averageConfidence NOTIFY statisticsUpdated)
    Q_PROPERTY(bool hasLockedTarget READ hasLockedTarget NOTIFY lockedTargetChanged)
    Q_PROPERTY(int lockedTargetId READ lockedTargetId NOTIFY lockedTargetChanged)

public:
    explicit AIDetectionManager(QObject *parent = nullptr);
    ~AIDetectionManager() override;

    static AIDetectionManager* instance();

    [[nodiscard]] QmlObjectListModel* detectionBoxes() const { return _detectionBoxes; }
    [[nodiscard]] int activeTargetCount() const;
    [[nodiscard]] double averageConfidence() const { return _averageConfidence; }
    [[nodiscard]] bool hasLockedTarget() const { return _lockedTargetId >= 0; }
    [[nodiscard]] int lockedTargetId() const { return _lockedTargetId; }

    Q_INVOKABLE void lockTarget(int targetId);
    Q_INVOKABLE void unlockTarget();
    Q_INVOKABLE void clearDetections();

    void updateDetections(const QList<AIDetectionRawData> &rawList, double confidenceThreshold);

signals:
    void activeTargetCountChanged();
    void statisticsUpdated();
    void lockedTargetChanged();

private:
    static AIDetectionManager *_instance;
    QmlObjectListModel *_detectionBoxes = nullptr;
    int _lockedTargetId = -1;
    double _averageConfidence = 0.0;
};
