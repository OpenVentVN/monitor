#ifndef DATASOURCE_H
#define DATASOURCE_H

/**
  Data source for Ventilator monitor:
    1. Pressure monitor
    2. Volumn monitor
    3. Flow monitor

  Paramters:
    1. MVE
    2. VT
    3. Pavg
    4. PEEP
    5. Rate
    6. FiO2

  Functions:
    1. Set modes
    2. Set params

*/


#include <QObject>
#include <QMutex>
#include <QtCharts/QAbstractSeries>

QT_BEGIN_NAMESPACE
class QQuickView;
QT_END_NAMESPACE

QT_CHARTS_USE_NAMESPACE

class DataSource : public QObject
{
    Q_OBJECT
public:
    explicit DataSource(QQuickView *appViewer, QObject *parent = 0);

    void addPressureData(QPointF pP);
    void addVolumData(QPointF vP);

Q_SIGNALS:

public slots:
    void updatePressureData(QAbstractSeries *series);
    void updateVolumnData(QAbstractSeries *series);


private:
    QQuickView *m_appViewer;

    QVector<QPointF> m_pressureData;
    QVector<QPointF> m_volumnData;
    QVector<QPointF> m_flowData;

    QMutex _mutex;

    friend class DataSink;
};

#endif // DATASOURCE_H
