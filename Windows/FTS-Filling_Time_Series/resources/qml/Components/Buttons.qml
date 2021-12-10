import QtQuick 2.3
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.5

Button {
    id:ctrl
    property color colorButton
    property int buttonWidth
    property int buttonHeight
    property int buttonFontSize

    background: 
    Rectangle {
        id:cr
        implicitWidth: buttonWidth
        implicitHeight: buttonHeight
        color: "transparent"
        border.color: ctrl.pressed ? Qt.darker(colorButton) : ctrl.hovered ? Qt.lighter(colorButton) : colorButton 
        border.width: main.width / 150
        radius: 50
    }

    contentItem: Text{
        text: ctrl.text
        font.pixelSize: buttonFontSize
        font.family: "Sans-Serif"
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        color: ctrl.pressed ? Qt.darker(colorButton) : ctrl.hovered ? Qt.lighter(colorButton) : colorButton 
    }
}
