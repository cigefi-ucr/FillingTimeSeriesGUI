import QtQuick 2.3
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.5
import QtQuick.Dialogs 1.3
import "Components"

ApplicationWindow {
    id:main
    visible: true
    visibility: Qt.WindowFullScreen
    width: 800
    height: 600
    title: qsTr("FTS - Filling Time Series")
    property QtObject ftsconn: QtObject{}
    property QtObject worker: QtObject{}
    property string filename: ""
    property string savedfilename: ""
    property string parameter: ""
    property var fullRange: []
    property int upperRange: 1
    property int upperRangeAR: 1
    property int belowRange: 1
    property double tol: 0.1
    property double valueMin: 0.0
    property int parCh: 1
    property int parS: 1
    property int maxIter: 1
    property int adMethod: 2
    property bool visBtn: false
    property bool visSection: false
    property bool vis: false
    
    Rectangle {
        width: parent.width
        height: parent.height
        color: "transparent"
        Image {
            width: parent.width
            height:parent.height
            source: "../images/Hurricane.jpg"
        }
    }

    Banner {
        id:banner
    }
    
    Rectangle {
        id: views
        width: parent.width
        height: parent.height- banner.height
        anchors.top: banner.bottom
        color: "#80000000"
        Carrousel{
            id:carrousel
        }
    } 
}
