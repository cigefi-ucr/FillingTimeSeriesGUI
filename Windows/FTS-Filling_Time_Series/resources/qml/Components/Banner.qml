import QtQuick 2.3
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.5

RowLayout{
    width: parent.width * 9 / 10
    height: parent.height / 4
    anchors.top: parent.top
    anchors.horizontalCenter: parent.horizontalCenter
    spacing: 100
    Rectangle {
        id: ucr
        Layout.fillWidth: true
        Layout.fillHeight: true
        color: "transparent"
        Image{
            anchors.centerIn: parent
            sourceSize: Qt.size(parent.width, parent.height)
            source: "../../images/ucr.jpg"   
        }
    }

    Rectangle {
        id: appName
        Layout.fillWidth: true
        Layout.fillHeight: true
        color: "transparent"
        
        Text {
            id: complete
            anchors.centerIn: parent
            text: qsTr("Filling Time Series")
            font.pixelSize: parent.width / 10
			font.family: "Sans-Serif"
            color: "white"
        }
    }

    Rectangle {
        id: cigefi
        Layout.fillWidth: true
        Layout.fillHeight: true
        color: "transparent"
        Image{
            anchors.centerIn: parent
            sourceSize: Qt.size(parent.width, parent.height)
            source: "../../images/cigefi.jpg"
        }
    }       
}
