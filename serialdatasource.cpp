#include "serialdatasource.h"
#include <QDebug>
#include <QPointF>


SerialDataSource::SerialDataSource()
{
    _pressure_data_x = 0;
    _pressure_data_y = 0;
    _tran_id = 1;
    _run_on_start = true;

    m_serial_port = new QSerialPort(this);
    enumerator = new QextSerialEnumerator(this);
    enumerator->setUpNotifications();

    connect(m_serial_port,SIGNAL(readyRead()), this, SLOT(readData()));
    connect(enumerator, SIGNAL(deviceDiscovered(QextPortInfo)), SLOT(portAddedRemoved()));
    connect(enumerator, SIGNAL(deviceRemoved(QextPortInfo)), SLOT(portAddedRemoved()));

    fillSerialPortInfo();
    updatePortStatus(false);

//    updateComportSettings("ttyUSB0");
//    openCloseComport();
}

void SerialDataSource::processLine(const QByteArray &line)
{
    qDebug() << "data sensor "<<line << line.toHex() << line.toHex().length();
    if(line.toHex().length() == 32){
        //control buffer responsed 16 bytes
        //01680100090101f403e8140a150aaa16

        QString dataHex = line.toHex();
        bool ok = false;
        QString hexcommand = dataHex.mid(2,2);
        if(hexcommand.toInt(&ok,16) == 104 || hexcommand.toInt(&ok,16) == 103){
            // responsed when write or read command

            int _mode = dataHex.mid(10,2).toInt(&ok,16);

            int _vt_hi = dataHex.mid(12,2).toInt(&ok,16);
            int _vt_lo = dataHex.mid(14,2).toInt(&ok,16);
            int _vt = ((_vt_hi << 8) | _vt_lo);

            int _ti_hi = dataHex.mid(16,2).toInt(&ok,16);
            int _ti_lo = dataHex.mid(18,2).toInt(&ok,16);
            int _ti = ((_ti_hi << 8) | _ti_lo);

            int _f =  dataHex.mid(20,2).toInt(&ok,16);
            int _peep =  dataHex.mid(22,2).toInt(&ok,16);
            int _pip =  dataHex.mid(24,2).toInt(&ok,16);
            int _ps =  dataHex.mid(26,2).toInt(&ok,16);
            emit m_read_data_vent(_mode,_vt,_ti,_f,_peep,_pip,_ps);
   //unsigned char _mode, int _vt, int _ti, unsigned char _f, unsigned char _peep, unsigned char _pip, unsigned char _ps

        }
    }
    else{
        QString data_sensor = QString(line);
        data_sensor.remove("\r\n");
        QStringList data_process;
        data_process = data_sensor.split(',');

        if(data_process.size() == 5){
            emit m_update_data_pressure(data_process.at(3).toLong());
            if(_run_on_start){
                emit m_type_uart_sensor();
            }
        }
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
    updatePortStatus(m_serial_port->isOpen());

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

void SerialDataSource::startStopVent(bool _stt)
{
    qDebug() << "startStopVent " << _stt;
    if(_stt){
        unsigned char functionID = 101;
        unsigned char packet_start_tmp[]= {0x01,functionID,_tran_id,0x00,0x00};
        unsigned short crc = crc16(packet_start_tmp, sizeof (packet_start_tmp));
        unsigned char crchi = crc >> 8;
        unsigned char crclo = crc;
        unsigned char packet_start[]= {0x01,functionID,_tran_id,0x00,0x00,crchi,crclo};

        writeDataToSerial(packet_start,sizeof (packet_start));
    }
    else{
        unsigned char functionID = 102;
        unsigned char packet_stop_tmp[]= {0x01,functionID,_tran_id,0x00,0x00};
        unsigned short crc = crc16(packet_stop_tmp, sizeof (packet_stop_tmp));
        unsigned char crchi = crc >> 8;
        unsigned char crclo = crc;
        unsigned char packet_stop[]= {0x01,functionID,_tran_id,0x00,0x00,crchi,crclo};

        writeDataToSerial(packet_stop,sizeof (packet_stop));

    }
    _tran_id ++;
    if(_tran_id == 0) _tran_id = 1;
}

void SerialDataSource::readParameter()
{
    unsigned char functionID = 103;
    unsigned char packet_tmp[]= {0x01,functionID,_tran_id,0x00,0x00};
    unsigned short crc = crc16(packet_tmp, sizeof (packet_tmp));
    unsigned char crchi = crc >> 8;
    unsigned char crclo = crc;
    unsigned char packet[]= {0x01,functionID,_tran_id,0x00,0x00,crchi,crclo};

    writeDataToSerial(packet,sizeof (packet));
    _tran_id ++;
    if(_tran_id == 0) _tran_id = 1;
    qDebug() << "read current parameter";
}

void SerialDataSource::writeParameter(unsigned char _mode, int _vt, int _ti, unsigned char _f, unsigned char _peep,
                                      unsigned char _pip, unsigned char _ps)
{
//    qDebug() << _mode << _vt << _ti << _f << _peep << _pip << _ps;
    unsigned char vthi = _vt >> 8;
    unsigned char vtlo = _vt;

    unsigned char tihi = _ti >> 8;
    unsigned char tilo = _ti;

    unsigned char functionID = 104;
    unsigned char packet_tmp[]= {0x01,functionID,_tran_id,0x00,0x09,_mode,vthi,vtlo,tihi,tilo,_f,_peep,_pip,_ps};
    unsigned short crc = crc16(packet_tmp, sizeof (packet_tmp));
    unsigned char crchi = crc >> 8;
    unsigned char crclo = crc;
    unsigned char packet[]= {0x01,functionID,_tran_id,0x00,0x09,_mode,vthi,vtlo,tihi,tilo,_f,_peep,_pip,_ps,crchi,crclo};

    writeDataToSerial(packet,sizeof (packet));
    _tran_id ++;
    if(_tran_id == 0) _tran_id = 1;
}

QString SerialDataSource::getPortName(int idx)
{
    QString temp_str;
    if(idx < m_serial_port_info.size()){
        temp_str = m_serial_port_info.at(idx)->portName;
        temp_str.remove("/dev/");
        if(temp_str.mid(0,6) == "ttyUSB") return temp_str;
        else return "NA";
    }

    else {return "NA";}
}

bool SerialDataSource::isConnected()
{
    qDebug() << "isConnected" << _connection_state;

    return _connection_state;
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
//        qDebug() << "serial device " <<m_serial_port_info.at(i)->portName;
    }
}

void SerialDataSource::portAddedRemoved()
{
    if(m_serial_port->isOpen()) {
        m_serial_port->close();
    }

    fillSerialPortInfo();
    updatePortStatus(false);
    emit m_is_port_list_updated_changed();



    //emit signal port add or removed to do something
//    updateComportSettings("ttyUSB0");
    //    openCloseComport();
}

void SerialDataSource::updatePortStatus(bool connection_state)
{
    _connection_state = connection_state;
    emit m_is_connected_changed(_connection_state);
    qDebug() << "_connection_state " << _connection_state;
//    emit m_is_port_list_updated_changed();
}

void SerialDataSource::writeDataToSerial(unsigned char *_data, int _length)
{
    if(m_serial_port->isOpen()){
        m_serial_port->write(QByteArray((char *) _data, _length));

        qDebug () << "write data to serial port";
    }
    else {
        qDebug("Serial >> Please check the connection then open the Comport");
    }
}

unsigned short SerialDataSource::crc16(unsigned char *buffer, int buffer_length)
{
    unsigned char crc_hi = 0xFF; /* high CRC byte initialized */
    unsigned char crc_lo = 0xFF; /* low CRC byte initialized */
    unsigned int i; /* will index into CRC lookup */

    /* pass through message buffer */
    while (buffer_length--) {
        i = crc_hi ^ *buffer++; /* calculate the CRC  */
        crc_hi = crc_lo ^ table_crc_hi[i];
        crc_lo = table_crc_lo[i];
    }
//    qDebug() << "crc low " << crc_lo << "crc hi " << crc_hi;


    return (crc_hi << 8 | crc_lo);
}
