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


        // left panel
    Item {
        id: controlItem
        width: 150
        height: parent.height
        ControlPanel {
            id: controlPanel
            width: parent.width
            anchors.top: parent.top
            anchors.topMargin: 5
            anchors.left: parent.left
            anchors.leftMargin: 5
        }
    }

    Item {
        id: inforItem
//        color: "red"
        anchors.left: controlItem.right
        anchors.right: parent.right
        height: parent.height
        VentParamView {
            id: paramViewer
            anchors.top: parent.top
            anchors.topMargin: 5
            anchors.horizontalCenter: inforItem.horizontalCenter
        }

        ColumnLayout {
            spacing: 2

            anchors.bottom: parent.bottom
            anchors.bottomMargin: 5

            anchors.right: parent.right
            anchors.rightMargin: 5

            anchors.top: paramViewer.bottom
            anchors.topMargin: 5

            anchors.left: parent.left
            anchors.leftMargin: 5


            VentGraphicViewPressure {
                id: pressureView
                visible: true
                anchors.fill: parent
            }

            VentGraphicViewVolumn {
                id: flowView
                visible: false
                anchors.fill: parent

                Layout.fillWidth: true
                Layout.fillHeight: true

                Component.onCompleted: {
                    console.log("VentGraphicViewVolumn height: ", flowView.height)
                }
            }
        }
    }


}

