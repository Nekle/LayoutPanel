//
//  PanelUtil.m
//  LayoutPanel
//
//  Created by nekle on 13-10-19.
//  Copyright (c) 2013年 nekle. All rights reserved.
//

#import "PanelUtil.h"


@implementation LayoutMargin
@synthesize top;
@synthesize left;
@synthesize bottom;
@synthesize right;
-(NSString *)description
{
    return [NSString stringWithFormat:@"[t=%.2f, l=%.2f, b=%.2f, r=%.2f]", top, left, bottom, right];
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

CGFloat GetLayoutWidth(CGRect frame, LayoutMargin *margin)
{
    return (frame.size.width + margin.left + margin.right);
}

CGFloat GetLayoutHeight(CGRect frame, LayoutMargin *margin)
{
    return (frame.size.height + margin.top + margin.bottom);
}
