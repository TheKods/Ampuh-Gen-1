/****************************************************************************
** Generated QML type registration code
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include <QtQml/qqml.h>
#include <QtQml/qqmlmoduleregistration.h>

#include <CheckerboardTextureData.h>
#include <FlightPathGeometry.h>
#include <GeoMapCamera.h>
#include <GeoMapItem.h>
#include <GeoMapProjectedPath.h>
#include <GeoScene.h>
#include <PaperPlaneGeometry.h>
#include <PatchGeometry.h>
#include <PatchTextureData.h>
#include <SurfacePatchModel.h>


#if !defined(QT_STATIC)
#define Q_QMLTYPE_EXPORT Q_DECL_EXPORT
#else
#define Q_QMLTYPE_EXPORT
#endif
Q_QMLTYPE_EXPORT void qml_register_types_QGroundControl_GeoMap()
{
    qmlRegisterTypesAndRevisions<CheckerboardTextureData>("QGroundControl.GeoMap", 1);
    qmlRegisterTypesAndRevisions<FlightPathGeometry>("QGroundControl.GeoMap", 1);
    qmlRegisterAnonymousType<QQuick3DGeometry, 254>("QGroundControl.GeoMap", 1);
    qmlRegisterTypesAndRevisions<GeoMapCamera>("QGroundControl.GeoMap", 1);
    qmlRegisterTypesAndRevisions<GeoMapItem>("QGroundControl.GeoMap", 1);
    qmlRegisterAnonymousType<QQuickItem, 254>("QGroundControl.GeoMap", 1);
    qmlRegisterTypesAndRevisions<GeoMapProjectedPath>("QGroundControl.GeoMap", 1);
    qmlRegisterTypesAndRevisions<GeoScene>("QGroundControl.GeoMap", 1);
    qmlRegisterTypesAndRevisions<PaperPlaneGeometry>("QGroundControl.GeoMap", 1);
    qmlRegisterTypesAndRevisions<PatchGeometry>("QGroundControl.GeoMap", 1);
    qmlRegisterTypesAndRevisions<PatchTextureData>("QGroundControl.GeoMap", 1);
    qmlRegisterTypesAndRevisions<SurfacePatchModel>("QGroundControl.GeoMap", 1);
    qmlRegisterAnonymousType<QAbstractItemModel, 254>("QGroundControl.GeoMap", 1);
    qmlRegisterModule("QGroundControl.GeoMap", 1, 0);
}

static const QQmlModuleRegistration qGroundControlGeoMapRegistration("QGroundControl.GeoMap", qml_register_types_QGroundControl_GeoMap);
