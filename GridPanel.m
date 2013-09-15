//
//  GridPanel.m
//  LayoutPanel
//
//  Created by nekle on 13-9-15.
//  Copyright (c) 2013年 nekle. All rights reserved.
//

#import "GridPanel.h"

@implementation GridPanel
{
    CGSize elementSize;
}

@synthesize rows;
@synthesize columns;
@synthesize elements;
@synthesize gridPanelMap;


-(void)dealloc
{
    [elements release];
     free(gridPanelMap.map);
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        rows = 1;
        columns = 1;
        elementSize = CGSizeMake(frame.size.width, frame.size.height);
        gridPanelMap.map = malloc(rows*columns * sizeof(int));
        memset(gridPanelMap.map, 0, rows*columns*sizeof(int));
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


-(CGPoint)getOriginPointOfRow:(int)row column:(int)column
{
    CGRect frame = self.frame;
    CGPoint origin = CGPointZero;
    origin.x = column / (CGFloat)columns * frame.size.width;
    origin.y = row / (CGFloat)rows * frame.size.height;
    
    gridPanelMap.map = realloc(gridPanelMap.map, rows*columns*sizeof(int));
    
    return  origin;
}

-(void)setRows:(int)rs andColumns:(int)cs
{
    if (rs <= 0 || cs <= 0) {
        NSLog(@"GridPanel row or column can't <= 0!");
        return ;
    }
    rows = rs;
    columns = cs;
    elementSize = CGSizeMake(self.frame.size.width/rows, self.frame.size.height/columns);
}

-(void)addView:(UIView*)element atRow:(int)row column:(int)column
{
    if (row<0 || column<0 || row >=rows || column>=columns ) {
        NSLog(@"row  must in [0, %d) and column must in [0, %d)", rows, columns);
        return;
    }
    
    if (elements) {
        elements = [[NSMutableArray alloc] init];
    }
    
    [elements addObject:element];
    gridPanelMap.map[row][column] = 1;
}


@end
