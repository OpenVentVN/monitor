#include "datasource.h"
#include <QtCharts/QXYSeries>
#include <QtCharts/QAreaSeries>
#include <QtQuick/QQuickView>
#include <QtQuick/QQuickItem>
#include <QtCore/QDebug>
//#include <QtCore/QRandomGenerator>
#include <QtCore/QtMath>

QT_CHARTS_USE_NAMESPACE

Q_DECLARE_METATYPE(QAbstractSeries *)
Q_DECLARE_METATYPE(QAbstractAxis *)

#define MAXVAL 120


DataSource::DataSource(QQuickView *appViewer, QObject *parent) :
    QObject(parent),
    m_appViewer(appViewer)
{
    qRegisterMetaType<QAbstractSeries*>();
    qRegisterMetaType<QAbstractAxis*>();
}

void DataSource::addPressureData(QPointF pP)
{
    QMutexLocker locker(&this->_mutex);
    if (this->m_pressureData.count() >= 150){
        this->m_pressureDataTmp = this->m_pressureData;
        this->m_pressureData.clear();

        for(int i = 1 ; i< this->m_pressureDataTmp.count(); i++){
            QPointF pointtmp;
            pointtmp.setX(this->m_pressureDataTmp.at(i).x() - 0.1);
            pointtmp.setY(this->m_pressureDataTmp.at(i).y());
            m_pressureData.push_back(pointtmp);
        }
    }
    m_pressureData.push_back(pP);
}

void DataSource::addVolumData(QPointF vP)
{
    QMutexLocker locker(&this->_mutex);

    if (this->m_volumnData.count() >= MAXVAL)
        this->m_volumnData.clear();

    m_volumnData.push_back(vP);
}

void DataSource::updatePressureData(QAbstractSeries *series)
{
    QMutexLocker locker(&this->_mutex);

    if (series)
    {
        QXYSeries *xySeries = static_cast<QXYSeries *>(series);
        xySeries->replace(this->m_pressureData);
    }
}

void DataSource::updateVolumnData(QAbstractSeries *series)
{
    QMutexLocker locker(&this->_mutex);

    if (series)
    {
        QXYSeries *xySeries = static_cast<QXYSeries *>(series);
        xySeries->replace(this->m_volumnData);
    }

}

