//
//  DockPanel.m
//  LayoutPanel
//
//  Created by nekle on 13-9-28.
//  Copyright (c) 2013年 nekle. All rights reserved.
//

#import "DockPanel.h"

@implementation DockPanel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        fillRect = frame;
        elementCount = 0;
    }
    return self;
}

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    fillRect = frame;
    
    [ self updateLayout ];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

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

- (BOOL)element:(UIView*) element dockTopWitMargin:(LayoutMargin *)margin
{
    if (fillRect.size.height <= 0) {
        return NO;
    }
    CGRect tmpFrame = CGRectZero;
    tmpFrame.origin.x = fillRect.origin.x + margin.left;
    tmpFrame.origin.y = fillRect.origin.y + margin.top;
    tmpFrame.size.width = fillRect.size.width - margin.left - margin.right;
    tmpFrame.size.height = element.frame.size.height;
    
    fillRect.origin.y = tmpFrame.origin.y + tmpFrame.size.height + margin.bottom;
    fillRect.size.height -= element.frame.size.height +  margin.top + margin.bottom;
    
    if (fillRect.size.height < 0) {
        fillRect.size.height = 0;
    }
    element.frame = tmpFrame;
    return YES;
}

- (BOOL)element:(UIView*) element dockBottomWitMargin:(LayoutMargin *)margin
{
    if (fillRect.size.height <= 0) {
        return NO;
    }
    
    CGRect tmpFrame = CGRectZero;
    tmpFrame.origin.x = fillRect.origin.x + margin.left;
    tmpFrame.origin.y = fillRect.origin.y + fillRect.size.height -margin.bottom-element.frame.size.height;
    tmpFrame.size.width = fillRect.size.width - margin.left - margin.right;
    tmpFrame.size.height = element.frame.size.height;
    
    //fillRect.origin.y = tmpFrame.origin.y + tmpFrame.size.height + margin.bottom;
    fillRect.size.height -= element.frame.size.height +  margin.top + margin.bottom;
    if (fillRect.size.height < 0) {
        fillRect.size.height = 0;
    }
    
    element.frame = tmpFrame;
    
    return YES;
}

- (BOOL)element:(UIView*) element dockFillWitMargin:(LayoutMargin *)margin
{
    if (fillRect.size.width<=0 || fillRect.size.height<=0) {
        return NO;
    }
    
    CGRect tmpFrame = CGRectZero;
    tmpFrame.origin.x = fillRect.origin.x + margin.left;
    tmpFrame.origin.y = fillRect.origin.y + margin.top;
    tmpFrame.size.width = fillRect.size.width - margin.left - margin.right;
    tmpFrame.size.height = fillRect.size.height - margin.top - margin.bottom;
    
    fillRect = CGRectZero;
    
    element.frame = tmpFrame;
    
    return YES;
}



-(void)addView:(UIView *)element withMargin:(LayoutMargin *)margin dock:(DockSideType)dock
{
    if (elementCount >= kDockePanelMaxElements ) {
        NSLog(@"add error: dock elements more than %d", kDockePanelMaxElements);
        return;
    }
    
    if (elements == nil) {
        elements = [[NSMutableArray alloc] init];
    }
    [elements addObject:element];
        
    if (margins == nil) {
        margins = [[NSMutableArray alloc] init];
    }
    [margins addObject:margin];
    dockTypes[elementCount] = dock;
    elementCount += 1;
    BOOL bDocked = NO;
    switch (dock) {
        case DockSideTypeTop:
            bDocked = [self element:element dockTopWitMargin:margin];
            break;
        case DockSideTypeLeft:
            bDocked = [self element:element dockLeftWitMargin:margin];
            break;
        case DockSideTypeBottom:
            bDocked = [self element:element dockBottomWitMargin:margin];
            break;
        case DockSideTypeRight:
            bDocked = [self element:element dockRightWitMargin:margin];
            break;
        case DockSideTypeFill:
            bDocked = [self element:element dockFillWitMargin:margin];
            break;
        default:
            NSLog(@"error dock type %d", dock);
            break;
    }
    if (bDocked) {
        [self addSubview:element];
    }
}

- (void)updateLayout
{
    for (int i=0; i<elementCount; i++) {
        UIView *element = [elements objectAtIndex:i];
        LayoutMargin *margin = [margins objectAtIndex:i];
        DockSideType dock = dockTypes[i];
        
        switch (dock) {
            case DockSideTypeTop:
                [self element:element dockTopWitMargin:margin];
                break;
            case DockSideTypeLeft:
                [self element:element dockLeftWitMargin:margin];
                break;
            case DockSideTypeBottom:
                [self element:element dockBottomWitMargin:margin];
                break;
            case DockSideTypeRight:
                [self element:element dockRightWitMargin:margin];
                break;
            case DockSideTypeFill:
                [self element:element dockFillWitMargin:margin];
                break;
            default:
                NSLog(@"error dock type %d", dock);
                break;
        }
    }

}



@end
