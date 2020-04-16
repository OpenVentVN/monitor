#ifndef SAMPLEDATASOURCE_H
#define SAMPLEDATASOURCE_H

#include <QObject>
#include <QtCharts/QAbstractSeries>


class SampleDataSource : public QObject
{
public:
    SampleDataSource();

    QPointF getPressureData();
    QPointF getVolumnData();


private:
    int _internalPressureCounter;
    int _internalVolumnCounter;


};

#endif // SAMPLEDATASOURCE_H
