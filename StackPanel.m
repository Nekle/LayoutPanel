//
//  StackPanel.m
//  LayoutPanel
//
//  Created by nekle on 13-9-7.
//  Copyright (c) 2013年 nekle. All rights reserved.
//

#import "StackPanel.h"

@implementation StackPanel

@synthesize flowDirector;
@synthesize archor;
@synthesize elements;
@synthesize size;
@synthesize currentContentSize;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        size = frame.size;
        currentContentSize = CGSizeZero;
        flowDirector = eLayoutFlowDirectorHorizonal;
        archor = ehLayoutArchorCenterCenter;
        elements = nil;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)setElements:(NSMutableArray *)e
{
    [e retain];
    [self.elements release];
    elements = e;
    [self updateAllLayout];
}

-(void)addView:(UIView *)element
{
    if (self.elements == nil){
        self.elements = [[NSMutableArray alloc] init];
    }
    
    [self.elements addObject:element];
    [self updateLayout:element];
}

-(void)updateLayout:(UIView*)element
{
    //UIView *element = [self.elements objectAtIndex: self.elements.count - 1];
    CGRect frame = element.frame;
    CGSize tmpSize = self.size;
    CGSize tmpCurrentContentSize = self.currentContentSize;
    
    if (self.flowDirector == eLayoutFlowDirectorHorizonal) {
        CGRect tmpFrame = element.frame;
        tmpFrame.origin = CGPointMake(tmpCurrentContentSize.width, 0);
        element.frame = tmpFrame;
        [self addSubview:element];
        
        tmpCurrentContentSize.width += frame.size.width;
        if (frame.size.height > self.currentContentSize.height) {
            tmpCurrentContentSize.height = frame.size.height;
        }
        
    } else if (self.flowDirector == eLayoutFlowDirectorVertical){
        CGRect tmpFrame = element.frame;
        tmpFrame.origin = CGPointMake(0, tmpCurrentContentSize.height);
        element.frame = tmpFrame;
        [self addSubview:element];
        
        tmpCurrentContentSize.height += frame.size.height;
        if (frame.size.width > self.currentContentSize.width) {
            tmpCurrentContentSize.width = frame.size.width;
        }
    }
    
    if (tmpCurrentContentSize.height > tmpSize.height) {
        tmpSize.height = tmpCurrentContentSize.height;
    }
    if (tmpCurrentContentSize.width > tmpSize.width) {
        tmpSize.width = tmpCurrentContentSize.width;
    }
    
    // record current size
    size = tmpSize;
    currentContentSize = tmpCurrentContentSize;
    
    // set to self frame
    frame = self.frame;
    frame.size = tmpSize;
    self.frame = frame;
    
    [self updateAllArchor];
}

- (void) updateAllLayout
{
    NSEnumerator *et =  self.elements.objectEnumerator;
    UIView* element = nil;
    while ( element  = [et nextObject]) {
        [self updateLayout:element];
    }
}

// must call after update layout
- (void) updateAllArchor
{
    NSEnumerator *et =  self.elements.objectEnumerator;
    UIView* element = nil;
    CGSize tmpSize = CGSizeZero;
    while ( element  = [et nextObject]) {
        if (self.flowDirector == eLayoutFlowDirectorHorizonal) {
            switch (self.archor) {
                case ehLayoutArchorLeftCenter:
                    {
                        CGRect frame = element.frame;
                        frame.origin = CGPointMake(tmpSize.width, self.bounds.size.height/2 - frame.size.height/2);
                        element.frame = frame;
                        tmpSize.width += frame.size.width;
                    }
                    break;
                case ehLayoutArchorLeftTop:
                    {
                        CGRect frame = element.frame;
                        frame.origin = CGPointMake(tmpSize.width, 0);
                        element.frame = frame;
                        tmpSize.width += frame.size.width;
                    }
                    break;
                case ehLayoutArchorLeftBottom:
                    {
                        CGRect frame = element.frame;
                        frame.origin = CGPointMake(tmpSize.width, self.bounds.size.height - frame.size.height);
                        element.frame = frame;
                        tmpSize.width += frame.size.width;
                    }
                    break;
                case ehLayoutArchorCenterTop:
                    {
                        CGRect frame = element.frame;
                        frame.origin = CGPointMake(self.bounds.size.width/2-self.currentContentSize.width/2+tmpSize.width, 0);
                        element.frame = frame;
                        tmpSize.width += frame.size.width;
                    }
                    break;
                case ehLayoutArchorCenterCenter:
                    {
                        CGRect frame = element.frame;
                        frame.origin = CGPointMake(self.bounds.size.width/2-self.currentContentSize.width/2 + tmpSize.width, self.bounds.size.height/2-frame.size.height/2);
                        element.frame = frame;
                        tmpSize.width += frame.size.width;
                    }
                    break;
                case ehLayoutArchorCenterBottom:
                    {
                        CGRect frame = element.frame;
                        frame.origin = CGPointMake(self.bounds.size.width/2 - self.currentContentSize.width/2 + tmpSize.width, self.bounds.size.height-frame.size.height);
                        element.frame = frame;
                        tmpSize.width += frame.size.width;
                    }
                    break;
                case ehLayoutArchorRightCenter:
                    {
                        CGRect frame = element.frame;
                        frame.origin = CGPointMake(self.bounds.size.width - self.currentContentSize.width + tmpSize.width, self.bounds.size.height/2 - frame.size.height/2);
                        element.frame = frame;
                        tmpSize.width += frame.size.width;
                        
                    }
                    break;
                case ehLayoutArchorRightTop:
                    {
                        CGRect frame = element.frame;
                        frame.origin = CGPointMake(self.bounds.size.width - self.currentContentSize.width + tmpSize.width, 0);
                        element.frame = frame;
                        tmpSize.width += frame.size.width;
                    }
                    break;
                case ehLayoutArchorRightBottom:
                    {
                        CGRect frame = element.frame;
                        frame.origin = CGPointMake(self.bounds.size.width - self.currentContentSize.width + tmpSize.width, self.bounds.size.height - frame.size.height);
                        element.frame = frame;
                        tmpSize.width += frame.size.width;
                    }
                default:
                    NSLog(@"use error layout archor! goto read the .h file description !!!");
                    break;
            }
        }
        if (self.flowDirector == eLayoutFlowDirectorVertical) {
                switch (self.archor) {
                    case evLayoutArchorTopCenter:
                        {
                            CGRect frame = element.frame;
                            frame.origin = CGPointMake(self.bounds.size.width/2 - frame.size.width/2, tmpSize.height);
                            element.frame = frame;
                            tmpSize.height += frame.size.height;
                        }
                        break;
                    case evLayoutArchorTopLeft:
                        {
                            CGRect frame = element.frame;
                            frame.origin = CGPointMake(0, tmpSize.height);
                            element.frame = frame;
                            tmpSize.height += frame.size.height;
                        }
                        break;
                    case evLayoutArchorTopRight:
                        {
                            CGRect frame = element.frame;
                            frame.origin = CGPointMake(self.bounds.size.width - frame.size.width, tmpSize.height);
                            element.frame = frame;
                            tmpSize.height += frame.size.height;
                        }
                        break;
                    case evLayoutArchorCenterCenter:
                        {
                            CGRect frame = element.frame;
                            frame.origin = CGPointMake(self.bounds.size.width / 2 - frame.size.width / 2, self.bounds.size.height/2 - currentContentSize.height/2 + tmpSize.height);
                            element.frame = frame;
                            tmpSize.height += frame.size.height;
                        }
                        break;
                    case evLayoutArchorCenterLeft:
                        {
                            CGRect frame = element.frame;
                            frame.origin = CGPointMake(0, self.bounds.size.height/2 - currentContentSize.height/2 + tmpSize.height);
                            element.frame = frame;
                            tmpSize.height += frame.size.height;
                        }
                        break;
                    case evLayoutArchorCenterRight:
                        {
                            CGRect frame = element.frame;
                            frame.origin = CGPointMake(self.bounds.size.width - frame.size.width, self.bounds.size.height/2 - currentContentSize.height/2 + tmpSize.height);
                            element.frame = frame;
                            tmpSize.height += frame.size.height;
                        
                        }
                        break;
                    case evLayoutArchorBottomCenter:
                        {
                            CGRect frame = element.frame;
                            frame.origin = CGPointMake(self.bounds.size.width / 2 - frame.size.width / 2, self.bounds.size.height - self.currentContentSize.height + tmpSize.height);
                            element.frame = frame;
                            tmpSize.height += frame.size.height;
                        }
                        break;
                    case evLayoutArchorBottomLeft:
                        {
                            CGRect frame = element.frame;
                            frame.origin = CGPointMake(0, self.bounds.size.height - self.currentContentSize.height + tmpSize.height);
                            element.frame = frame;
                            tmpSize.height += frame.size.height;
                        }
                        break;
                    case evLayoutArchorBottomRight:
                        {
                            CGRect frame = element.frame;
                            frame.origin = CGPointMake(self.bounds.size.width - frame.size.width , self.bounds.size.height - self.currentContentSize.height + tmpSize.height);
                            element.frame = frame;
                            tmpSize.height += frame.size.height;
                        }
                        break;
                    default:
                        NSLog(@"use error layout archor! goto read the .h file description !!!");
                        break;
                }
        }
    }
}





@end
