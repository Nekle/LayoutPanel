//
//  GridPanel.h
//  LayoutPanel
//
//  Created by nekle on 13-9-15.
//  Copyright (c) 2013年 nekle. All rights reserved.
//

#import <UIKit/UIKit.h>


/*
 * 九宫格 布局方式
 */

typedef struct _GridPanelMap
{
    int **map;
}GridPanelMap;

@interface GridPanel : UIView

@property (nonatomic, assign, readonly) int columns;
@property (nonatomic, assign, readonly) int rows;
@property (nonatomic, retain, readonly) NSMutableArray *elements;
@property (nonatomic, assign, readonly) GridPanelMap gridPanelMap;

@end
