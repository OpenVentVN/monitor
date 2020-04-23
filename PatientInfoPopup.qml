import QtQuick 2.0
import QtQuick.Controls 2.0

Popup {
    id: config
    x: (main.width - width) / 2
    y: Math.abs(main.height - height) / 2
    closePolicy: Popup.NoAutoClose
    modal: true
    focus: true

    property alias patientFistName: patientfistname.patientInfor
    property alias patientLastName: patientlastname.patientInfor
    property bool   patientGender: true
    property alias patientAge: patientage.patientInfor
    property alias patientHigh: patienthigh.patientInfor
    property alias patientWeight: patientweight.patientInfor

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
            id: rowname
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 108
            spacing: 30
            PatientInfoInput{
                id: patientfistname
                title: "First name"
                patientInfor: patientFistName
            }
            PatientInfoInput{
                id: patientlastname
                title: "Last name"
                width: 180
                patientInfor: patientLastName

            }
        }
        PatientInfoInput{
            id: patientage
            title: "Age"
            width: 180
            anchors.right: rowname.right
            anchors.top: rowname.bottom
            anchors.topMargin: 30
            patientInfor: patientAge

        }
        Row {
            id: genderitem
            height: patientage.height
            width: 350
            anchors.top: rowname.bottom
            anchors.topMargin: 30
            anchors.left: rowname.left
            spacing: 50

            Text {
                text: "Gender"
                font.pixelSize: 18
                color: "white"
                anchors.verticalCenter: parent.verticalCenter
            }

            GenderButton{
                id: malebt
                anchors.verticalCenter: parent.verticalCenter
                buttonName: "Male"
                buttonStatus: patientGender
                onClicked: {
                    buttonStatus = true
                    femalebt.buttonStatus = false
                    patientGender = true // true: male

                }
            }
            GenderButton{
                id: femalebt
                buttonName: "Female"
                anchors.verticalCenter: parent.verticalCenter
                buttonStatus: !patientGender
                onClicked: {
                    buttonStatus = true
                    malebt.buttonStatus = false
                    patientGender = false // false : female
                }
            }
        }
        Row{
            id: rowheight
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: genderitem.bottom
            anchors.topMargin: 30
            spacing: 30
            PatientInfoInput{
                id: patienthigh
                title: "Height (cm)"
                width: 265
                patientInfor: patientHigh

            }
            PatientInfoInput{
                id: patientweight
                title: "Weight (kg)"
                width: 265
                patientInfor: patientWeight

            }
        }
        Row{
            id: rowbt
            spacing: 10
            width: rowheight.width
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 35

            GeneralButton{
                width: (rowbt.width - rowbt.spacing)/3
                text: "Close"
                color: "#757575"
                onClicked: pupatient.close()
            }
            GeneralButton{
                width: (rowbt.width - rowbt.spacing)*2/3
                text: "Update"
                onClicked: {
                    s_updated_patient_info(patientFistName,patientLastName,patientGender,patientAge,patientHigh,patientWeight)
                    pupatient.close()
                }
            }

        }



    }
}

