#include <QGuiApplication>
#include <QtWidgets/QApplication>
#include <QtGui/QGuiApplication>
#include <QtQml/QQmlApplicationEngine>
#include <QQmlApplicationEngine>
#include <QtQml/QQmlContext>
#include <QtQuick/QQuickView>
#include <QtQml/QQmlEngine>
#include <QtCore/QDir>

#include "datasource.h"
#include "datasink.h"
#include "sampledatasource.h"
#include "serialdatasource.h"
#include "datasinkserial.h"


int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    QQuickView viewer;

    QString extraImportPath(QStringLiteral("%1/../../../%2"));
    viewer.engine()->addImportPath(extraImportPath.arg(QGuiApplication::applicationDirPath(),
                                      QString::fromLatin1("qml")));
    QObject::connect(viewer.engine(), &QQmlEngine::quit, &viewer, &QWindow::close);

    viewer.setTitle(QStringLiteral("Ventilator Monitor"));

    DataSource dataSource(&viewer);
    viewer.rootContext()->setContextProperty("dataSource", &dataSource);

    SampleDataSource sample;
    SerialDataSource serialData;

//    DataSink sink(&sample, &dataSource);
    DataSinkSerial sinkSerial(&serialData, &dataSource);



    viewer.setSource(QUrl("qrc:/main.qml"));
    viewer.setResizeMode(QQuickView::SizeRootObjectToView);
    viewer.setColor(QColor("#404040"));
    viewer.setWidth(800);
    viewer.setHeight(480);
    viewer.show();
//    viewer.showFullScreen();
    // viewer.showMaximized();

    return app.exec();
}

