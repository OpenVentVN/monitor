import QtQuick 2.0

Rectangle {
    id: patientlb
    width: 564
    height: 40
    color: "white"

    property string patientName: "_ _ _ _ _ _ _ _ _ _"
    property string patientGender: "_ _"
    property string patientAge: "_ _"
    property string patientHigh: "_ _"
    property string patientWeight: "_ _"



    Row{
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 20
        anchors.verticalCenter: parent.verticalCenter
        Text {
            id: textName
            text: patientName == ""? "_ _ _ _ _ _ _ _ _ _": patientName
            font.pixelSize: 18
            color: "#4a4a4a"
            width: 200
            font.bold: true
        }

        Text {
            id: textGender
            text: patientGender == ""? "_ _" : patientGender
            font.pixelSize: 18
            color: "#4a4a4a"
            width: 60
        }

        Text {
            id: textAge
            text: patientAge == ""? "_ _" : patientAge
            font.pixelSize: 18
            color: "#4a4a4a"
            width: 40
        }

        Text {
            id: textHigh
            text: patientHigh == ""? "_ _cm" : patientHigh+"cm"
            font.pixelSize: 18
            color: "#4a4a4a"
            width: 60
        }

        Text {
            id: textWeight
            text: patientWeight == ""? "_ _kg" : patientWeight+"kg"
            font.pixelSize: 18
            color: "#4a4a4a"
            width: 60
        }

    }

}
