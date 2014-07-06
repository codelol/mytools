import QtQuick 2.2
import QtQuick.Window 2.1
import QtQuick.Dialogs 1.2
import QtQuick.Controls 1.2

import "control.js" as JSLogic

Window {
    visible: true
    width: 200
    height: 120
    title: "Timer"

    Rectangle{
        id: notifier
        width: parent.width
        height: parent.height
        color: "#FFFFFF"
        visible: false

        Timer{
            id: nTimer
            interval: 200
            repeat: true
            onTriggered: JSLogic.flashNotifier(nTimer, notifier)
        }
    }

    Timer{
        id: myTimer
        repeat: true
        onTriggered: JSLogic.timerHandler(myTimer, controlButton, controlButtonBackground, notifier, nTimer, timeMin, timeSec)
    }

    Rectangle{
        y: 10
        width: 80 ; height: 40
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset : -50
        border.width: 3
        border.color: "blue"
        radius: 5

        TextInput {
            id: timeMin
            color: "#4b4b4b"
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 20; font.bold: true
            maximumLength: 3
            text: "20"
            validator: IntValidator{bottom: 0; top: 60;}
            focus: true
        }
    }

    Text{
        y: 15
        anchors.horizontalCenter: parent.horizontalCenter
        text: ":"
        font.pixelSize: 20; font.bold: true
    }

    Rectangle{
        y: 10
        width: 80 ; height: 40
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset : +50
        border.width: 3
        border.color: "blue"
        radius: 5

        TextInput {
            id: timeSec
            color: "#4b4b4b"
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 20; font.bold: true
            maximumLength: 3
            text: "00"
            validator: IntValidator{bottom: 0; top: 60;}
            focus: true
        }
    }


    Rectangle {
        id: controlButtonBackground
        y: 60
        anchors.horizontalCenter: parent.horizontalCenter
        width: 170
        height: 40
        color: "green"
        Text{
            id: controlButton
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Start"
            font.pixelSize: 20; font.bold: true
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                controlButton.text = JSLogic.buttonClick(controlButton, controlButtonBackground, notifier, myTimer, nTimer);
            }
        }

    }

}
