//
//  DockPanelViewController.m
//  LayoutPanel
//
//  Created by Nekle on 15/4/10.
//  Copyright (c) 2015年 nekle. All rights reserved.
//

#import "DockPanelViewController.h"
#import "DockPanel.h"

@interface DockPanelViewController ()
@property (retain, nonatomic) IBOutlet DockPanel *dockPanel;

@end

@implementation DockPanelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *top = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 150)];
    top.text = @"Top";
    [top sizeToFit];
    top.backgroundColor = [UIColor redColor];
    [self.dockPanel addView:top withMargin:LayoutMarginMake(1, 1, 1, 1) dock:  eDockSideType_Top];
    
    UILabel *left = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 150)];
    left.text = @"Left";
    [left sizeToFit];
    left.backgroundColor = [UIColor redColor];
    [self.dockPanel addView:left withMargin:LayoutMarginMake(1, 1, 1, 1) dock:  eDockSideType_Left];

    
    UILabel *bottom = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 150)];
    bottom.text = @"BOTTOM";
    [bottom sizeToFit];
    bottom.backgroundColor = [UIColor redColor];
    [self.dockPanel addView:bottom withMargin:LayoutMarginMake(1, 1, 1, 1) dock:  eDockSideType_Bottom];


    UILabel *right = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 150)];
    right.text = @"Right";
    [right sizeToFit];
    right.backgroundColor = [UIColor redColor];
    [self.dockPanel addView:right withMargin:LayoutMarginMake(1, 1, 1, 1) dock:  eDockSideType_Right];
    
    UILabel *center = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 150)];
    center.text = @"Center";
    [center sizeToFit];
    center.textAlignment = NSTextAlignmentCenter;
    center.backgroundColor = [UIColor redColor];
    [self.dockPanel addView:center withMargin:LayoutMarginMake(1, 1, 1, 1) dock:  eDockSideType_Fill];

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
