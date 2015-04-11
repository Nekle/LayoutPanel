//
//  TStackPanel.m
//  LayoutPanel
//
//  Created by nekle on 13-10-16.
//  Copyright (c) 2013年 nekle. All rights reserved.
//

#import "StackPanel.h"

@implementation StackPanel

@synthesize views;
@synthesize defaultArchorType;
@synthesize flowDirector;
@synthesize defaultMargin;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
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
    defaultArchorType = eStackPanelArchorType_LeftTop;
    flowDirector = eStackPanelFlowDirector_LeftToRight;
    fillRect = self.frame;
    fillRect.origin = CGPointZero;
    defaultMargin = LayoutMarginZero;
}


-(NSMutableArray *) views
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


- (CGRect) getArchorRectWithSize:(CGRect)frame margin:(LayoutMargin*)margin
{
    CGRect archorRect = CGRectZero;
    
    NSLog(@"before: fillrect  [ (%6.1f,%6.1f) (%6.1f,%6.1f) ]", fillRect.origin.x, fillRect.origin.y, fillRect.size.width, fillRect.size.height);
    NSLog(@"before: frame     [ (%6.1f,%6.1f) (%6.1f,%6.1f) ]", frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);
    
    switch (flowDirector) {
        case eStackPanelFlowDirector_LeftToRight:
            {
                CGFloat minWidth = MIN(fillRect.size.width, GetLayoutWidth(frame, margin));
                archorRect.origin.x = fillRect.origin.x;
                archorRect.origin.y = fillRect.origin.y;
                
                archorRect.size.width  = minWidth;
                archorRect.size.height = fillRect.size.height;
                
                fillRect.origin.x   += minWidth;
                fillRect.size.width -= minWidth;
            }
            break;
        case eStackPanelFlowDirector_RightToLeft:
            {
                CGFloat minWidth = MIN(GetLayoutWidth(frame, margin), fillRect.size.width);
                archorRect.origin.x = fillRect.origin.x + fillRect.size.width - minWidth;
                archorRect.origin.y = fillRect.origin.y;
                
                archorRect.size.width  = minWidth;
                archorRect.size.height = fillRect.size.height;
                
                fillRect.size.width -= minWidth;
            }
            break;
        case eStackPanelFlowDirector_TopToBottom:
            {
                CGFloat minHeight = MIN(fillRect.size.height, GetLayoutHeight(frame, margin));
                archorRect.origin.x = fillRect.origin.x;
                archorRect.origin.y = fillRect.origin.y;
                
                archorRect.size.width  = fillRect.size.width;
                archorRect.size.height = minHeight;
                
                fillRect.origin.y    += minHeight;
                fillRect.size.height -= minHeight;
            }
            break;
        case eStackPanelFlowDirector_BottomToTop:
            {
                CGFloat minHeight = MIN(fillRect.size.height, GetLayoutHeight(frame, margin));
                archorRect.origin.x = fillRect.origin.x;
                archorRect.origin.y = fillRect.origin.y + fillRect.size.height - minHeight;
                
                archorRect.size.width = fillRect.size.width;
                archorRect.size.height = minHeight;
                
                fillRect.size.height -= minHeight;
            }
            break;
        default:
            break;
    }
    NSLog(@"after: fillrect   [ (%6.1f,%6.1f) (%6.1f,%6.1f) ]", fillRect.origin.x, fillRect.origin.y, fillRect.size.width, fillRect.size.height);
    NSLog(@"after: archorrect [ (%6.1f,%6.1f) (%6.1f,%6.1f) ]", archorRect.origin.x, archorRect.origin.y, archorRect.size.width, archorRect.size.height);
    

    return archorRect;
}


- (CGSize) getFillSize:(LayoutMargin*)margin archor:(CGRect)archorRect
{
    CGSize size = CGSizeZero;
    
    switch (flowDirector) {
        case eStackPanelFlowDirector_LeftToRight:
        case eStackPanelFlowDirector_RightToLeft:
            {
                size.height = archorRect.size.height - (margin.top + margin.bottom);
                size.width  = fillRect.size.width + archorRect.size.width -(margin.left + margin.right);
            }
            break;
        case eStackPanelFlowDirector_TopToBottom:
        case eStackPanelFlowDirector_BottomToTop:
            {
                size.height = fillRect.size.height + archorRect.size.height - (margin.top + margin.bottom);
                size.width  = fillRect.size.width - (margin.left + margin.top);
            }
            break;
        default:
            break;
    }

    return size;
}


- (void) updateLayout:(UIView*) view withMargin:(LayoutMargin*) margin archor:(StackPanelArchorType) archor
{
    StackPanelArchorType fill = HighByte(archor);
    
    CGRect frame = view.frame;
    CGRect archorRect = [self getArchorRectWithSize:frame margin:margin];
    
    float width = 0.0;
    if (fill & eStackPanelArchorType_FillWidth) {
        width = archorRect.size.width - (margin.left + margin.right);
        frame.size.width = width < 0?0:width;
    }
    
    float height = 0.0;
    if (fill & eStackPanelArchorType_FillHeight) {
        height = archorRect.size.height - (margin.top + margin.bottom);
        frame.size.height = height < 0? 0: height;
    }
    
    if (fill & eStackPanelArchorType_Fill) {
        /*
        width  = fillRect.size.width - (margin.left + margin.right);
        width = width < 0? 0 : width;
        height = fillRect.size.height - (margin.top + margin.bottom);
        height = width < 0? 0 : height;
        */
        frame.size = [self getFillSize:margin archor:archorRect];//CGSizeMake(width, height);
    }
    
    StackPanelArchorType a = LowByte(archor);
    
    switch (a) {
        case eStackPanelArchorType_LeftTop:
            {
                xPanel_ArchorRect_Left(frame, archorRect, margin);
                yPanel_ArchorRect_Top(frame, archorRect, margin);
            }
            break;
        case eStackPanelArchorType_LeftCenter:
            {
                xPanel_ArchorRect_Left(frame, archorRect, margin);
                yPanel_ArchorRect_Center(frame, archorRect, margin);
            }
            break;
        case eStackPanelArchorType_LeftBottom:
            {
                xPanel_ArchorRect_Left(frame, archorRect, margin);
                yPanel_ArchorRect_Bottom(frame, archorRect, margin);
            }
            break;
        case eStackPanelArchorType_CenterTop:
            {
                xPanel_ArchorRect_Center(frame, archorRect, margin);
                yPanel_ArchorRect_Top(frame, archorRect, margin);
            }
            break;
        case eStackPanelArchorType_CenterCenter:
            {
                xPanel_ArchorRect_Center(frame, archorRect, margin);
                yPanel_ArchorRect_Center(frame, archorRect, margin);
            }
            break;
        case eStackPanelArchorType_CenterBottom:
            {
                xPanel_ArchorRect_Center(frame, archorRect, margin);
                yPanel_ArchorRect_Bottom(frame, archorRect, margin);
            }
            break;
        case eStackPanelArchorType_RightTop:
            {
                xPanel_ArchorRect_Right(frame, archorRect, margin);
                yPanel_ArchorRect_Top(frame, archorRect, margin);
            }
            break;
        case eStackPanelArchorType_RightCenter:
            {
                xPanel_ArchorRect_Right(frame, archorRect, margin);
                yPanel_ArchorRect_Center(frame, archorRect, margin);
            }
            break;
        case eStackPanelArchorType_RightBottom:
            {
                xPanel_ArchorRect_Right(frame, archorRect, margin);
                yPanel_ArchorRect_Bottom(frame, archorRect, margin);
            }
        default:
            break;
    }
    
    view.frame = frame;

}


- (void) addView:(UIView *)element
{

    [self addView:element withMargin:defaultMargin archor:defaultArchorType];
}

- (void) addView:(UIView *)element archor:(StackPanelArchorType)archor
{

    [self addView:element withMargin:defaultMargin archor:archor];
}


- (void) addView:(UIView *)element withMargin:(LayoutMargin *)margin
{
    [self addView:element withMargin:margin archor:defaultArchorType];
}


- (void) addView:(UIView*)element withMargin:(LayoutMargin*)margin archor:(StackPanelArchorType)archor
{
    if ([self.views count] > kStackPanelMaxElement) {
        NSLog(@"Element MAX than kStackPanelMaxElement=%d, you can modify kStackPanelMaxElement to the value you want!", kStackPanelMaxElement);
        return;
    }
    
    LayoutElement *el = [[LayoutElement alloc] init];
    el.view = element;
    el.margin = margin;
    el.eElementArchorType = archor;
    
    [self.views addObject:el];
    [self addSubview:element];
    
    [self updateLayout:element withMargin:margin archor:archor];
}


- (void)updateLayout
{
    for (int i =0 ; i < [self.views count]; i++){
        LayoutElement *el = [self.views objectAtIndex: i ];
        [self updateLayout:el.view withMargin:el.margin archor:el.eElementArchorType];
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    fillRect = self.frame;
    fillRect.origin = CGPointZero;
    [self updateLayout];
}


@end
