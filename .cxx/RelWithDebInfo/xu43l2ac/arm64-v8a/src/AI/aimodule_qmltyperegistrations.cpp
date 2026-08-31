/****************************************************************************
** Generated QML type registration code
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include <QtQml/qqml.h>
#include <QtQml/qqmlmoduleregistration.h>

#include <AIController.h>
#include <AIDetectionBox.h>
#include <AIDetectionManager.h>


#if !defined(QT_STATIC)
#define Q_QMLTYPE_EXPORT Q_DECL_EXPORT
#else
#define Q_QMLTYPE_EXPORT
#endif
Q_QMLTYPE_EXPORT void qml_register_types_QGroundControl_AI()
{
    qmlRegisterTypesAndRevisions<AIController>("QGroundControl.AI", 1);
    qmlRegisterTypesAndRevisions<AIDetectionBox>("QGroundControl.AI", 1);
    qmlRegisterTypesAndRevisions<AIDetectionManager>("QGroundControl.AI", 1);
    qmlRegisterModule("QGroundControl.AI", 1, 0);
}

static const QQmlModuleRegistration qGroundControlAIRegistration("QGroundControl.AI", qml_register_types_QGroundControl_AI);
