import QtQuick 2.0
import QtCharts 2.1

/*
 Chart 2: Flow monitor
 */

ChartView {
    id: flowChartView
    theme: ChartView.ChartThemeDark
    property bool openGL: true
    property bool openGLSupported: true
    property string serieName: "Flow"

    // title: "Volumn"

    ValueAxis {
        id: axisY1
        min: 0
        max: 800
    }

    ValueAxis {
        id: axisX
        min: 0
        max: 60
    }

    SplineSeries {
        id: flowSeries
        name: "Flow"
        axisX: axisX
        axisY: axisY1
        useOpenGL: true
    }

    Timer {
        id: refreshTimer
        interval: 1 / 60 * 1000 // 60 Hz
        running: true
        repeat: true
        onTriggered: {
            dataSource.update(flowChartView.series(0));
        }
    }
}

