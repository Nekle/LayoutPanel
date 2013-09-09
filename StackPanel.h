//
//  StackPanel.h
//  LayoutPanel
//
//  Created by nekle on 13-9-7.
//  Copyright (c) 2013年 nekle. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum _LayoutArchor
{
    // you can only use under values when flowDirector =  eLayoutFlowDirectorHorizonal
    ehLayoutArchorLeftTop,
    ehLayoutArchorLeftCenter,
    ehLayoutArchorLeftBottom,
    ehLayoutArchorCenterTop,
    ehLayoutArchorCenterCenter,
    ehLayoutArchorCenterBottom,
    ehLayoutArchorRightTop,
    ehLayoutArchorRightCenter,
    ehLayoutArchorRightBottom,
    // you can only use under values when flowDirector =  eLayoutFlowDirectorVertical
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


typedef enum _LayoutFlowDirect
{
    eLayoutFlowDirectorVertical,
    eLayoutFlowDirectorHorizonal,

}LayoutFlowDirector;

/*
 * margin 的设置只影响周围的 view 的位置与自己位置之间的距离.
 * 比如说view A 的 margin.right , 只有当A左边存在另一个 view B 时, 才会体现出 margin.right 的距离.
 */
@interface LayoutMargin : NSObject
@property (assign, nonatomic)    CGFloat top;
@property (assign, nonatomic)    CGFloat left;
@property (assign, nonatomic)    CGFloat bottom;
@property (assign, nonatomic)    CGFloat right;
-(NSString *)description;

@end

LayoutMargin* LayoutMarginMake(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right);
#define LayoutZero LayoutMarginMake(0, 0, 0, 0)

@interface StackPanel : UIView

@property (nonatomic, assign, readonly) CGSize size;
@property (nonatomic, assign, readonly) CGSize currentContentSize;
@property (nonatomic, assign) LayoutFlowDirector flowDirector;
@property (nonatomic, assign) LayoutArchor archor;
@property (nonatomic, retain) NSMutableArray *elements;
@property (nonatomic, retain) NSMutableArray *margins;

- (void)addView:(UIView*)element;
- (void)addView:(UIView *)element withMargin:(LayoutMargin*) margin;




@end
