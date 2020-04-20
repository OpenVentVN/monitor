#include "serialdatasource.h"
#include <QDebug>
#include <QPointF>


SerialDataSource::SerialDataSource()
{
    _pressure_data_x = 0;
    _pressure_data_y = 0;

    m_serial_port = new QSerialPort(this);
    enumerator = new QextSerialEnumerator(this);
    enumerator->setUpNotifications();

    connect(m_serial_port,SIGNAL(readyRead()), this, SLOT(readData()));
    connect(enumerator, SIGNAL(deviceDiscovered(QextPortInfo)), SLOT(portAddedRemoved()));
    connect(enumerator, SIGNAL(deviceRemoved(QextPortInfo)), SLOT(portAddedRemoved()));

    fillSerialPortInfo();
    updateComportSettings("ttyUSB0");
    openCloseComport();
}

void SerialDataSource::processLine(const QByteArray &line)
{
    qDebug() << "data sensor "<<line;
    QString data_sensor = QString(line);
    data_sensor.remove("\r\n");
    QStringList data_process;
    data_process = data_sensor.split(',');

    if(data_process.size() == 5){
        _pressure_data_y =  data_process.at(3).toLong() ;
    }



}

void SerialDataSource::openCloseComport()
{
    qDebug() << "connecting serial " << _selected_port_name;
    if(m_serial_port->isOpen()){
        m_serial_port->close();
        qDebug() << "dis connect serial ";
    }
    else{
        m_serial_port->setPortName(_selected_port_name);
        m_serial_port->setBaudRate(QSerialPort::Baud115200);
        m_serial_port->setDataBits(QSerialPort::Data8);
        m_serial_port->setParity(QSerialPort::NoParity);
        m_serial_port->setStopBits(QSerialPort::OneStop);
        m_serial_port->setFlowControl(QSerialPort::NoFlowControl);
        m_serial_port->open(QIODevice::ReadWrite);
        if (m_serial_port->isOpen()) {
            qDebug() << "serial connected";
        }
       else{
            qDebug() << "serial disconnected";
        }
    }
}

void SerialDataSource::readData()
{
    processLine(m_serial_port->readAll());
}

QPointF SerialDataSource::getPressureData()
{
    _pressure_data_x += 0.1;
    if(_pressure_data_x > 15) _pressure_data_x = 15;
    return QPointF(_pressure_data_x,_pressure_data_y);
}

QPointF SerialDataSource::getVolumnData()
{
//    _pressure_data_x +=  0.05;
//    if(_pressure_data_x > 15) _pressure_data_x = 15;
    return QPointF(_pressure_data_x,_pressure_data_y);
}

QString SerialDataSource::getPortName(int idx)
{
    QString temp_str;
    if(idx < m_serial_port_info.size()){
        temp_str = m_serial_port_info.at(idx)->portName;
        temp_str.remove("/dev/");
        return temp_str;
    }

    else {return "NA";}
}

int SerialDataSource::getTotalPortsCount()
{
    return m_serial_port_info.size();
}

void SerialDataSource::updateComportSettings(QString portname_str)
{
    if(m_serial_port->isOpen()){
        m_serial_port->close();
    }
    _selected_port_name =  "/dev/"+portname_str;
    qDebug()<<"port " << _selected_port_name;
}

void SerialDataSource::fillSerialPortInfo()
{
    const auto infos = QSerialPortInfo::availablePorts();
    for (const QSerialPortInfo &info : infos) {
        serialPortInfor *m_port = new serialPortInfor();
        m_port->portName = info.portName();
        m_port->physName = info.systemLocation();
        m_serial_port_info.append(m_port);

    }
    if(m_serial_port_info.size() > 0){
         _selected_port_name = m_serial_port_info.at(0)->portName; // get the latest port
    }
    for(int i = 0; i < m_serial_port_info.size(); i++){
        qDebug() << "serial device " <<m_serial_port_info.at(i)->portName;
    }
}

void SerialDataSource::portAddedRemoved()
{
    if(m_serial_port->isOpen()) {
        m_serial_port->close();
    }

    fillSerialPortInfo();

    //emit signal port add or removed to do something
    updateComportSettings("ttyUSB0");
    openCloseComport();
}
