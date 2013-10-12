//
//  GridPanel.m
//  LayoutPanel
//
//  Created by nekle on 13-9-15.
//  Copyright (c) 2013年 nekle. All rights reserved.
//

#import "GridPanel.h"

@implementation CRect
@synthesize size;
@synthesize origin;
-(NSString *)description
{
    return [NSString stringWithFormat:@"[x=%6.2f, y=%6.2f, w=%6.2f, h=%6.2f]", origin.x, origin.y, size.width, size.height];
}
- (CGRect)getCGRect
{
    return CGRectMake(origin.x, origin.y, size.width, size.height);
}
@end

CRect * CRectMake(float x, float y, float width, float height)
{
    CRect * rect = [[[CRect alloc] init] autorelease];
    CGPoint origin = CGPointMake(x, y);
    CGSize size = CGSizeMake(width, height);
    rect.size = size;
    rect.origin = origin;
    
    return rect;
}


@implementation GridPanel
{
    
}

@synthesize elements;


-(void)dealloc
{
    [elements release];
    [archorRects release];
    [rowHeightDefines release];
    [columnWidthDefines release];
    [margins release];
    
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
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


-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    [self updateLayout];
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
    
    if (archorRects == nil) {
        archorRects = [[NSMutableArray alloc] init];
    } else {
        [archorRects removeAllObjects];
    }
    
    for (int i = 0; i < rowHeightDefines.count; i++) {

        NSString *row = [rowHeightDefines objectAtIndex:i];
        float height = [self str:row valueOf:self.frame.size.height];
        
        origin.x = 0;
        for (int j = 0; j < columnWidthDefines.count; j++) {
            NSString *column = [columnWidthDefines objectAtIndex:j];
            float width = [self str:column valueOf:self.frame.size.width];
            [archorRects addObject: CRectMake(origin.x, origin.y, width, height)];
            origin.x += width;
        }
        
        origin.y += height;
    }
}

- (void) setRows:(NSMutableArray*)rs andColumn:(NSMutableArray*)cs
{
    if (rs.count * cs.count > kGridPanelMaxElements) {
        NSLog(@"element max then [ kGridPanelMaxElements = %d], you can modify kGridPanelMaxElements define to satisfy you need", kGridPanelMaxElements);
        return;
    }
    
    [rs retain];
    [rowHeightDefines release];
    rowHeightDefines = rs;
    
    [cs retain];
    [columnWidthDefines release];
    columnWidthDefines = cs;
    
    [self updateArchorRect];
}


-(CGRect)getArchorRectOfRow:(int)row column:(int)column
{
    if (row >= rowHeightDefines.count || column >= columnWidthDefines.count ) {
        NSLog(@"error row or column [%d, %d]", row, column);
        return CGRectMake(0, 0, 0, 0);
    }
    int idx = column + row * columnWidthDefines.count;
    
    if (idx >= archorRects.count)
    {
        NSLog(@"error row or column [%d, %d]", row, column);
        return CGRectMake(0, 0, 0, 0);
    }
    
    CRect *r = archorRects[idx];
        
    return  [r getCGRect];
}

//- (void)layout:(CGRect*)frame leftOf



- (void)layout:(UIView*)element in:(CGRect)archorRect withMargin:(LayoutMargin*)margin andArchor:(GridLayoutArchor) archor
{
    
    GridLayoutArchor fill = HighByte(archor);
    if (fill & eLayoutFillWidth) {
        CGRect frame = element.frame;
        float width = archorRect.size.width - (margin.left + margin.right);
        frame.size.width = width < 0?0:width;
        element.frame = frame;
    }
    
    if (fill & eLayoutFillHeight) {
        CGRect frame = element.frame;
        float height = archorRect.size.height - (margin.top + margin.bottom);
        frame.size.height = height < 0? 0: height;
        element.frame = frame;
    }
    
    GridLayoutArchor layout = LowByte(archor);
    
    switch (layout) {
        case eLayoutLeftTop:
            {
                CGRect frame = element.frame;
                frame.origin.x = archorRect.origin.x + margin.left;
                frame.origin.y = archorRect.origin.y + margin.top;
                element.frame = frame;
            }
            break;
        case eLayoutLeftCenter:
            {
                CGRect frame = element.frame;
                frame.origin.x = archorRect.origin.x + margin.left;
                frame.origin.y = archorRect.origin.y + archorRect.size.height/2 - frame.size.height/2;
                element.frame = frame;
            }
            break;
        case eLayoutLeftBottom:
            {
                CGRect frame = element.frame;
                frame.origin.x = archorRect.origin.x + margin.left;
                frame.origin.y = archorRect.origin.y + archorRect.size.height - (frame.size.height + margin.bottom);
                element.frame = frame;
            }
            break;
        case eLayoutCenterTop:
            {
                CGRect frame = element.frame;
                frame.origin.x = archorRect.origin.x + archorRect.size.width/2 - frame.size.width/2;
                frame.origin.y = archorRect.origin.y + margin.top;
                element.frame = frame;
            }
            break;
        case eLayoutCenterCenter:
            {
                CGRect frame = element.frame;
                frame.origin.x = archorRect.origin.x + archorRect.size.width/2 - frame.size.width/2;
                frame.origin.y = archorRect.origin.y + archorRect.size.height/2 - frame.size.height/2;
                element.frame = frame;
            }
            break;
        case eLayoutCenterBottom:
            {
                CGRect frame = element.frame;
                frame.origin.x = archorRect.origin.x + archorRect.size.width/2 - frame.size.width/2;
                frame.origin.y = archorRect.origin.y + archorRect.size.height - (frame.size.height + margin.bottom);
                element.frame = frame;
            }
            break;
        case eLayoutRightTop:
            {
                CGRect frame = element.frame;
                frame.origin.x = archorRect.origin.x + archorRect.size.width - (frame.size.width + margin.right);
                frame.origin.y = archorRect.origin.y + margin.top;
                element.frame = frame;
            }
            break;
        case eLayoutRightCenter:
            {
                CGRect frame = element.frame;
                frame.origin.x = archorRect.origin.x + archorRect.size.width - (frame.size.width + margin.right);
                frame.origin.y = archorRect.origin.y + archorRect.size.height/2 - frame.size.height/2;
                element.frame = frame;
            }
            break;
        case eLayoutRightBottom:
            {
                CGRect frame = element.frame;
                frame.origin.x = archorRect.origin.x + archorRect.size.width - (frame.size.width + margin.right);
                frame.origin.y = archorRect.origin.y + archorRect.size.height - (frame.size.height + margin.bottom);
                element.frame = frame;
            }
            break;
        default:
            break;
    }

}

-(void)addView:(UIView*)element atRow:(int)row andColumn:(int)column withMargin:(LayoutMargin *)margin archor:(GridLayoutArchor)archor
{
    if (row >= rowHeightDefines.count || column >= columnWidthDefines.count) {
        NSLog(@"row or column error!");
        return;
    }
    
    // element
    if (elements == nil) {
        elements = [[NSMutableArray alloc] init];
    }
    [elements addObject:element];
    
    // margin
    if (margins == nil) {
        margins = [[NSMutableArray alloc] init];
    }
    [margins addObject:margin];
    
    // layoutType
    elementLayoutTypes[elements.count - 1] = archor;
    
    [self addSubview:element];
    //CGRect frame = element.frame;
    
    CGRect archorRect = [self getArchorRectOfRow:row column:column];
    
    [self layout:element in:archorRect withMargin:margin andArchor:archor];
}

- (void)updateLayout
{
    [self updateArchorRect];
    
    for (int i =0 ; i < rowHeightDefines.count; i++){
        for (int j = 0; j < columnWidthDefines.count; j++) {
            CGRect archorRect = [self getArchorRectOfRow:i column:j];
            int idx = i*columnWidthDefines.count+j;
            UIView * view = [elements objectAtIndex: idx ];
            LayoutMargin * margin = [margins objectAtIndex:idx];
            GridLayoutArchor archor = elementLayoutTypes [idx];
            [self layout:view in:archorRect withMargin: margin andArchor:archor];
        }
    }
}



@end
