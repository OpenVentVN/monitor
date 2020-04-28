import QtQuick 2.0

Rectangle {
    width:  800
    height: 480
    color: "#262626"
    property bool waitingComponent: false

    Rectangle{
        id: recInfor
        color: "black"
        width: 780 //740
        height: 373//353
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top;
        anchors.topMargin: 10//30
    }

    VentGraphicViewPressure {
        id: pressureView
        anchors.top: patientlb.bottom ;anchors.topMargin: -20
        anchors.left: columbtinfo.right; anchors.leftMargin: -10
        anchors.right: recInfor.right ;anchors.rightMargin: -10
        anchors.bottom: recInfor.bottom ; anchors.bottomMargin: -10
    }

    PatientInforLabel{
        id: patientlb
        anchors.top: recInfor.top
        anchors.topMargin: 5
        anchors.right: recInfor.right
        anchors.rightMargin: 5
        anchors.left: columbtinfo.right
        anchors.leftMargin: 5

//        patientFistName: "Chanh"
//        patientLastName: "Thai Quoc"
//        patientGender: false
//        patientAge: "30"
//        patientHigh: "160"
//        patientWeight: "61"
    }

    Column{
        id: columbtinfo
        spacing: 5
//        anchors.top: recInfor.top
//        anchors.topMargin: 5
        anchors.left: recInfor.left
        anchors.leftMargin: 5
        anchors.verticalCenter: recInfor.verticalCenter

        InfoButton{
            id: vtbutton
            valueCenter: "500"
            valueLeft: "VT"
            valueRight: "ml"
            buttonID: 1
            lowLimit: 200
            upLimit: 800
            stepConfig: 10
            onValueCenterChanged: {
                if(waitingComponent && writeParameterFlag) writeDataControl()
            }
        }

        InfoButton{
            id: iebutton
            valueCenter: "1"
            valueLeft: "Ti"
            valueRight: "s"
            buttonID: 2
            lowLimit: 0.5
            upLimit: 2
            stepConfig: 0.1
            onValueCenterChanged: {
                if(waitingComponent && writeParameterFlag) writeDataControl()
            }
        }
        InfoButton{
            id: fbutton
            valueCenter: "20"
            valueLeft: "F"
            valueRight: "bpm"
            buttonID: 3
            lowLimit: 5
            upLimit: 40
            stepConfig: 1
            onValueCenterChanged: {
                if(waitingComponent && writeParameterFlag) writeDataControl()
            }
        }
        InfoButton{
            id: peepbutton
            valueCenter: "10"
            valueLeft: "PEEP"
            valueRight: "cmH2O"
            buttonID: 4
            lowLimit: 5
            upLimit: 20
            stepConfig: 1
            onValueCenterChanged: {
               if(waitingComponent && writeParameterFlag) writeDataControl()
            }
        }
        InfoButton{
            id: pipbutton
            valueCenter: "21"
            valueLeft: "PIP"
            valueRight: "%"
            buttonID: 5
            lowLimit: 20
            upLimit: 40
            stepConfig: 1
            onValueCenterChanged: {
               if(waitingComponent && writeParameterFlag) writeDataControl()
            }
        }
        InfoButton{
            id: supbutton
            valueCenter: "10"
            valueLeft: "SUP"
            valueRight: "%"
            buttonID: 6
            lowLimit: 0
            upLimit: 100
            stepConfig: 10
            onValueCenterChanged: {
                if(waitingComponent && writeParameterFlag) writeDataControl()
            }
        }
    }

    Row{
        id: rowmode
        spacing: 40
        anchors.left: parent.left; anchors.leftMargin: 30
        anchors.bottom: parent.bottom; anchors.bottomMargin: 26
//        anchors.left: columbtinfo.right
//        anchors.leftMargin: 30

        ModeButton{
            id: cmvbutton
            buttonStatus: true
            buttonName: "A/VC"
            onClicked: {
                currentMode = 0
                buttonStatus = !buttonStatus
                acbutton.buttonStatus = false
                cpapbutton.buttonStatus = false
                writeDataControl()
            }
        }
        ModeButton{
            id: acbutton
            buttonStatus: false
            buttonName: "SIMV+PS"
            onClicked: {
                currentMode = 1
                buttonStatus = !buttonStatus
                cmvbutton.buttonStatus = false
                cpapbutton.buttonStatus = false
                writeDataControl()
            }
        }
        ModeButton{
            id: cpapbutton
            buttonStatus: false
            buttonName: "PRVC"
            onClicked: {
                currentMode = 2
                buttonStatus = !buttonStatus
                acbutton.buttonStatus = false
                cmvbutton.buttonStatus = false
                writeDataControl()
            }
        }
    }

    StartButton{
        id:startbt
        anchors.right: parent.right
        anchors.rightMargin: 30
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 15
        onButtonStatusChanged: {
            if(serialControl) serialData1.startStopVent(buttonStatus)
            else serialData2.startStopVent(buttonStatus)
        }

    }
    function writeDataControl(){
        if(serialControl) serialData1.writeParameter(currentMode,vtbutton.valueCenter*1,iebutton.valueCenter*1000,
                                                     fbutton.valueCenter*1,peepbutton.valueCenter*1,
                                                     pipbutton.valueCenter*1,supbutton.valueCenter*1)
        else serialData2.writeParameter(currentMode,vtbutton.valueCenter*1,iebutton.valueCenter*1000,
                                        fbutton.valueCenter*1,peepbutton.valueCenter*1,
                                        pipbutton.valueCenter*1,supbutton.valueCenter*1)
    }
    Component.onCompleted: {
        waitingComponent = true
    }

    Connections{
        target: serialData1
        onM_read_data_vent:{
            currentMode = _mode
            vtbutton.valueCenter = _vt.toString()
            iebutton.valueCenter = (_ti/1000).toFixed(1).toString()
            fbutton.valueCenter = _f.toString()
            peepbutton.valueCenter = _peep.toString()
            pipbutton.valueCenter = _pip.toString()
            supbutton.valueCenter = _ps.toString()
        }
    }
    Connections{
        target: serialData2
        onM_read_data_vent:{
            writeParameterFlag = false
            currentMode = _mode
            vtbutton.valueCenter = _vt.toString()
            iebutton.valueCenter = (_ti/1000).toFixed(1).toString()
            fbutton.valueCenter = _f.toString()
            peepbutton.valueCenter = _peep.toString()
            pipbutton.valueCenter = _pip.toString()
            supbutton.valueCenter = _ps.toString()
            set_current_mode()
        }
    }

    function set_current_mode(){
        if(currentMode == 0){
            cmvbutton.buttonStatus = true
            acbutton.buttonStatus = false
            cpapbutton.buttonStatus = false
        }
        else if(currentMode == 1){
            acbutton.buttonStatus = true
            cmvbutton.buttonStatus = false
            cpapbutton.buttonStatus = false
        }
        else if(currentMode == 2){
            cpapbutton.buttonStatus = true
            acbutton.buttonStatus = false
            cmvbutton.buttonStatus = false
        }
    }

}
