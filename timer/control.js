.pragma library

function flashNotifier(nTimer, notifier){
    var str = String(notifier.color);
    var colors = ["#FFFFFF", "#FFFF00", "#0000FF", "#FF0000", "#00FF00", "#FF00FF"]
    var idx
    for(idx = 0; idx < colors.length; ++idx){
        if (str.toUpperCase() == colors[idx].toUpperCase())
            break;
    }
    idx = (idx + 1) % colors.length
    notifier.color = colors[idx]
}

function timerHandler(timerId, controlButton, controlButtonBackground, notifier, nTimer, timeMin, timeSec){
    var countDown = timeMin.text * 60.0 + timeSec.text * 1.0;
    if (countDown > 0) {
        countDown--;
    }
    if (countDown == 0) {
        timerId.stop();
        controlButton.text =  "Reset"
        controlButtonBackground.color = "purple"
        notifier.visible = true
        nTimer.start()
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

function startTimer(timerId, myTimeInput){
    timerId.interval = 1000    
    timerId.start()
}
function stopTimer(timerId){
    timerId.stop();
}

function buttonClick(controlButton, controlButtonBackground, notifier, timerId, nTimer){
    var a = controlButton.text;
    if (a == "Start"){
        startTimer(timerId);        
        controlButtonBackground.color = "red"
        return "Stop"
    }else if(a == "Stop" || a == "Reset"){
        if (a == "Stop") {
            stopTimer(timerId);
        } else if (a == "Reset") {
            nTimer.stop();
            notifier.visible = false
        }

        controlButtonBackground.color = "green"
        return "Start"
    }
}
