import QtQuick 2.12
import QtQuick.Controls 2.5

Rectangle{
    id:root
    color: "#F9FAFE"
    width: shrinked?shrinkWidth:norWidth
    Behavior on width {
        NumberAnimation{ duration: 100; easing.type: Easing.OutQuad}
    }

    property alias shrinked: tabBar.shrinked
    property alias curIdx: tabBar.curIdx
    property alias norWidth: tabBar.norWidth
    property alias shrinkWidth: tabBar.shrinkWidth

    Item{
        id:topArea
        height: shrinked?160:112
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
            tabBar.addItem({"spliter":true,"text":"","icon":"","iconChecked":""})
            tabBar.addItem({"text":"btn1","icon":"qrc:/banana.png","iconChecked":"qrc:/like.png"})
            tabBar.addItem({"text":"btn2","icon":"qrc:/like.png","iconChecked":"qrc:/banana.png"})
            tabBar.addItem({"text":"btn3","icon":"qrc:/coment.png","iconChecked":"qrc:/like.png"})
            tabBar.addItem({"text":"btn4","icon":"qrc:/banana.png","iconChecked":"qrc:/coment.png"})
            tabBar.addItem({"spliter":true})
            tabBar.addItem({"text":"btn3","icon":"qrc:/coment.png","iconChecked":"qrc:/like.png"})
            tabBar.addItem({"text":"btn4","icon":"qrc:/banana.png","iconChecked":"qrc:/coment.png"})
        }
    }
}
