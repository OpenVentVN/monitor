import QtQuick 2.1
import QtQuick.Layouts 1.0

/*
  Paramters:
    1. MVE
    2. VT
    3. Pavg
    4. PEEP
    5. Rate
    6. FiO2
 */

Row {
    spacing: 2
//    anchors.fill: parent

    ParamItem {
        id: paramVT
        dspText: "VT"
        dspValue: "500"
        dspDv: "mL"
    }

    ParamItem {
        id: paramRR
        dspText: "Rate"
        dspValue: "20"
        dspDv: "bpm"
    }

    ParamItem {
        id: paramIE
        dspText: "I/E"
        dspValue: "1:2"
        dspDv: ""
    }

    ParamItem {
        id: paramITime
        dspText: "iTime"
        dspValue: "1.25"
        dspDv: "sec"
    }

    ParamItem {
        id: paramPEEP
        dspText: "PEEP"
        dspValue: "10"
        dspDv: "cmH2O"
    }


    ParamItem {
        id: paramFiO2
        dspText: "FiO2"
        dspValue: "21"
        dspDv: "%"
    }
}
