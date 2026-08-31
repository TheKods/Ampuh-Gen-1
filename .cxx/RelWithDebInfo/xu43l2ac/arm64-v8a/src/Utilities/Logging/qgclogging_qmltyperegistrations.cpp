/****************************************************************************
** Generated QML type registration code
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include <QtQml/qqml.h>
#include <QtQml/qqmlmoduleregistration.h>

#include <LoggingCategoryModel.h>
#include <QGCLoggingCategoryManager.h>


#if !defined(QT_STATIC)
#define Q_QMLTYPE_EXPORT Q_DECL_EXPORT
#else
#define Q_QMLTYPE_EXPORT
#endif
Q_QMLTYPE_EXPORT void qml_register_types_QGroundControl_Logging()
{
    qmlRegisterTypesAndRevisions<LoggingCategoryFlatModel>("QGroundControl.Logging", 1);
    qmlRegisterTypesAndRevisions<LoggingCategoryTreeModel>("QGroundControl.Logging", 1);
    QMetaType::fromType<QAbstractItemModel *>().id();
    QMetaType::fromType<QAbstractListModel *>().id();
    qmlRegisterTypesAndRevisions<QGCLoggingCategoryManager>("QGroundControl.Logging", 1);
    qmlRegisterModule("QGroundControl.Logging", 1, 0);
}

static const QQmlModuleRegistration qGroundControlLoggingRegistration("QGroundControl.Logging", qml_register_types_QGroundControl_Logging);
