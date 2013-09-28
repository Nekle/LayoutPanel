//
//  DockPanel.h
//  LayoutPanel
//
//  Created by nekle on 13-9-28.
//  Copyright (c) 2013年 nekle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StackPanel.h"

#define kDockePanelMaxElements 10

typedef enum _DockSideType {
    DockSideTypeLeft,
    DockSideTypeRight,
    DockSideTypeTop,
    DockSideTypeBottom,
    DockSideTypeFill,
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


@end
