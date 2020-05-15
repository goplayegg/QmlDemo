import QtQuick 2.12
import QtQuick.Controls 2.5

Rectangle{
    id:root
    color: "#F9FAFE"
    width: shrinked?shrinkWidth:norWidth
    Behavior on width {
        NumberAnimation{ duration: 100; easing.type: Easing.OutQuad}
    }

    property bool logined :false
    property var jsLogin : ({avatar:"",username:"",userid:""})
    property alias shrinked: tabBar.shrinked
    property alias curIdx: tabBar.curIdx
    property alias norWidth: tabBar.norWidth
    property alias shrinkWidth: tabBar.shrinkWidth

    function loginInfo(){
        jsLogin = {
            "avatar":"qrc:/avatar.jpg",
            "username":"敌军还有30秒到达葬场",
            "userid":"923834",
            "level":"23"}
        console.log("jsLogin", JSON.stringify(jsLogin))
    }

    Item{
        id:topArea
        height: logined?(shrinked?160:237):(shrinked?160:112)
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.topMargin: 30
        anchors.leftMargin: shrinked?20:35
        anchors.rightMargin: anchors.leftMargin

        Image{
            id:logo
            anchors.top: parent.top
            height: shrinked?40:45
            width: shrinked?40:150
            source: shrinked?"qrc:/d.png":"qrc:/a_z.png"
        }
        Button{
            id:btnCategory
            anchors.right: parent.right
            height: 40
            width: height
            y:shrinked?logo.height+10:0
            icon.source: "qrc:/z0.png"
            hoverEnabled: true
            background: Rectangle{
                color: btnCategory.hovered?"white":"#DEE5EB"
                radius: height/2
            }
        }
        Button{
            id:btnLogin
            visible: !logined
            anchors.right: parent.right
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
            height: shrinked?40:38
            icon.source: "qrc:/ug.png"
            text: shrinked?"":qsTr("登陆账户")
            background: Rectangle{
                color: shrinked?"white":"#00A1D6"
                radius: shrinked?height/2:3
            }
            onClicked: {
                loginInfo()
                logined = true
                tabBar.setVisible(3, true)
                tabBar.setVisible(6, true)
            }
        }
        RoundImage{
            id:imgAvatar
            visible: logined
            source: jsLogin.avatar
            y: btnCategory.y+btnCategory.height+20
            anchors.horizontalCenter: parent.horizontalCenter
            size: shrinked?40:60
            onClicked: {
                logined = false
                tabBar.setVisible(3, false)
                tabBar.setVisible(6, false)
            }
        }
        Text{
            id:txUserName
            visible: logined&&(!shrinked)
            text: jsLogin.username
            font.pointSize: 12
            font.family: "微软雅黑"
            font.weight: Font.Bold
            anchors.top: imgAvatar.bottom
            anchors.topMargin: 22
            anchors.horizontalCenter: parent.horizontalCenter
        }
        Text{
            id:txUserId
            visible: txUserName.visible
            text: "lv:" + jsLogin.level
            font.family: "微软雅黑"
            anchors.top: txUserName.bottom
            anchors.topMargin: 5
            anchors.horizontalCenter: parent.horizontalCenter
        }
        Grid{
            columns: 3
            rowSpacing: 5
            visible: txUserName.visible
            anchors.top: txUserId.bottom
            anchors.topMargin: 15
            width: parent.width
            Repeater {
                model: ["4454444","14", "144222466", "动态", "关注", "粉丝"]
                Text {
                    text: modelData;
                    width: parent.width/3;
                    font.family: "微软雅黑"
                    horizontalAlignment: Text.AlignHCenter;
                }
            }
        }
    }

    SideBar{
        id:tabBar
        defaultSelIdx:1

        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: topArea.bottom
        anchors.bottom: parent.bottom

        Component.onCompleted: {
            tabBar.addItem({"spliter":true,"text":"","icon":"","iconChecked":"","hide":false})
            tabBar.addItem({"text":qsTr("视频"),"icon":"qrc:/u9.png","iconChecked":"qrc:/u9Red.png"})
            tabBar.addItem({"text":qsTr("文章"),"icon":"qrc:/a3a.png","iconChecked":"qrc:/a3c.png"})
            tabBar.addItem({"text":qsTr("动态"),"icon":"qrc:/ub.png","iconChecked":"qrc:/uc.png","hide":true})
            tabBar.addItem({"text":qsTr("排行榜"),"icon":"qrc:/a7p2.png","iconChecked":"qrc:/a7p.png"})
            tabBar.addItem({"spliter":true})
            tabBar.addItem({"text":"设置","icon":"qrc:/a4g.png","iconChecked":"qrc:/a4g2.png","hide":true})
            tabBar.addItem({"text":"关于","icon":"qrc:/ug.png","iconChecked":"qrc:/uh.png"})
        }
    }
}
