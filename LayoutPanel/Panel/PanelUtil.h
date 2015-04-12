//
//  PanelUtil.h
//  LayoutPanel
//
//  Created by nekle on 13-10-19.
//  Copyright (c) 2013年 nekle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define HighByte(t) ((t)&0xFF00)
#define LowByte(t)  ((t)&0x00FF)

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
#define LayoutMarginZero LayoutMarginMake(0, 0, 0, 0)

CGFloat GetLayoutWidth(CGRect frame, LayoutMargin *margin);

CGFloat GetLayoutHeight(CGRect frame, LayoutMargin *margin);


@interface LayoutElement: NSObject

@property (nonatomic, retain) LayoutMargin *margin;
@property (nonatomic, retain) UIView *view;
@property (nonatomic, assign) int eElementArchorType;
@property (nonatomic, assign) int row;
@property (nonatomic, assign) int column;

@end





#define xPanel_ArchorRect_Left(frame, rect, margin)   (frame).origin.x = (rect).origin.x + (margin).left


#define xPanel_ArchorRect_Center(frame, rect, margin) (frame).origin.x = (rect).origin.x + \
                                (rect).size.width/2 - (frame).size.width/2

#define xPanel_ArchorRect_Right(frame, rect, margin)   (frame).origin.x = (rect).origin.x+(rect).size.width - \
                                (frame).size.width - (margin).right




#define yPanel_ArchorRect_Top(frame, rect, margin)   (frame).origin.y = (rect).origin.y + (margin).top

#define yPanel_ArchorRect_Center(frame, rect, margin) (frame).origin.y = (rect).origin.y + \
                                (rect).size.height/2 - (frame).size.height/2

#define yPanel_ArchorRect_Bottom(frame, rect, margin)   (frame).origin.y = (rect).origin.y + \
                                (rect).size.height -(frame).size.height - (margin).bottom


