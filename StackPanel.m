//
//  StackPanel.m
//  LayoutPanel
//
//  Created by nekle on 13-9-7.
//  Copyright (c) 2013年 nekle. All rights reserved.
//

#import "StackPanel.h"


@implementation LayoutMargin
@synthesize top;
@synthesize left;
@synthesize bottom;
@synthesize right;
-(NSString *)description
{
    return [NSString stringWithFormat:@"[%.1f, %.1f, %.1f, %.1f]", top, left, bottom, right];
}
@end

LayoutMargin* LayoutMarginMake(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right)
{
    LayoutMargin *margin = [[[LayoutMargin alloc] init] autorelease];
    margin.top = top;
    margin.left = left;
    margin.bottom = bottom;
    margin.right = right;
    return margin;
}

static CGFloat GetLayoutWidth(CGRect frame, LayoutMargin *margin)
{
    return (frame.size.width + margin.left + margin.right);
}

static CGFloat GetLayoutHeight(CGRect frame, LayoutMargin *margin)
{
    return (frame.size.height + margin.top + margin.bottom);
}

@implementation StackPanel

@synthesize flowDirector;
@synthesize archor;
@synthesize elements;
@synthesize margins;
@synthesize size;
@synthesize currentContentSize;


-(void)dealloc
{
    [elements release];
    [margins release];
    [super dealloc];
}

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
    [self addView:element withMargin:LayoutZero];
}

- (void)addView:(UIView *)element withMargin:(LayoutMargin*) margin
{
    if (self.elements == nil){
        self.elements = [[NSMutableArray alloc] init];
    }
    if (self.margins == nil) {
        self.margins = [[NSMutableArray alloc] init];
    }
    
    [self.elements addObject:element];
    [self.margins addObject:margin];
    [self updateLayout:element andMargin:margin];
    
}


-(void)updateLayout:(UIView*)element andMargin:(LayoutMargin*) margin
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
        
        tmpCurrentContentSize.width += GetLayoutWidth(frame, margin);
        if (GetLayoutHeight(frame, margin) > self.currentContentSize.height) {
            tmpCurrentContentSize.height = GetLayoutHeight(frame, margin);
        }
        
    } else if (self.flowDirector == eLayoutFlowDirectorVertical){
        CGRect tmpFrame = element.frame;
        tmpFrame.origin = CGPointMake(0, tmpCurrentContentSize.height);
        element.frame = tmpFrame;
        [self addSubview:element];
        
        tmpCurrentContentSize.height += GetLayoutHeight(frame, margin);
        if (GetLayoutWidth(frame, margin) > self.currentContentSize.width) {
            tmpCurrentContentSize.width = GetLayoutWidth(frame, margin);
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
    NSEnumerator *mt = self.margins.objectEnumerator;
    UIView* element = nil;
    LayoutMargin *margin = nil;
    while ( (element  = [et nextObject]) &&  (margin = [mt nextObject])) {
        [self updateLayout:element andMargin:margin];
    }
}

// must call after update layout
- (void) updateAllArchor
{
    NSEnumerator *et =  self.elements.objectEnumerator;
    NSEnumerator *mt = self.margins.objectEnumerator;
    
    UIView* element = nil;
    LayoutMargin *margin = nil;
    CGSize tmpSize = CGSizeZero;
    while ( (element = [et nextObject]) && (margin = [mt nextObject])) {
        if (self.flowDirector == eLayoutFlowDirectorHorizonal) {
            switch (self.archor) {
                case ehLayoutArchorLeftCenter:
                    {
                        CGRect frame = element.frame;
                        frame.origin = CGPointMake(tmpSize.width+margin.left, self.bounds.size.height/2 - frame.size.height/2);
                        element.frame = frame;
                        tmpSize.width += GetLayoutWidth(frame, margin);
                    }
                    break;
                case ehLayoutArchorLeftTop:
                    {
                        CGRect frame = element.frame;
                        frame.origin = CGPointMake(tmpSize.width+margin.left, 0+margin.top);
                        element.frame = frame;
                        tmpSize.width += GetLayoutWidth(frame, margin);
                    }
                    break;
                case ehLayoutArchorLeftBottom:
                    {
                        CGRect frame = element.frame;
                        frame.origin = CGPointMake(tmpSize.width+margin.left, self.bounds.size.height - GetLayoutHeight(frame, margin) + margin.top);
                        element.frame = frame;
                        tmpSize.width += GetLayoutWidth(frame, margin);
                    }
                    break;
                case ehLayoutArchorCenterTop:
                    {
                        CGRect frame = element.frame;
                        frame.origin = CGPointMake(self.bounds.size.width/2-self.currentContentSize.width/2+tmpSize.width + margin.left, 0 + margin.top);
                        element.frame = frame;
                        tmpSize.width += GetLayoutWidth(frame, margin);
                    }
                    break;
                case ehLayoutArchorCenterCenter:
                    {
                        CGRect frame = element.frame;
                        frame.origin = CGPointMake(self.bounds.size.width/2-self.currentContentSize.width/2 + tmpSize.width + margin.left, self.bounds.size.height/2-frame.size.height/2);
                        element.frame = frame;
                        tmpSize.width += GetLayoutWidth(frame, margin);
                    }
                    break;
                case ehLayoutArchorCenterBottom:
                    {
                        CGRect frame = element.frame;
                        frame.origin = CGPointMake(self.bounds.size.width/2 - self.currentContentSize.width/2 + tmpSize.width + margin.left, self.bounds.size.height-GetLayoutHeight(frame, margin)+margin.top);
                        element.frame = frame;
                        tmpSize.width += GetLayoutWidth(frame, margin);
                    }
                    break;
                case ehLayoutArchorRightCenter:
                    {
                        CGRect frame = element.frame;
                        frame.origin = CGPointMake(self.bounds.size.width - self.currentContentSize.width + tmpSize.width + margin.left, self.bounds.size.height/2 - frame.size.height/2);
                        element.frame = frame;
                        tmpSize.width += GetLayoutWidth(frame, margin);
                    }
                    break;
                case ehLayoutArchorRightTop:
                    {
                        CGRect frame = element.frame;
                        frame.origin = CGPointMake(self.bounds.size.width - self.currentContentSize.width + tmpSize.width + margin.left, 0 + margin.top);
                        element.frame = frame;
                        tmpSize.width += GetLayoutWidth(frame, margin);
                    }
                    break;
                case ehLayoutArchorRightBottom:
                    {
                        CGRect frame = element.frame;
                        frame.origin = CGPointMake(self.bounds.size.width - self.currentContentSize.width + tmpSize.width+margin.left, self.bounds.size.height - GetLayoutHeight(frame, margin) + margin.top);
                        element.frame = frame;
                        tmpSize.width += GetLayoutWidth(frame, margin);
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
                            frame.origin = CGPointMake(self.bounds.size.width/2 - frame.size.width/2, tmpSize.height + margin.top);
                            element.frame = frame;
                            tmpSize.height += GetLayoutHeight(frame, margin);
                        }
                        break;
                    case evLayoutArchorTopLeft:
                        {
                            CGRect frame = element.frame;
                            frame.origin = CGPointMake(0 + margin.left, tmpSize.height + margin.top);
                            element.frame = frame;
                            tmpSize.height += GetLayoutHeight(frame, margin);
                        }
                        break;
                    case evLayoutArchorTopRight:
                        {
                            CGRect frame = element.frame;
                            frame.origin = CGPointMake(self.bounds.size.width - GetLayoutWidth(frame, margin) + margin.left, tmpSize.height + margin.top);
                            element.frame = frame;
                            tmpSize.height += GetLayoutHeight(frame, margin);
                        }
                        break;
                    case evLayoutArchorCenterCenter:
                        {
                            CGRect frame = element.frame;
                            frame.origin = CGPointMake(self.bounds.size.width / 2 - frame.size.width / 2, self.bounds.size.height/2 - currentContentSize.height/2 + tmpSize.height+margin.top);
                            element.frame = frame;
                            tmpSize.height += GetLayoutHeight(frame, margin);
                        }
                        break;
                    case evLayoutArchorCenterLeft:
                        {
                            CGRect frame = element.frame;
                            frame.origin = CGPointMake(0 + margin.left, self.bounds.size.height/2 - currentContentSize.height/2 + tmpSize.height + margin.top);
                            element.frame = frame;
                            tmpSize.height += GetLayoutHeight(frame, margin);
                        }
                        break;
                    case evLayoutArchorCenterRight:
                        {
                            CGRect frame = element.frame;
                            frame.origin = CGPointMake(self.bounds.size.width - GetLayoutWidth(frame, margin)+margin.left, self.bounds.size.height/2 - currentContentSize.height/2 + tmpSize.height + margin.top);
                            element.frame = frame;
                            tmpSize.height += GetLayoutHeight(frame, margin);
                        
                        }
                        break;
                    case evLayoutArchorBottomCenter:
                        {
                            CGRect frame = element.frame;
                            frame.origin = CGPointMake(self.bounds.size.width / 2 - frame.size.width/ 2, self.bounds.size.height - self.currentContentSize.height + tmpSize.height + margin.top);
                            element.frame = frame;
                            tmpSize.height += GetLayoutHeight(frame, margin);
                        }
                        break;
                    case evLayoutArchorBottomLeft:
                        {
                            CGRect frame = element.frame;
                            frame.origin = CGPointMake(0 + margin.left, self.bounds.size.height - self.currentContentSize.height + tmpSize.height + margin.top);
                            element.frame = frame;
                            tmpSize.height += GetLayoutHeight(frame, margin);
                        }
                        break;
                    case evLayoutArchorBottomRight:
                        {
                            CGRect frame = element.frame;
                            frame.origin = CGPointMake(self.bounds.size.width - GetLayoutWidth(frame, margin) + margin.left, self.bounds.size.height - self.currentContentSize.height + tmpSize.height + margin.top);
                            element.frame = frame;
                            tmpSize.height += GetLayoutHeight(frame, margin);
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
