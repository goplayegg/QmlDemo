import QtQuick 2.12
import QtQuick.Controls 2.5

Item {
    id: root
    property bool checked: false
    property var barJs: ({})
    property int idx: 0
    property bool isBtn: !barJs.spliter
    property var button: null
    property bool shrinked: false
    height: 45
    width: parent.width

    Component {
        id: barComp
        Button {
            id: btn
            property int idx: root.idx
            flat:true
            checkable: true
            checked: root.checked
            text: barJs.text
            icon.source: checked? barJs.iconChecked:barJs.icon
            display:root.shrinked?AbstractButton.IconOnly:AbstractButton.TextBesideIcon
            onCheckedChanged: root.checked = checked
            Component.onCompleted: {
                root.button = btn
                //console.log("btn:"+btn.text+" y:"+btn.y+" x:"+btn.x+" width:"+btn.width)
            }
            contentItem: Row{
                anchors.left: parent.left
                anchors.leftMargin: 30
                spacing: 15
                Image {
                    height: parent.height
                    width: height
                    source: btn.icon.source
                }
                Text {
                    height: parent.height
                    text: btn.text
                    font: btn.font
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                }
            }
            background: Rectangle{
                color: "transparent"
            }
        }
    }

    Component {
        id: splitComp
        Item {
            id: name
            anchors.fill: parent
            anchors.topMargin: 22
            anchors.bottomMargin: anchors.topMargin
            Rectangle {
                color: "pink"
                anchors.fill: parent
            }
        }
    }

    Loader {
        id: barLoader
        anchors.fill: parent
        sourceComponent:barJs.spliter?splitComp:barComp
    }
}
