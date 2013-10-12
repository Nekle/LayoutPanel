//
//  GridPanel.h
//  LayoutPanel
//
//  Created by nekle on 13-9-15.
//  Copyright (c) 2013年 nekle. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "StackPanel.h"

/*
 * 九宫格 布局方式
 */

#define HighByte(t) ((t)&0xFF00)
#define LowByte(t) ((t)&0x00FF)

typedef enum _GridLayout
{
    eLayoutLeftTop = 0x00,
    eLayoutLeftCenter = 0x01,
    eLayoutLeftBottom = 0x02,
    eLayoutCenterTop = 0x03,
    eLayoutCenterCenter = 0x04,
    eLayoutCenterBottom = 0x05,
    eLayoutRightTop = 0x06,
    eLayoutRightCenter = 0x07,
    eLayoutRightBottom = 0x08,
    
    eLayoutFillWidth  = 0x4000,
    eLayoutFillHeight = 0x8000,
    
} GridLayoutArchor;

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
    NSMutableArray * rowHeightDefines;
    NSMutableArray * columnWidthDefines;
    NSMutableArray * archorRects;
    NSMutableArray * margins;
    int elementLayoutTypes[kGridPanelMaxElements];
}

@property (nonatomic, retain, readonly) NSMutableArray *elements;

//-(void)setRows:(int)rs andColumns:(int)cs;
- (void) setRows:(NSMutableArray*)rs andColumn:(NSMutableArray*)cs;
-(void)addView:(UIView*)element atRow:(int)row andColumn:(int)column withMargin:(LayoutMargin*)margin archor:(GridLayoutArchor) archor;
- (void)updateLayout;
@end
