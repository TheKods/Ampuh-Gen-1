#include "AIDetectionManager.h"
#include "AIDetectionBox.h"
#include "QmlObjectListModel.h"

AIDetectionManager* AIDetectionManager::_instance = nullptr;

AIDetectionManager::AIDetectionManager(QObject *parent)
    : QObject(parent)
    , _detectionBoxes(new QmlObjectListModel(this))
{
    _instance = this;
}

AIDetectionManager::~AIDetectionManager()
{
    if (_instance == this) {
        _instance = nullptr;
    }
}

AIDetectionManager* AIDetectionManager::instance()
{
    return _instance;
}

int AIDetectionManager::activeTargetCount() const
{
    return _detectionBoxes ? _detectionBoxes->count() : 0;
}

void AIDetectionManager::lockTarget(int targetId)
{
    if (_lockedTargetId != targetId) {
        _lockedTargetId = targetId;

        if (_detectionBoxes) {
            for (int i = 0; i < _detectionBoxes->count(); ++i) {
                auto *box = _detectionBoxes->value<AIDetectionBox*>(i);
                if (box) {
                    box->setIsLocked(box->targetId() == _lockedTargetId);
                }
            }
        }

        emit lockedTargetChanged();
    }
}

void AIDetectionManager::unlockTarget()
{
    lockTarget(-1);
}

void AIDetectionManager::clearDetections()
{
    if (_detectionBoxes) {
        _detectionBoxes->clear();
        _averageConfidence = 0.0;
        emit activeTargetCountChanged();
        emit statisticsUpdated();
    }
}

void AIDetectionManager::updateDetections(const QList<AIDetectionRawData> &rawList, double confidenceThreshold)
{
    if (!_detectionBoxes) return;

    QList<AIDetectionRawData> filtered;
    double totalConf = 0.0;

    for (const auto &raw : rawList) {
        if (raw.confidence >= confidenceThreshold) {
            filtered.append(raw);
            totalConf += raw.confidence;
        }
    }

    const int newCount = filtered.size();
    const int oldCount = _detectionBoxes->count();

    for (int i = 0; i < newCount; ++i) {
        const auto &raw = filtered[i];
        if (i < oldCount) {
            auto *existing = _detectionBoxes->value<AIDetectionBox*>(i);
            if (existing) {
                existing->updateData(raw.className, raw.confidence, raw.x, raw.y, raw.width, raw.height, raw.trackingStatus);
                existing->setIsLocked(raw.targetId == _lockedTargetId);
            }
        } else {
            auto *newBox = new AIDetectionBox(raw.targetId, raw.className, raw.confidence,
                                              raw.x, raw.y, raw.width, raw.height,
                                              raw.trackingStatus, this);
            newBox->setIsLocked(raw.targetId == _lockedTargetId);
            _detectionBoxes->append(newBox);
        }
    }

    while (_detectionBoxes->count() > newCount) {
        QObject *removed = _detectionBoxes->removeAt(_detectionBoxes->count() - 1);
        if (removed) {
            removed->deleteLater();
        }
    }

    _averageConfidence = newCount > 0 ? (totalConf / static_cast<double>(newCount)) : 0.0;

    emit activeTargetCountChanged();
    emit statisticsUpdated();
}
