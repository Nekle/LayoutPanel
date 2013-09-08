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

@interface StackPanel : UIView

@property (nonatomic, assign, readonly) CGSize size;
@property (nonatomic, assign, readonly) CGSize currentContentSize;
@property (nonatomic, assign) LayoutFlowDirector flowDirector;
@property (nonatomic, assign) LayoutArchor archor;
@property (nonatomic, retain) NSMutableArray *elements;

- (void)addView:(UIView*)element;




@end
