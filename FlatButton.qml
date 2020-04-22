import QtQuick 2.0
import "."

Item {
    id: button
    width: 80
    height: 36
    property alias text: label.text
    property alias textColor: label.color

    signal clicked()

    Rectangle {
        id: background
        anchors.fill: parent
        radius: 3
        color: button.enabled ? "#00999999" : "#1a999999"
    }

    Text {
        id: label
        font.pixelSize: 18
        font.bold: true
        horizontalAlignment:Text.AlignHCenter
        width: parent.width
        color:  "black"
        opacity: button.enabled ? 1 : 0.62
        verticalAlignment: Text.AlignVCenter
        anchors.verticalCenter: parent.verticalCenter
        Behavior on opacity {
            NumberAnimation {
                duration: 200
                easing.type: Easing.Bezier; easing.bezierCurve: [0.4, 0, 0.2, 1, 1, 1]
            }
        }
    }

    PaperRipple {
        id: ripple
        radius: 3
        mouseArea: mouseArea
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        enabled: button.enabled
        onClicked: button.clicked()
    }
}
