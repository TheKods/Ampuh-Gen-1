/****************************************************************************
** Generated QML type registration code
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include <QtQml/qqml.h>
#include <QtQml/qqmlmoduleregistration.h>

#include <Viewer3DCameraController.h>
#include <Viewer3DGeoCoordinateType.h>
#include <Viewer3DInstancing.h>


#if !defined(QT_STATIC)
#define Q_QMLTYPE_EXPORT Q_DECL_EXPORT
#else
#define Q_QMLTYPE_EXPORT
#endif
Q_QMLTYPE_EXPORT void qml_register_types_QGroundControl_Viewer3D()
{
    qmlRegisterTypesAndRevisions<Viewer3DCameraController>("QGroundControl.Viewer3D", 1);
    qmlRegisterTypesAndRevisions<Viewer3DGeoCoordinateType>("QGroundControl.Viewer3D", 1);
    qmlRegisterTypesAndRevisions<Viewer3DInstancing>("QGroundControl.Viewer3D", 1);
    qmlRegisterAnonymousType<QQuick3DInstancing, 254>("QGroundControl.Viewer3D", 1);
    qmlRegisterModule("QGroundControl.Viewer3D", 1, 0);
}

static const QQmlModuleRegistration qGroundControlViewer3DRegistration("QGroundControl.Viewer3D", qml_register_types_QGroundControl_Viewer3D);
