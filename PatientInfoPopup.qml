import QtQuick 2.0
import QtQuick.Controls 2.0

Popup {
    id: config
    x: (main.width - width) / 2
    y: Math.abs(main.height - height) / 2
    closePolicy: Popup.NoAutoClose
    modal: true
    focus: true

    property string patientName: ""
    property string patientGender: ""
    property string patientAge: ""
    property string patientHigh: ""
    property string patientWeight: ""

    Rectangle {
        width: 800
        height: 480
        color: "black"
        anchors.centerIn: parent

        Text {
            text: "PATIENT CONDITION"
            font.pixelSize: 32
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 30
            color: "white"

        }

        Row{
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 108
            spacing: 30
            PatientInfoInput{
                title: "First name"
            }
            PatientInfoInput{
                title: "Last name"
                width: 180
            }
        }

    }
}

