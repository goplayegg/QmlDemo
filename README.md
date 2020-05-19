# QmlDemo
this is a qml demo about navigator animation 导航栏 of Acfun
图标版权归Acfun所有 仅用于学习


![效果](demo.gif)


##左侧导航栏切换时小滑块的滚动动画逻辑

单独定义一个滑块对象animSlider跟导航按钮一个parent ， 用于动画。
当切换导航时animSlider显示，当动画结束时animSlider隐藏。
每个导航按钮内部自带一个小滑块，用于停靠显示，选中且动画结束时才显示出来。不复用animSlider主要考虑到有滚动条情况下，改变位置太复杂，耦合太高。
动画的起始结束位置，通过ButtonGroup.checkedButton 计算上一个和当前导航按钮的y坐标位置即可


