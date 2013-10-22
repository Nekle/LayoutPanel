//
//  TStackPanel.m
//  LayoutPanel
//
//  Created by nekle on 13-10-16.
//  Copyright (c) 2013年 nekle. All rights reserved.
//

#import "StackPanel.h"

@implementation StackPanel

@synthesize elements;
@synthesize margins;
@synthesize defaultArchorType;
@synthesize flowDirector;
@synthesize defaultMargin;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        elementCount = 0;
        defaultArchorType = eStackPanelArchorType_LeftTop;
        flowDirector = eStackPanelFlowDirector_LeftToRight;
        fillRect = frame;
        fillRect.origin = CGPointZero;
        defaultMargin = LayoutZero;
    }
    return self;
}

-(void)dealloc
{
    [elements release];
    [margins release];
    [defaultMargin release];
    
    [super dealloc];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    fillRect = frame;
    fillRect.origin = CGPointZero;
    
    [self updateLayout];
}


- (CGRect) getArchorRectWithSize:(CGRect)frame margin:(LayoutMargin*)margin
{
    CGRect archorRect = CGRectZero;
    
    NSLog(@"before: fillrect  [ (%6.1f,%6.1f) (%6.1f,%6.1f) ]", fillRect.origin.x, fillRect.origin.y, fillRect.size.width, fillRect.size.height);
    NSLog(@"before: frame     [ (%6.1f,%6.1f) (%6.1f,%6.1f) ]", frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);
    
    switch (flowDirector) {
        case eStackPanelFlowDirector_LeftToRight:
            {
                archorRect.origin.x = fillRect.origin.x;
                archorRect.origin.y = fillRect.origin.y;
                
                archorRect.size.width  = MIN(fillRect.size.width, GetLayoutWidth(frame, margin));
                archorRect.size.height = fillRect.size.height;
                
                fillRect.origin.x   += MIN(fillRect.size.width, GetLayoutWidth(frame, margin));
                fillRect.size.width -= MIN(fillRect.size.width, GetLayoutWidth(frame, margin));
            }
            break;
        case eStackPanelFlowDirector_RightToLeft:
            {
                archorRect.origin.x = fillRect.origin.x + fillRect.size.width - MIN(GetLayoutWidth(frame, margin), fillRect.size.width);
                archorRect.origin.y = fillRect.origin.y;
                
                archorRect.size.width  = MIN(fillRect.size.width, GetLayoutWidth(frame, margin));
                archorRect.size.height = fillRect.size.height;
                
                fillRect.size.width -= MIN(fillRect.size.width, GetLayoutWidth(frame, margin));
                
            }
            break;
        case eStackPanelFlowDirector_TopToBottom:
            {
                archorRect.origin.x = fillRect.origin.x;
                archorRect.origin.y = fillRect.origin.y;
                
                archorRect.size.width  = fillRect.size.width;
                archorRect.size.height = MIN(fillRect.size.height, GetLayoutHeight(frame, margin));
                
                fillRect.origin.y    += MIN(fillRect.size.height, GetLayoutHeight(frame, margin));
                fillRect.size.height -= MIN(fillRect.size.height, GetLayoutHeight(frame, margin));
            }
            break;
        case eStackPanelFlowDirector_BottomToTop:
            {
                archorRect.origin.x = fillRect.origin.x;
                archorRect.origin.y = fillRect.origin.y + fillRect.size.height - MIN(fillRect.size.height, GetLayoutHeight(frame, margin));
                
                archorRect.size.width = fillRect.size.width;
                archorRect.size.height = MIN(fillRect.size.height, GetLayoutHeight(frame, margin));
                
                fillRect.size.height -= MIN(fillRect.size.height, GetLayoutHeight(frame, margin));
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
                size.width  = fillRect.size.width + archorRect.size.width -(margin.left+margin.right);
            }
            break;
        case eStackPanelFlowDirector_TopToBottom:
        case eStackPanelFlowDirector_BottomToTop:
            {
                size.height = fillRect.size.height + archorRect.size.height - (margin.top+margin.bottom);
                size.width  = fillRect.size.width - (margin.left+margin.top);
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
    if (elementCount+1 > kStackPanelMaxElement) {
        
        NSLog(@"Element MAX than kStackPanelMaxElement=%d, you can modify kStackPanelMaxElement the value you want!", kStackPanelMaxElement);
        return;
    }
    
    if (elements == nil) {
        elements = [[NSMutableArray alloc] init];
    }
    [elements addObject:element];
    [self addSubview:element];
    
    if (margins == nil) {
        margins = [[NSMutableArray alloc] init];
    }
    [margins addObject:margin];
    
    elementArchorTypes[elementCount] = archor;
    elementCount += 1;
    
    [self updateLayout:element withMargin:margin archor:archor];
}


- (void)updateLayout
{
    for (int i =0 ; i < elementCount; i++){
        UIView * view = [elements objectAtIndex: i ];
        LayoutMargin * margin = [margins objectAtIndex:i];
        StackPanelArchorType archor = elementArchorTypes[i];
        [self updateLayout:view withMargin:margin archor:archor];
    }
}


@end
