//
//  DockPanel.m
//  LayoutPanel
//
//  Created by nekle on 13-9-28.
//  Copyright (c) 2013年 nekle. All rights reserved.
//

#import "DockPanel.h"

@implementation DockPanel

@synthesize views;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    // Initialization code
    fillRect = self.frame;
    fillRect.origin = CGPointZero;
}

- (NSMutableArray *)views
{
    if (!views) {
        views = [@[] mutableCopy];
    }
    return views;
}


-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    fillRect = frame;
    fillRect.origin = CGPointZero;
}

/*
 * dock left : 最左浮动, 高度自动与dock等高, 宽度不变
 */
-(BOOL)element:(UIView*)element dockLeftWitMargin:(LayoutMargin*)margin
{
    if (fillRect.size.width <= 0) {
        return NO;
    }
    
    CGRect tmpFrame = CGRectZero;
    tmpFrame.origin.x = fillRect.origin.x + margin.left;
    tmpFrame.origin.y = fillRect.origin.y + margin.top;
    tmpFrame.size.width = element.frame.size.width;
    tmpFrame.size.height = fillRect.size.height-margin.bottom - margin.top;
    
    fillRect.origin.x = tmpFrame.origin.x + tmpFrame.size.width + margin.right;
    fillRect.size.width -= element.frame.size.width + margin.right + margin.left;
    
    if (fillRect.size.width < 0) {
        fillRect.size.width = 0;
    }
    
    element.frame = tmpFrame;
    
    return YES;
}


- (BOOL)element:(UIView*)element dockRightWitMargin:(LayoutMargin *)margin
{
    if (fillRect.size.width <= 0) {
        return NO;
    }
    
    CGRect tmpFrame = CGRectZero;
    tmpFrame.origin.x = fillRect.origin.x + fillRect.size.width - margin.right - element.frame.size.width;
    tmpFrame.origin.y = fillRect.origin.y + margin.top;
    tmpFrame.size.width = element.frame.size.width;
    tmpFrame.size.height = fillRect.size.height-margin.bottom - margin.top;
    
    //fillRect.origin.x = tmpFrame.origin.x + tmpFrame.size.width + margin.right;
    fillRect.size.width -= element.frame.size.width +  margin.right + margin.left;
    
    if (fillRect.size.width < 0) {
        fillRect.size.width = 0;
    }
    
    element.frame = tmpFrame;
    
    return YES;
}

- (void)element:(UIView*) view dockTopWitMargin:(LayoutMargin *)margin
{
    CGRect tmpFrame = CGRectZero;
    tmpFrame.origin.x = fillRect.origin.x + margin.left;
    tmpFrame.origin.y = fillRect.origin.y + margin.top;
    tmpFrame.size.width = fillRect.size.width - margin.left - margin.right;
    tmpFrame.size.height = view.frame.size.height;
    
    fillRect.origin.y = tmpFrame.origin.y + tmpFrame.size.height + margin.bottom;
    fillRect.size.height -= view.frame.size.height +  margin.top + margin.bottom;
    
    view.frame = tmpFrame;
}

- (void)element:(UIView*) element dockBottomWitMargin:(LayoutMargin *)margin
{
    
    CGRect tmpFrame = CGRectZero;
    tmpFrame.origin.x = fillRect.origin.x + margin.left;
    tmpFrame.origin.y = fillRect.origin.y + fillRect.size.height -margin.bottom-element.frame.size.height;
    tmpFrame.size.width = fillRect.size.width - margin.left - margin.right;
    tmpFrame.size.height = element.frame.size.height;
    
    //fillRect.origin.y = tmpFrame.origin.y + tmpFrame.size.height + margin.bottom;
    fillRect.size.height -= element.frame.size.height +  margin.top + margin.bottom;
    
    element.frame = tmpFrame;
}

- (void)element:(UIView*) element dockFillWitMargin:(LayoutMargin *)margin
{
    
    CGRect tmpFrame = CGRectZero;
    tmpFrame.origin.x = fillRect.origin.x + margin.left;
    tmpFrame.origin.y = fillRect.origin.y + margin.top;
    tmpFrame.size.width = fillRect.size.width - margin.left - margin.right;
    tmpFrame.size.height = fillRect.size.height - margin.top - margin.bottom;
    
    fillRect = CGRectZero;
    
    element.frame = tmpFrame;
}


-(void)addView:(UIView *)view withMargin:(LayoutMargin *)margin dock:(DockSideType)dock
{
    if ([self.views count] >= kDockePanelMaxElements ) {
        NSLog(@"add error: dock elements more than %d", kDockePanelMaxElements);
        return;
    }
    LayoutElement *el = [[LayoutElement alloc] init];
    el.view = view;
    el.margin = margin;
    el.eElementArchorType = dock;
    
    [self.views addObject:el];
    switch (dock) {
        case eDockSideType_Top:
            [self element:view dockTopWitMargin:margin];
            break;
        case eDockSideType_Left:
            [self element:view dockLeftWitMargin:margin];
            break;
        case eDockSideType_Bottom:
            [self element:view dockBottomWitMargin:margin];
            break;
        case eDockSideType_Right:
            [self element:view dockRightWitMargin:margin];
            break;
        case eDockSideType_Fill:
            [self element:view dockFillWitMargin:margin];
            break;
        default:
            NSLog(@"error dock type %d", dock);
            break;
    }
    [self addSubview:view];
}

- (void)updateLayout
{
    NSUInteger viewCount = [self.views count];
    for (int i=0; i<viewCount; i++) {
        LayoutElement *el = [self.views objectAtIndex:i];
        
        switch (el.eElementArchorType) {
            case eDockSideType_Top:
                [self element:el.view dockTopWitMargin:el.margin];
                break;
            case eDockSideType_Left:
                [self element:el.view dockLeftWitMargin:el.margin];
                break;
            case eDockSideType_Bottom:
                [self element:el.view dockBottomWitMargin:el.margin];
                break;
            case eDockSideType_Right:
                [self element:el.view dockRightWitMargin:el.margin];
                break;
            case eDockSideType_Fill:
                [self element:el.view dockFillWitMargin:el.margin];
                break;
            default:
                NSLog(@"error dock type %d", el.eElementArchorType);
                break;
        }
    }

}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    fillRect = self.frame;
    fillRect.origin = CGPointZero;
    [self updateLayout];
}



@end
