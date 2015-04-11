//
//  GridPanelViewController.m
//  LayoutPanel
//
//  Created by Nekle on 15/4/10.
//  Copyright (c) 2015年 nekle. All rights reserved.
//

#import "GridPanelViewController.h"
#import "GridPanel.h"

@interface GridPanelViewController ()
@property (retain, nonatomic) IBOutlet GridPanel *gridPanel;

@end

@implementation GridPanelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.gridPanel setRows:@[@"20%", @"20%", @"60%"] andColumn:@[@"33%", @"33%", @"33%"]];
    
    UILabel *broadCount = [[UILabel alloc] init];
    broadCount.text = @"微博:1231";
    [broadCount sizeToFit];
    broadCount.textAlignment = NSTextAlignmentRight;
    broadCount.backgroundColor = [UIColor colorWithRed:0.7 green:0.5 blue:0.75 alpha:1];
    
    [self.gridPanel addView:broadCount atRow:0 andColumn:0 withMargin:LayoutMarginMake(1, 1, 1, 1) archor:eGridPanelArchorType_RightCenter | eGridPanelArchorType_FillWidth];
    
    UILabel *followingCount = [[UILabel alloc] init];
    followingCount.text = @"微博:3123";
    [followingCount sizeToFit];
    followingCount.textAlignment = NSTextAlignmentCenter;
    followingCount.backgroundColor = [UIColor colorWithRed:0.7 green:0.5 blue:0.75 alpha:1];
    
    [self.gridPanel addView:followingCount atRow:0 andColumn:1 withMargin:LayoutMarginMake(1, 1, 1, 1) archor:eGridPanelArchorType_CenterCenter | eGridPanelArchorType_FillAll];
    
    UILabel *followedCount = [[UILabel alloc] init];
    followedCount.text = @"微博:123";
    [followedCount sizeToFit];
    followedCount.textAlignment = NSTextAlignmentLeft;
    followedCount.backgroundColor = [UIColor colorWithRed:0.7 green:0.5 blue:0.75 alpha:1];
    
    [self.gridPanel addView:followedCount atRow:0 andColumn:2 withMargin:LayoutMarginMake(1, 1, 1, 1) archor:eGridPanelArchorType_LeftCenter | eGridPanelArchorType_FillWidth];
    
    UILabel *Center = [[UILabel alloc] init];
    Center.text = @"Center";
    [Center sizeToFit];
    Center.textAlignment = NSTextAlignmentCenter;
    Center.backgroundColor = [UIColor colorWithRed:0.7 green:0.5 blue:0.75 alpha:1];
    
    [self.gridPanel addView:Center atRow:1 andColumn:1 withMargin:LayoutMarginMake(1, 1, 1, 1) archor:eGridPanelArchorType_LeftCenter | eGridPanelArchorType_FillAll];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
