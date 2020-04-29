#ifndef CHARTDATASOURCE_H
#define CHARTDATASOURCE_H

#include <QObject>

class ChartDataSource : public QObject
{
    Q_OBJECT
public:
    explicit ChartDataSource(QObject *parent = nullptr);
    QPointF getPressureData();
    QPointF getVolumnData();
signals:

public slots:
    void updateDataChart(double _data_y);

private:
    double _pressure_data_x;
    double _pressure_data_y;
};

#endif // CHARTDATASOURCE_H
