import QtQuick 2.3
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.5


Rectangle {
    color: "transparent"
    Text {
        text: "File is saved!"
        anchors.horizontalCenter: parent.horizontalCenter
        color: "white"
        font.pixelSize: main.width / 20
        font.family: "Sans-Serif"
    }
    Buttons {
        text: "Restart"
        buttonWidth: parent.width / 3
        buttonHeight: parent.height / 3
        buttonFontSize: parent.width / 20
        colorButton: "yellowgreen"
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: parent.width / 10
        onClicked: {
            vis = false
            visBtn = false
            visSection = false
            carrousel.pop(null)
        }
    }

    Buttons {
        text: "Quit"
        buttonWidth: parent.width / 3
        buttonHeight: parent.height / 3
        buttonFontSize: parent.width / 20
        colorButton: "tomato"
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: parent.width / 10
        onClicked: Qt.quit()
    }
}
