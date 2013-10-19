//
//  GridPanel.h
//  LayoutPanel
//
//  Created by nekle on 13-9-15.
//  Copyright (c) 2013年 nekle. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PanelUtil.h"

/*
 * 九宫格 布局方式
 */

typedef enum _GridPanelArchorType
{
    eGridPanelArchorType_LeftTop        = 0x00,
    eGridPanelArchorType_LeftCenter     = 0x01,
    eGridPanelArchorType_LeftBottom     = 0x02,
    eGridPanelArchorType_CenterTop      = 0x03,
    eGridPanelArchorType_CenterCenter   = 0x04,
    eGridPanelArchorType_CenterBottom   = 0x05,
    eGridPanelArchorType_RightTop       = 0x06,
    eGridPanelArchorType_RightCenter    = 0x07,
    eGridPanelArchorType_RightBottom    = 0x08,
    
    eGridPanelArchorType_FillWidth      = 0x100,
    eGridPanelArchorType_FillHeight     = 0x200,
    eGridPanelArchorType_FillAll        = 0x100 | 0x200,
    
} GridPanelArchorType;

@interface CRect : NSObject

@property (nonatomic, assign)    CGPoint origin;
@property (nonatomic, assign)    CGSize size;

- (NSString*) description;
- (CGRect) getCGRect;

@end



CRect* CRectMake(float x, float y, float width, float height) ;
#define CRectZero CRectMake(0, 0, 0, 0)


#define kGridPanelMaxElements 20

@interface GridPanel : UIView
{
    int elementLayoutTypes[kGridPanelMaxElements];
}

@property (nonatomic, retain, readonly) NSMutableArray *elements;
@property (nonatomic, retain, readonly) NSMutableArray *rowHeightDefines;
@property (nonatomic, retain, readonly) NSMutableArray * columnWidthDefines;
@property (nonatomic, retain, readonly) NSMutableArray * archorRects;
@property (nonatomic, retain, readonly) NSMutableArray * margins;
@property (nonatomic, assign) GridPanelArchorType defaultArchorType;
@property (nonatomic, retain) LayoutMargin *defaultMargin;


- (void) setRows:(NSMutableArray *)rs andColumn:(NSMutableArray *)cs;

-(void)addView:(UIView *)element atRow:(int)row andColumn:(int)column;

-(void)addView:(UIView *)element atRow:(int)row andColumn:(int)column archor:(GridPanelArchorType)archor;

-(void)addView:(UIView *)element atRow:(int)row andColumn:(int)column withMargin:(LayoutMargin *)margin;

- (void)addView:(UIView *)element atRow:(int)row andColumn:(int)column withMargin:(LayoutMargin*)margin archor:(GridPanelArchorType) archor;

- (void)updateLayout;
@end
