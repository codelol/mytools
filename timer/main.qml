import QtQuick 2.2
import QtQuick.Window 2.1
import QtQuick.Controls 1.2
import QtMultimedia 5.0

import "control.js" as JSLogic

Window {
    id: appWindow
    visible: true
    width: 190
    height: 120
    title: JSLogic.getAppTitle()

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
            onTriggered: {
                notifier.color = JSLogic.getRandomColor(notifier.color)
                if (appWindow.title == "Timer" || appWindow.title == "Now!") {
                    appWindow.title = "Time up!";
                } else if (appWindow.title == "Time up!") {
                    appWindow.title = "Now!";
                }
            }
        }
    }

    Timer{
        id: myTimer
        interval: 1000
        repeat: true
        onTriggered: {
            var countDown = timeMin.text * 60.0 + timeSec.text * 1.0;
            if (countDown > 0) {
                countDown--;
            }
            if (countDown == 0) {
                myTimer.stop();
                controlButton.text =  "Reset"
                controlButtonBackground.color = "grey"
                notifier.visible = true
                nTimer.start()
                soundPlayer.play()
            }
            var sec = countDown % 60
            var min = Math.floor(countDown / 60);
            if (min < 10){
                min = "0"+min;
            }
            if (sec <10){
                sec = "0"+sec;
            }
            timeMin.text = min;
            timeSec.text = sec;
        }
    }

    SoundEffect {
            id: soundPlayer
            source: "alarm.wav"
            loops: 3
    }

    Rectangle{
        width: parent.width
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset : -55
        Button{
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset : -69
            width: 40
            text: "20:00"
            onClicked: {timeMin.text = "20"; timeSec.text = "00";}
        }
        Button{
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset : -23
            width: 40
            text: "15:00"
            onClicked: {timeMin.text = "15"; timeSec.text = "00";}
        }
        Button{
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset : 23
            width: 40
            text: "10:00"
            onClicked: {timeMin.text = "10"; timeSec.text = "00";}
        }
        Button{
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset : 69
            width: 40
            text: "05:00"
            onClicked: {timeMin.text = "05"; timeSec.text = "00";}
        }
    }

    Rectangle{
        y: 30
        width: parent.width
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset : -25

        Rectangle{
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
                KeyNavigation.tab: timeSec
            }
        }

        Text{
            y: 5
            anchors.horizontalCenter: parent.horizontalCenter
            text: ":"
            font.pixelSize: 20; font.bold: true
        }

        Rectangle{
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
                KeyNavigation.backtab: timeMin
            }
        }
    }


    Rectangle {
        id: controlButtonBackground
        y: 75
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset : 38
        width: 180
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
                var a = controlButton.text;
                if (a == "Start"){
                    myTimer.start();
                    controlButtonBackground.color = "red"
                    controlButton.text = "Stop"
                    timeMin.focus = false
                    timeSec.focus = false
                }else if(a == "Stop" || a == "Reset"){
                    if (a == "Stop") {
                        myTimer.stop();
                    } else if (a == "Reset") {
                        nTimer.stop();
                        notifier.visible = false
                    }
                    soundPlayer.stop()
                    appWindow.title = JSLogic.getAppTitle()
                    controlButtonBackground.color = "green"
                    controlButton.text = "Start"
                }
            }
        }

    }
}
