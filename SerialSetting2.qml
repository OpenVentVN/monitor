import QtQuick 2.0

Item {
    id:serial
    Connections{
        target: serialData2
        onM_is_connected_changed:{
            if(serialData2.isConnected) {
                //connected
            }
            else{
                //disconnected
            }
        }
    }

    Connections{
        target: mainwindown
        onS_connect_serial_2:{
            connect_to_serial()
        }
    }


    function connect_to_serial(){
        if(listSerial.count > 1){
            if(!serialData2.isConnected){       // if port is being closed, can update port name
                serialData2.updateComportSettings(listSerial.get(1).portname);
                console.log("abc ",listSerial.get(1).portname)
            }
            serialData2.openCloseComport();
            if(serialData2.isConnected) {
                console.log("qml serial connected")
            }
            else{
                console.log("qml serial connected")

            }
        }
        else console.log("only detected 1 uart")
    }

}
