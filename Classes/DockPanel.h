//
//  DockPanel.h
//  LayoutPanel
//
//  Created by nekle on 13-9-28.
//  Copyright (c) 2013年 nekle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PanelUtil.h"

#define kDockePanelMaxElements 10

typedef enum _DockSideType {
    DockSideType_Left,
    DockSideType_Right,
    DockSideType_Top,
    DockSideType_Bottom,
    DockSideType_Fill,
}DockSideType;

@interface DockPanel : UIView
{
    int elementCount;
    int dockTypes[kDockePanelMaxElements];
    NSMutableArray *elements;
    NSMutableArray *margins;
    CGRect fillRect;
}

- (void) addView:(UIView*)element withMargin:(LayoutMargin*)margin dock:(DockSideType)dock;

- (void)updateLayout;


@end
