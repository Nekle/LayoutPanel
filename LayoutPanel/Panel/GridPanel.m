//
//  GridPanel.m
//  LayoutPanel
//
//  Created by nekle on 13-9-15.
//  Copyright (c) 2013年 nekle. All rights reserved.
//

#import "GridPanel.h"

@implementation NSRect
@synthesize size;
@synthesize origin;
-(NSString *)description
{
    return [NSString stringWithFormat:@"[x=%6.2f, y=%6.2f, w=%6.2f, h=%6.2f]", origin.x, origin.y, size.width, size.height];
}

@end

NSRect * NSRectMake(float x, float y, float width, float height)
{
    NSRect * rect = [[NSRect alloc] init];
    CGPoint origin = CGPointMake(x, y);
    CGSize size = CGSizeMake(width, height);
    rect.size = size;
    rect.origin = origin;
    
    return rect;
}


@implementation GridPanel

@synthesize views;
@synthesize archorRects;
@synthesize rowHeightDefines;
@synthesize columnWidthDefines;
@synthesize defaultArchorType;
@synthesize defaultMargin;


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
    defaultMargin = LayoutMarginZero;
    defaultArchorType = eGridPanelArchorType_LeftTop;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [self updateArchorRect];
}

-(NSMutableArray *)views
{
    if (!views) {
        views = [@[] mutableCopy];
    }
    return views;
}

-(NSMutableArray *)archorRects
{
    if (!archorRects) {
        archorRects = [@[] mutableCopy];
    }
    return archorRects;
}

-(NSArray *)rowHeightDefines
{
    if (!rowHeightDefines) {
        rowHeightDefines = [@[] copy];
    }
    return rowHeightDefines;
}

-(NSArray *)columnWidthDefines
{
    if (!columnWidthDefines) {
        columnWidthDefines = [@[] copy];
    }
    return columnWidthDefines;
}


// ["12%", "12"]

- (float) str:(NSString*) str valueOf:(float) total
{
    float length = [str floatValue];
    if ([str hasSuffix:@"%"]) {
        length = length / 100 * total;
    }
    
    return length;
}

- (void) updateArchorRect
{
    CGPoint origin = CGPointMake(0, 0);
    [self.archorRects removeAllObjects];
    
    for (int i = 0; i < self.rowHeightDefines.count; i++) {

        NSString *row = [self.rowHeightDefines objectAtIndex:i];
        float height = [self str:row valueOf:self.frame.size.height];
        
        origin.x = 0;
        for (int j = 0; j < self.columnWidthDefines.count; j++) {
            NSString *column = [self.columnWidthDefines objectAtIndex:j];
            float width = [self str:column valueOf:self.frame.size.width];
            [archorRects addObject: NSRectMake(origin.x, origin.y, width, height)];
            origin.x += width;
        }
        
        origin.y += height;
    }
}

- (void) setRows:(NSArray *)rs andColumn:(NSArray *)cs
{
    if (rs.count * cs.count > kGridPanelMaxElements) {
        NSLog(@"element max then [ kGridPanelMaxElements = %d], you can modify kGridPanelMaxElements define to satisfy you need", kGridPanelMaxElements);
        return;
    }
    
    rowHeightDefines = [rs copy];
    columnWidthDefines = [cs copy];
    
    [self updateArchorRect];
}


-(CGRect)getArchorRectOfRow:(int)row column:(int)column
{
    unsigned long idx = column + row * [self.columnWidthDefines count];
    NSRect *r = archorRects[idx];
    return  CGRectMake(r.origin.x, r.origin.y, r.size.width, r.size.height);
}


- (void)layout:(UIView*)view inRect:(CGRect)archorRect withMargin:(LayoutMargin*)margin andArchor:(GridPanelArchorType) archor
{
    
    GridPanelArchorType fill = HighByte(archor);
    if (fill & eGridPanelArchorType_FillWidth) {
        CGRect frame = view.frame;
        float width = archorRect.size.width - (margin.left + margin.right);
        frame.size.width = width < 0? 0 : width;
        view.frame = frame;
    }
    
    if (fill & eGridPanelArchorType_FillHeight) {
        CGRect frame = view.frame;
        float height = archorRect.size.height - (margin.top + margin.bottom);
        frame.size.height = height < 0? 0 : height;
        view.frame = frame;
    }
    
    GridPanelArchorType layout = LowByte(archor);
    CGRect frame = view.frame;
    
    switch (layout) {
        case eGridPanelArchorType_LeftTop:
            {
                xPanel_ArchorRect_Left(frame, archorRect, margin);
                yPanel_ArchorRect_Top(frame, archorRect, margin);
            }
            break;
        case eGridPanelArchorType_LeftCenter:
            {
                xPanel_ArchorRect_Left(frame, archorRect, margin);
                yPanel_ArchorRect_Center(frame, archorRect, margin);
            }
            break;
        case eGridPanelArchorType_LeftBottom:
            {
                xPanel_ArchorRect_Left(frame, archorRect, margin);
                yPanel_ArchorRect_Bottom(frame, archorRect, margin);
            }
            break;
        case eGridPanelArchorType_CenterTop:
            {
                xPanel_ArchorRect_Center(frame, archorRect, margin);
                yPanel_ArchorRect_Top(frame, archorRect, margin);
            }
            break;
        case eGridPanelArchorType_CenterCenter:
            {
                xPanel_ArchorRect_Center(frame, archorRect, margin);
                yPanel_ArchorRect_Center(frame, archorRect, margin);
            }
            break;
        case eGridPanelArchorType_CenterBottom:
            {
                xPanel_ArchorRect_Center(frame, archorRect, margin);
                yPanel_ArchorRect_Bottom(frame, archorRect, margin);
            }
            break;
        case eGridPanelArchorType_RightTop:
            {
                xPanel_ArchorRect_Right(frame, archorRect, margin);
                yPanel_ArchorRect_Top(frame, archorRect, margin);
            }
            break;
        case eGridPanelArchorType_RightCenter:
            {
                xPanel_ArchorRect_Right(frame, archorRect, margin);
                yPanel_ArchorRect_Center(frame, archorRect, margin);
            }
            break;
        case eGridPanelArchorType_RightBottom:
            {
                xPanel_ArchorRect_Right(frame, archorRect, margin);
                yPanel_ArchorRect_Bottom(frame, archorRect, margin);
            }
            break;
        default:
            break;
    }
    
    view.frame = frame;

}

-(void)addView:(UIView*)element atRow:(int)row andColumn:(int)column
{
    [self addView:element atRow:row andColumn:column withMargin:defaultMargin archor:defaultArchorType];
}

-(void)addView:(UIView*)element atRow:(int)row andColumn:(int)column archor:(GridPanelArchorType)archor
{
    [self addView:element atRow:row andColumn:column withMargin:defaultMargin archor:archor];
}


-(void)addView:(UIView*)element atRow:(int)row andColumn:(int)column withMargin:(LayoutMargin *)margin
{
    [self addView:element atRow:row andColumn:column withMargin:margin archor:defaultArchorType];
}

-(void)addView:(UIView*)element atRow:(int)row andColumn:(int)column withMargin:(LayoutMargin *)margin archor:(GridPanelArchorType)archor
{
    if (row >= [self.rowHeightDefines count] || column >= [self.columnWidthDefines count]) {
        NSLog(@"row or column error!");
        return;
    }
    
    // element
    LayoutElement *el = [[LayoutElement alloc] init];
    el.view = element;
    el.margin = margin;
    el.eElementArchorType = archor;
    el.row = row;
    el.column = column;
    
    [self.views addObject:el];
    
    CGRect archorRect = [self getArchorRectOfRow:row column:column];
    
    [self layout:element inRect:archorRect withMargin:margin andArchor:archor];
     
    [self addSubview:element];

}


- (void)updateLayout
{
    
    NSUInteger viewCount = [self.views count];
    
    for (int i = 0; i<viewCount; i++) {
        LayoutElement *el = [self.views objectAtIndex: i];
        CGRect archorRect = [self getArchorRectOfRow:el.row column:el.column];
        [self layout:el.view inRect:archorRect withMargin: el.margin andArchor:el.eElementArchorType];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self updateArchorRect];
    [self updateLayout];
}



@end
