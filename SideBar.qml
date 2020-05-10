import QtQuick 2.12
import QtQuick.Controls 2.5

Rectangle{
    id:root
    color: "#F9FAFE"
    width: shrinked?shrinkWidth:norWidth
    Behavior on width {
        NumberAnimation{ duration: 100; easing.type: Easing.OutQuad}
    }

    property alias shrinked: btnShrink.checked
    property int count: 0
    property int defaultSelIdx: 0
    property int curIdx: 0
    property int norWidth: 312
    property int shrinkWidth: 80


    function addItem(js){
        count++
        barModel.append(js)
        console.log(JSON.stringify(js))
    }

    function changeSelect(idx){
        console.log("SideBar selected idx:"+idx)
        var lastY = nextY()
        curIdx = idx
        slider.newY = nextY()
        slider.newH = nextH()
        var sliderHMax = lastY - slider.newY
        if(sliderHMax<0){
            slider.maxH = -sliderHMax + slider.newH
            slider.goDown()
        }else{
            slider.maxH = sliderHMax + slider.newH
            slider.goUp()
        }

    }

    function nextY(){
        var curBar = bars.itemAt(curIdx)
        var pt = colBars.mapToItem(slider.parent, curBar.x, curBar.y)
        console.log("sild y:"+pt.y)
        return pt.y
    }
    function nextH(){
        var curBar = bars.itemAt(curIdx)
        return curBar.height
    }

    ButtonGroup {
        id: btnGroup
        //buttons: colBars.children
        onClicked:{
            changeSelect(button.idx)
        }
    }

    Column{
        id:colBars
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.leftMargin: slider.width

        ListModel{
            id:barModel
        }

        Repeater{
            id:bars
            model: barModel
            delegate: SideBarItem{
                    barJs:model
                    idx:index
                    shrinked: root.shrinked
                }
            Component.onCompleted: {
                var lsBtns = []
                for(var i=0;i<count;++i){
                    var btn = itemAt(i)
                    if(btn.isBtn){
                        lsBtns.push(btn.button)
                    }
                }
                btnGroup.buttons = lsBtns

                itemAt(defaultSelIdx).checked = true
                timer.start()
                console.log("bars onCompleted")
            }
        }
    }
    Timer{
        id:timer;
        interval: 0
        onTriggered: {
            changeSelect(defaultSelIdx)
        }
    }

    SideBarSlider{
        id: slider
    }

    Button{
        id:btnShrink
        hoverEnabled:true
        background: Rectangle{
            radius: width/2
            color: btnShrink.hovered?"white":"#DEE5EB"
        }
        checkable: true
        text: checked? ">>":"<<"
        anchors.left: parent.left
        anchors.leftMargin: checked ? 20:30
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 20
        width: 40
        height: width
    }
}
