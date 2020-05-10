import QtQuick 2.12
import QtQuick.Controls 2.5

ApplicationWindow {
    visible: true
    width: 640
    height: 650
    title: qsTr("Scroll")

    ScrollView {
        anchors.fill: parent

        Item {
            id: nameBot
            anchors.fill: parent
            LeftNevig{
                id:side
                norWidth: 312
                height: parent.height
                onCurIdxChanged: {
                    stack.replace(null, repRect.itemAt(curIdx))
                }
            }

            StackView{
                id:stack
                anchors.left: side.right
                anchors.right: parent.right
                //anchors.leftMargin: 100
                height:parent.height
                initialItem: repRect.itemAt(0)

                replaceEnter:Transition {
                    PropertyAnimation {
                        property: "opacity"
                        from: 0
                        to:1
                        duration: 200
                    }
                }

                replaceExit:Transition {
                    PropertyAnimation {
                        property: "opacity"
                        from: 0
                        to:1
                        duration: 20
                    }
                }
            }

            Component {
                id:rect
                Rectangle{
                    color: rectCol
                    TextEdit{
                        width: 222
                        height: 40
                        anchors.centerIn: parent
                    }
                }
            }
            Repeater{
                id:repRect
                model:["red","pink","blue","black","yellow"]
                delegate:
                    Loader{
                        property var rectCol: modelData
                        sourceComponent: rect
                    }
            }
        }
    }
}
