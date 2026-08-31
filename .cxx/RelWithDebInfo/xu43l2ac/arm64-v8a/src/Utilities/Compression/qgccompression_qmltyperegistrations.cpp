/****************************************************************************
** Generated QML type registration code
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include <QtQml/qqml.h>
#include <QtQml/qqmlmoduleregistration.h>

#include <QGCArchiveModel.h>


#if !defined(QT_STATIC)
#define Q_QMLTYPE_EXPORT Q_DECL_EXPORT
#else
#define Q_QMLTYPE_EXPORT
#endif
Q_QMLTYPE_EXPORT void qml_register_types_QGroundControl_Compression()
{
    QMetaType::fromType<QAbstractItemModel *>().id();
    QMetaType::fromType<QAbstractListModel *>().id();
    qmlRegisterTypesAndRevisions<QGCArchiveModel>("QGroundControl.Compression", 1);
    qmlRegisterModule("QGroundControl.Compression", 1, 0);
}

static const QQmlModuleRegistration qGroundControlCompressionRegistration("QGroundControl.Compression", qml_register_types_QGroundControl_Compression);
