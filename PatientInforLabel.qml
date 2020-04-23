import QtQuick 2.0

Rectangle {
    id: patientlb
    width: 564
    height: 40
    color: "white"

    property string patientFistName: ""
    property string patientLastName: ""
    property bool   patientGender: true
    property string patientAge: ""
    property string patientHigh: ""
    property string patientWeight: ""

    Row{
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 20
        anchors.verticalCenter: parent.verticalCenter
        Text {
            id: textName
            text: patientFistName == ""? "_ _ _ _ _ _ _ _ _ _": patientLastName+ " "+patientFistName
            font.pixelSize: 18
            color: "#4a4a4a"
            width: 200
            font.bold: true
        }

        Text {
            id: textGender
            text: patientFistName == ""? "":patientGender? "Male" : "Female"
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

   MouseArea{
       anchors.fill: parent
       onClicked: {
           pupatient.patientFistName = patientFistName
           pupatient.patientLastName = patientLastName
           pupatient.patientAge = patientAge
           pupatient.patientGender = patientGender
           pupatient.patientHigh = patientHigh
           pupatient.patientWeight = patientWeight
           pupatient.open()
       }
   }
   Connections{
       target: main
       onS_updated_patient_info:{
           console.log("test signal ", _fname)
           patientFistName = _fname
           patientLastName = _lname
           patientGender = _gender
           patientAge = _age
           patientHigh = _high
           patientWeight = _weight
       }
   }
}
