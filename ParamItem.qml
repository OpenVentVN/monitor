import QtQuick 2.0
import QtQuick.Layouts 1.0

Item {
    id: paramDisplay
    property string dspText: "20"
    property string dspValue: "20"
    property string dspDv: "ml"


    width: 100
    height: 100

    ColumnLayout {
        spacing: 8
        anchors.horizontalCenter: parent.horizontalCenter
//        Layout.fillHeight: true

        Text {
            text: paramDisplay.dspText
            font.pixelSize: 12
            color: "#ffffff"

//            Layout.alignment: Qt.AlignCenter
            horizontalAlignment: Text.AlignHCenter
        }

        Text {
            id: value
            text: paramDisplay.dspValue
            font.pixelSize: 20
            color: "#ffffff"
            horizontalAlignment: Text.AlignHCenter
        }

        Text {
            text: paramDisplay.dspDv
            font.pixelSize: 12
            color: "#ffffff"

//            Layout.alignment: Qt.AlignCenter
            horizontalAlignment: Text.AlignHCenter
        }
    }


}
