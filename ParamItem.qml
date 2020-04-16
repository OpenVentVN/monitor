import QtQuick 2.0
import QtQuick.Layouts 1.0

Item {
    id: paramDisplay
    property string dspText: "20"
    property string dspValue: "20"
    property string dspDv: "ml"


    width: 150
    height: 100

    ColumnLayout {
        spacing: 8
        Layout.fillHeight: true

        Text {
            text: paramDisplay.dspText
            font.pointSize: 12
            color: "#ffffff"

            Layout.alignment: Qt.AlignCenter
        }

        Text {
            id: value
            text: paramDisplay.dspValue
            font.pointSize: 32
            color: "#ffffff"
        }

        Text {
            text: paramDisplay.dspDv
            font.pointSize: 12
            color: "#ffffff"

            Layout.alignment: Qt.AlignCenter
        }
    }


}
