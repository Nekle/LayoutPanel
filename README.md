*TODO*:

1. ~~完成StackPanel.~~ 
2. 优化StackPanel.
3. 写一个好的StackPanel Demo.
4. ~~完成GridPanel.~~
5. 优化GridPanel.
6. 写一个好的GridPanel Demo.
7. ~~完成DockPanel.~~
8. 优化DockPanel.
9. 写一个好的DockPanel Demo.
10. 写一个介绍博客.

## 用处
LayoutPanel 是一个 view 排布器, 你可以随意的将你的 view 添加到里面, 然后指定排布器如何对添加的 view 进行排布.
使用排布器将使你从繁琐的view 位置计算中解放出来, 使你只要同过指定一个排布方式,就可以对一个或更多的 view 进行定位.

>![img](http://farm4.staticflickr.com/3684/9719064830_001b26b167.jpg)

这幅图展示了StackPanel排布器的基本用法.
你可以很方便的构建一个 dock 菜单, 比如上图中的右侧菜单,或者下方的应用 dock, 或者按钮工具条.

## StackPanel 布局选项

StackPanel 布局分为水平和垂直方式. <br/>

```
typedef enum _LayoutFlowDirect 
{ 								
    eLayoutFlowDirectorVertical, // 垂直 
    eLayoutFlowDirectorHorizonal, // 水平 
}LayoutFlowDirector; 
```

在水平和垂直布局中, 又分为上中下, 左中右对齐方式. <br/>

```
typedef enum _LayoutArchor 
{							
    // you can use under values when flowDirector =  eLayoutFlowDirectorHorizonal 
    ehLayoutArchorLeftTop,
    ehLayoutArchorLeftCenter,
    ehLayoutArchorLeftBottom,
    ehLayoutArchorCenterTop, 
    ehLayoutArchorCenterCenter, 
    ehLayoutArchorCenterBottom, 
    ehLayoutArchorRightTop, 
    ehLayoutArchorRightCenter, 
    ehLayoutArchorRightBottom, 
    // you can use under values when flowDirector =  eLayoutFlowDirectorVertical 
    evLayoutArchorTopLeft, 
    evLayoutArchorTopCenter, 
    evLayoutArchorTopRight, 
    evLayoutArchorCenterLeft, 
    evLayoutArchorCenterCenter, 
    evLayoutArchorCenterRight, 
    evLayoutArchorBottomLeft, 
    evLayoutArchorBottomCenter, 
    evLayoutArchorBottomRight, 
}LayoutArchor; 
```


## 增加了排布器中元素的 margin 属性设置, 使得元素的定位更加方便,个性化
`margin` 的设置顺序为[上,左,下,右] 逆时针设置.
### use
+ import "StackPanel.h"

+ 创建一个 `StackPanel`

```
StackPanel *stack = [[[StackPanel alloc] initWithFrame:CGRectMake(0, 0, 80, 460)] autorelease];
```
+ 添加 `view` 到 `stack` 中 
`[stack addView:button]` 这样写, 将使得添加到排布器中的 `button` 的 `margin` 为 `[0, 0, 0, 0]`. 

```
[stack addView:button withMargin:LayoutMarginMake(10, 10, 10, 10)] <br/>
```
这样写将使得添加到排布器中的 `button` 的 `margin` 为 [10, 10, 10, 10].


### DockPanel
#### 说明
可选择的dock 方式如下:<br/>

```
typedef enum _DockSideType {
    DockSideTypeLeft,
    DockSideTypeRight,
    DockSideTypeTop,
    DockSideTypeBottom,
    DockSideTypeFill,
}DockSideType;
```
当你使用`DockSideTypeLeft`时, 这个 `view` 将在`DockPanel`中最左排布, 并且这个`view`的高度将会和`DockPanel`的高度相同.

#### 使用
```
DockPanel *dock = [[DockPanel alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
UILabel *d1 = [[UILabel alloc] initWithFrame:CGRectZero];
d1.text = @"Left";
[d1 sizeToFit];
[dock addView:d1 withMargin:LayoutMarginMake(10, 10, 10, 10) dock:DockSideTypeLeft];
``` 

### GridPanel

竖屏:<br/>

![img](http://farm3.staticflickr.com/2890/10242773796_bae90f2159.jpg)

横屏:<br/>
![img](http://farm8.staticflickr.com/7438/10242773856_e5c243a97c.jpg)

**横屏 与 竖屏的切换, 只需要设置frame的高宽, grid 将自动重新计算以适应新的尺寸.**

#### 说明
可选择的grid 布局方式如下:<br/>

```
typedef enum _GridLayout
{
    eLayoutLeftTop = 0x00,
    eLayoutLeftCenter = 0x01,
    eLayoutLeftBottom = 0x02,
    eLayoutCenterTop = 0x03,
    eLayoutCenterCenter = 0x04,
    eLayoutCenterBottom = 0x05,
    eLayoutRightTop = 0x06,
    eLayoutRightCenter = 0x07,
    eLayoutRightBottom = 0x08,
    
    eLayoutFillWidth  = 0x4000,
    eLayoutFillHeight = 0x8000,
    eLayoutFill = 0x4000 | 0x8000,
    
} GridLayoutArchor;

``` 
Fill 布局方式能够自动根据 grid 大小调整响应的大小以适应grid的变化,

#### 使用

```

GridPanel *grid = [[GridPanel alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
    [grid setRows:[[NSMutableArray alloc] initWithObjects:@"60%", @"40%" , nil] andColumn:[[NSMutableArray alloc] initWithObjects:@"40%", @"60%", nil]] ;
    grid.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:grid];
    
    UILabel *name = [[UILabel alloc] init];
    name.text = @"1";
    name.textAlignment = NSTextAlignmentCenter;
    name.backgroundColor = [UIColor greenColor];
    
```



