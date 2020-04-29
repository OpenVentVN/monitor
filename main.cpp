#include <QGuiApplication>
#include <QtWidgets/QApplication>
#include <QtGui/QGuiApplication>
#include <QtQml/QQmlApplicationEngine>
#include <QQmlApplicationEngine>
#include <QtQml/QQmlContext>
#include <QtQuick/QQuickView>
#include <QtQml/QQmlEngine>
#include <QtCore/QDir>
#include <QQmlApplicationEngine>

#include "datasource.h"
#include "datasink.h"
#include "sampledatasource.h"
#include "serialdatasource.h"
#include "datasinkserial.h"
#include "chartdatasource.h"


int main(int argc, char *argv[])
{
#ifdef Q_OS_UNIX
    qputenv("QT_IM_MODULE", QByteArray("qtvirtualkeyboard"));
#endif

    QApplication app(argc, argv);

    QQuickView viewer;
    QQmlApplicationEngine engine;

    QString extraImportPath(QStringLiteral("%1/../../../%2"));
    viewer.engine()->addImportPath(extraImportPath.arg(QGuiApplication::applicationDirPath(),
                                      QString::fromLatin1("qml")));
    QObject::connect(viewer.engine(), &QQmlEngine::quit, &viewer, &QWindow::close);

    viewer.setTitle(QStringLiteral("Ventilator Monitor"));

    DataSource dataSource(&viewer);
//    SampleDataSource sample;
    SerialDataSource serialData1;
    SerialDataSource serialData2;
    ChartDataSource  chartData;

//    viewer.rootContext()->setContextProperty("dataSource", &dataSource);
    engine.rootContext()->setContextProperty("dataSource", &dataSource);
    engine.rootContext()->setContextProperty("serialData1", &serialData1);
    engine.rootContext()->setContextProperty("serialData2", &serialData2);



//    DataSink sink(&sample, &dataSource);
    DataSinkSerial sinkSerial(&chartData, &dataSource);

    QObject::connect(&serialData1,&SerialDataSource::m_update_data_pressure, &chartData, &ChartDataSource::updateDataChart);
    QObject::connect(&serialData2,&SerialDataSource::m_update_data_pressure, &chartData, &ChartDataSource::updateDataChart);


    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));


    return app.exec();
}

