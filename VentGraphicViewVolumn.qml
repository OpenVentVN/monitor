import QtQuick 2.0
import QtCharts 2.1

/*
 Chart 2: Flow monitor
 */

//![1]
ChartView {
    id: flowChartView
    theme: ChartView.ChartThemeDark
    width: 600
    height: 400
    property bool openGL: true
    property bool openGLSupported: true
    property string serieName: "Volumn"

    // title: "Volumn"

    ValueAxis {
        id: axisY1
        min: 0
        max: 800
    }

    ValueAxis {
        id: axisX
        min: 0
        max: 15

        gridVisible:false
        tickCount: 8
    }

    SplineSeries {
        id: volumnSeries
        name: "Volumn"
        axisX: axisX
        axisY: axisY1
        useOpenGL: true

        width: 5
        color: "#ff7f50"
    }

    Timer {
        id: refreshTimer
        interval: 1 / 60 * 1000 // 60 Hz
        running: true
        repeat: true
        onTriggered: {
            dataSource.updateVolumnData(flowChartView.series(0));
        }
    }
}

