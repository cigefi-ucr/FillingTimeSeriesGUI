import QtQuick 2.3
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.5


Rectangle{
    color: "transparent"
    Layout.alignment: Qt.AlignHCenter
    Layout.fillHeight: true
    Layout.fillWidth: true
    Rectangle {
        color: "transparent"
        anchors.fill: parent
        Text {
            text: "Choose methods"
            anchors.horizontalCenter: parent.horizontalCenter
            color: "white"
            font.pixelSize: parent.width / 20
            font.family: "Sans-Serif"
        }
    }

    Rectangle{
        anchors.fill: parent
        color: "transparent"
        Buttons {
            text: "PCA"
            visible: visBtn
            buttonWidth: parent.width / 5
            buttonHeight: parent.height / 3
            buttonFontSize: parent.width / 20
            colorButton: "yellowgreen"
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: parent.width / 10
            onClicked: {
                upperRange = ftsconn.continuePCA()
                belowRange = 1
                parameter = "Principal components"
                adMethod = 0
                vis = true
                visSection = false
            }
        }

        Buttons {
            text: "ULCL"
            visible: visBtn
            buttonWidth: parent.width / 5
            buttonHeight: parent.height / 3
            buttonFontSize: parent.width / 20
            colorButton: "yellowgreen"
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.rightMargin: parent.width / 10
            onClicked: {
                upperRange = ftsconn.continueULCL()
                belowRange = 0
                parameter = "Lags"
                adMethod = 1
                vis = true
                visSection = false
            }
        }

        Buttons {
            text: "Full"
            visible: visBtn
            buttonWidth: parent.width / 5
            buttonHeight: parent.height / 3
            buttonFontSize: parent.width / 20
            colorButton: "yellowgreen"
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: parent.width / 10
            onClicked: {
                fullRange = ftsconn.continueFull()
                upperRangeAR = fullRange[0]
                upperRange = fullRange[1]
                belowRange = 0
                parameter = "Components"
                adMethod = 2
                vis = true
                visSection = true
            }
        }
    }
}
