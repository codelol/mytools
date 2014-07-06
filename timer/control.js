.pragma library

function getRandomColor(curColor){
    var str = String(curColor);
    var colors = ["#FFFFFF", "#FFFF00", "#0000FF", "#FF0000", "#00FF00", "#FF00FF"]
    var idx
    for(idx = 0; idx < colors.length; ++idx){
        if (str.toUpperCase() == colors[idx].toUpperCase())
            break;
    }
    idx = (idx + 1) % colors.length
    return colors[idx]
}

function getAppTitle(){
    return "Timer"
}
