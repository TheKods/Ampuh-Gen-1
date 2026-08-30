#pragma once

#include <QtCore/QtGlobal>
#include <QtCore/QLoggingCategory>

#if QT_VERSION < QT_VERSION_CHECK(6, 8, 0)
#ifndef Q_APPLICATION_STATIC
#define Q_APPLICATION_STATIC(type, name, ...) Q_GLOBAL_STATIC_WITH_ARGS(type, name, (__VA_ARGS__))
#endif
#endif

class QString;

#define QGC_LOGGING_CATEGORY(name, categoryStr)               \
    static QGCLoggingCategory qgcCategory##name(categoryStr); \
    Q_LOGGING_CATEGORY(name, categoryStr, QtWarningMsg)

#define QGC_LOGGING_CATEGORY_ON(name, categoryStr)            \
    static QGCLoggingCategory qgcCategory##name(categoryStr); \
    Q_LOGGING_CATEGORY(name, categoryStr, QtInfoMsg)

/// \brief Helper that defers category registration until the QGCLoggingCategoryManager
/// singleton exists. Pre-manager registrations are buffered and replayed on init().

class QGCLoggingCategory
{
public:
    explicit QGCLoggingCategory(const QString& category);
};
