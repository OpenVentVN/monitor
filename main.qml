import QtQuick 2.0
import QtQuick.Controls 2.1
import QtQuick.Controls.Material 2.1
import QtQuick.Layouts 1.0
import QtQuick.Window 2.2
import QtQuick.Window 2.2

Item {
    id: main
    visible: true
    width: 800
    height: 480
    Material.theme: Material.Dark
    Material.accent: Material.Purple

    signal s_config_changed(int _id, double _value)
    signal s_updated_ie_param_flag()
    signal s_updated_ie_param_start(int _f)

    HomeView{
        id: homepage
        anchors.fill: parent
    }

    ConfigPopup{
        id: puconfig
    }

    PatientInfoPopup{
        id: pupatient
    }

}

