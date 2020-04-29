#include "chartdatasource.h"
#include<QPointF>

ChartDataSource::ChartDataSource(QObject *parent) : QObject(parent)
{
    _pressure_data_x = 0;
    _pressure_data_y = 0;
}

QPointF ChartDataSource::getPressureData()
{
    _pressure_data_x += 0.1;
    if(_pressure_data_x > 15) _pressure_data_x = 15;
    return QPointF(_pressure_data_x,_pressure_data_y);
}

QPointF ChartDataSource::getVolumnData()
{
    return QPointF(_pressure_data_x,_pressure_data_y);
}

void ChartDataSource::updateDataChart(double _data_y)
{
    _pressure_data_y = _data_y;
}
