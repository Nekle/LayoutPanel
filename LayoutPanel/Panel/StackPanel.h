//
//  TStackPanel.h
//  LayoutPanel
//
//  Created by nekle on 13-10-16.
//  Copyright (c) 2013年 nekle. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PanelUtil.h"


/**
 *  StackPanel 是一种栈式布局方式, 栈式布局的特点就是: 要么从左向右(从右向左), 要么从上到下(从下倒上)的单一行或列排列元素.
 *  栈式布局可以用于应用中列表式显示的ui元素.
 */


#define kStackPanelMaxElement 30

typedef enum _StackPanelArchorType{
    eStackPanelArchorType_LeftTop       = 0x00,
    eStackPanelArchorType_LeftCenter    = 0x01,
    eStackPanelArchorType_LeftBottom    = 0x02,
    eStackPanelArchorType_CenterTop     = 0x03,
    eStackPanelArchorType_CenterCenter  = 0x04,
    eStackPanelArchorType_CenterBottom  = 0x05,
    eStackPanelArchorType_RightTop      = 0x06,
    eStackPanelArchorType_RightCenter   = 0x07,
    eStackPanelArchorType_RightBottom   = 0x08,
    
    eStackPanelArchorType_FillWidth     = 0x100,
    eStackPanelArchorType_FillHeight    = 0x200,
    eStackPanelArchorType_FillAll       = 0x100 | 0x200,
    
    eStackPanelArchorType_Fill          = 0x8000,
    
}StackPanelArchorType;

typedef enum _StackPanelFlowDirector
{
    eStackPanelFlowDirector_LeftToRight,
    eStackPanelFlowDirector_RightToLeft,
    eStackPanelFlowDirector_TopToBottom,
    eStackPanelFlowDirector_BottomToTop,
    
}StackPanelFlowDirector;


@interface StackPanel : UIView
{
    CGRect fillRect;
}

@property (nonatomic, retain, readonly) NSMutableArray *views;
@property (nonatomic, assign) StackPanelArchorType defaultArchorType;
@property (nonatomic, assign) StackPanelFlowDirector flowDirector;
@property (nonatomic, retain) LayoutMargin *defaultMargin;


- (void) addView:(UIView *)element;

- (void) addView:(UIView *)element archor:(StackPanelArchorType)archor;

- (void) addView:(UIView *)element withMargin:(LayoutMargin *)margin;

- (void) addView:(UIView *)element withMargin:(LayoutMargin *)margin archor:(StackPanelArchorType)archor;

- (void)updateLayout;

@end
