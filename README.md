## 用处
LayoutPanel 是一个 view 排布器, 你可以随意的将你的 view 添加到里面, 然后指定排布器如何对添加的 view 进行排布.
使用排布器将使你从繁琐的view 位置计算中解放出来, 使你只要同过指定一个排布方式,就可以对一个或更多的 view 进行定位.

>![img](http://farm4.staticflickr.com/3684/9719064830_001b26b167.jpg)

这幅图展示了StackPanel排布器的基本用法.
你可以很方便的构建一个 dock 菜单, 比如上图中的右侧菜单,或者下方的应用 dock, 或者按钮工具条.

## StackPanel 布局选项

StackPanel 布局分为水平和垂直方式. <br/>
<code>
typedef enum _LayoutFlowDirect <br/>
{ 								<br/>
    eLayoutFlowDirectorVertical, // 垂直 <br/>
    eLayoutFlowDirectorHorizonal, // 水平 <br/>
}LayoutFlowDirector; <br/>
</code>

在水平和垂直布局中, 又分为上中下, 左中右对齐方式. <br/>
<code>
typedef enum _LayoutArchor <br/>
{							<br/>
    // you can use under values when flowDirector =  eLayoutFlowDirectorHorizonal <br/>
    ehLayoutArchorLeftTop,<br/>
    ehLayoutArchorLeftCenter,<br/>
    ehLayoutArchorLeftBottom,<br/>
    ehLayoutArchorCenterTop, <br/>
    ehLayoutArchorCenterCenter, <br/>
    ehLayoutArchorCenterBottom, <br/>
    ehLayoutArchorRightTop, <br/>
    ehLayoutArchorRightCenter, <br/>
    ehLayoutArchorRightBottom, <br/>
    // you can use under values when flowDirector =  eLayoutFlowDirectorVertical <br/>
    evLayoutArchorTopLeft, <br/>
    evLayoutArchorTopCenter, <br/>
    evLayoutArchorTopRight, <br/>
    evLayoutArchorCenterLeft, <br/>
    evLayoutArchorCenterCenter, <br/>
    evLayoutArchorCenterRight, <br/>
    evLayoutArchorBottomLeft, <br/>
    evLayoutArchorBottomCenter, <br/>
    evLayoutArchorBottomRight, <br/>
}LayoutArchor; <br/>
</code>


## 增加了排布器中元素的 margin 属性设置, 使得元素的定位更加方便,个性化
`margin` 的设置顺序为[上,左,下,右] 逆时针设置.
### use
+ 1. #import "StackPanel.h"

+ 2. 创建一个 `StackPanel`, 
>`StackPanel *stack = [[[StackPanel alloc] initWithFrame:CGRectMake(0, 0, 80, 460)] autorelease];`

+ 3. 添加 `view` 到 `stack` 中 
`[stack addView:button]` <br/>
这样写, 将使得添加到排布器中的 `button` 的 `margin` 为 `[0, 0, 0, 0]`. 
`[stack addView:button withMargin:LayoutMarginMake(10, 10, 10, 10)]` <br/>
这样写将使得添加到排布器中的 `button` 的 `margin` 为 [10, 10, 10, 10].



