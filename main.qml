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

    HomeView{
        id: homepage
        anchors.fill: parent
    }

}

