import QtQuick 2.0

Item {
    id:serial
    Connections{
        target: serialData1
        onM_is_port_list_updated_changed: {
            check_and_set_current_port();
            reconnectSerial.running = true
        }
        onM_is_connected_changed:{
            if(serialData1.isConnected) {
                //connected
            }
            else{
                //disconnected
            }
        }
    }
    Timer{
        id: reconnectSerial
        interval: 1000;  repeat: false   // run once at start up
        running: false
        onTriggered: {
            if(!serialData1.isConnected){
                connect_to_serial()
                console.log("kkkkkkkkkkkkkkk")
            }

        }
    }
    Timer{
         id: getPortListTimer
         interval: 1000;  repeat: false   // run once at start up
         running: true
         onTriggered: {
             check_and_set_current_port()
             connect_to_serial()
             console.log("here")

         }
     }
    function connect_to_serial(){
        if(listSerial.count > 0){
            if(!serialData1.isConnected){       // if port is being closed, can update port name
                serialData1.updateComportSettings(listSerial.get(0).portname);
                console.log("abc ",listSerial.get(0).portname)
            }
            serialData1.openCloseComport();
            if(serialData1.isConnected) {
                console.log("qml serial connected")
            }
            else{
                console.log("qml serial connected")

            }
            s_connect_serial_2();
        }
    }

    function check_and_set_current_port()
    {
        listSerial.clear()
        for(var  i = 0 ; i < serialData1.getTotalPortsCount() ; i++){
            var portname = serialData1.getPortName(i);
            if(portname !== "NA"){
                listSerial.append({"portname": portname});
                console.log("qml serial name ", portname)
            }
        }

    }
}
