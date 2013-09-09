## 用处
LayoutPanel 是一个 view 排布器, 你可以随意的将你的 view 添加到里面, 然后指定排布器如何对添加的 view 进行排布.
使用排布器将使你从繁琐的view 位置计算中解放出来, 使你只要同过指定一个排布方式,就可以对一个或更多的 view 进行定位.
![img](http://farm4.staticflickr.com/3672/9697368433_98acd4e372.jpg)

这幅图展示了StackPanel排布器的基本用法.

## 增加了排布器中元素的 margin 属性设置, 使得元素的定位更加方便,个性化
`margin` 的设置顺序为[上,左,下,右] 逆时针设置.
### use
`[stack addView:button]` 
这样写, 将使得添加到排布器中的 `button` 的 `margin` 为 `[0, 0, 0, 0]`. 
`[stack addView:button withMargin:LayoutMarginMake(10, 10, 10, 10)]`
这样写将使得添加到排布器中的 `button` 的 `margin` 为 [10, 10, 10, 10].

