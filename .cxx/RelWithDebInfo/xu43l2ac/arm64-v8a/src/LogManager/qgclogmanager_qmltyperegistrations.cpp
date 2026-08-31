/****************************************************************************
** Generated QML type registration code
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include <QtQml/qqml.h>
#include <QtQml/qqmlmoduleregistration.h>

#include <LogEntry.h>
#include <LogEntryTableModel.h>
#include <LogManager.h>
#include <LogModel.h>


#if !defined(QT_STATIC)
#define Q_QMLTYPE_EXPORT Q_DECL_EXPORT
#else
#define Q_QMLTYPE_EXPORT
#endif
Q_QMLTYPE_EXPORT void qml_register_types_QGroundControl_LogManager()
{
    qmlRegisterTypesAndRevisions<LogEntry>("QGroundControl.LogManager", 1);
    QMetaType::fromType<LogEntry>().id();
    qmlRegisterNamespaceAndRevisions(&LogEntry::staticMetaObject, "QGroundControl.LogManager", 1, nullptr, &LogEntryForeign::staticMetaObject, nullptr);
    qmlRegisterTypesAndRevisions<LogEntryTableModel>("QGroundControl.LogManager", 1);
    qmlRegisterAnonymousType<QAbstractItemModel, 254>("QGroundControl.LogManager", 1);
    qmlRegisterTypesAndRevisions<LogManager>("QGroundControl.LogManager", 1);
    qmlRegisterTypesAndRevisions<LogModel>("QGroundControl.LogManager", 1);
    QMetaType::fromType<QAbstractTableModel *>().id();
    qmlRegisterModule("QGroundControl.LogManager", 1, 0);
}

static const QQmlModuleRegistration qGroundControlLogManagerRegistration("QGroundControl.LogManager", qml_register_types_QGroundControl_LogManager);
