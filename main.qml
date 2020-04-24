import QtQuick 2.0
import QtQuick.Controls 2.1
import QtQuick.Controls.Material 2.1
import QtQuick.Layouts 1.0
import QtQuick.Window 2.2
import QtQuick.Window 2.2
import QtQuick.VirtualKeyboard 2.1
import QtQuick.VirtualKeyboard.Settings 2.1

ApplicationWindow {
    id: mainwindown
    visible: true
    width: 800
    height: 480
    Material.theme: Material.Dark
    Material.accent: Material.Purple

    property int currentMode: 1
    property bool serialControl: true // true: sensor uart, false: control uart, default uart 1 is control, uart 2 is sensor

    signal s_config_changed(int _id, double _value)
    signal s_updated_ie_param_flag()
    signal s_updated_ie_param_start(int _f)
    signal s_updated_patient_info(string _fname, string _lname, bool _gender, string _age, string _high, string _weight)

    signal s_connect_serial_2();

    HomeView{
        id: homepage
        anchors.fill: parent
    }

    ConfigPopup{
        id: puconfig
    }

    PatientInfoPopup{
        id: pupatient
        visible: false
    }

    ListModel{
        id: listSerial
    }
    SerialSetting1{
        id: serial1
    }
    SerialSetting2{
        id: serial2
    }

    Connections{
        target: serialData1
        onM_type_uart_sensor:{
            serialControl = false
        }
    }

    Connections{
        target: serialData2
        onM_type_uart_sensor:{
            serialControl = true
        }
    }

}

