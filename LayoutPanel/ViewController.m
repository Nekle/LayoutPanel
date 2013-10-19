//
//  ViewController.m
//  LayoutPanel
//
//  Created by nekle on 13-9-7.
//  Copyright (c) 2013年 nekle. All rights reserved.
//

#import "ViewController.h"
#import "PanelUtil.h"
#import "GridPanel.h"

#import "DockPanel.h"

#import "StackPanel.h"

@interface ViewController ()
{
    GridPanel *grid;
    StackPanel *tstack;
    DockPanel *dock;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    dock = [[DockPanel alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
    dock.backgroundColor = [UIColor grayColor];
    
    UILabel *d1 = [[UILabel alloc] initWithFrame:CGRectZero];
    d1.text = @"Left";
    [d1 sizeToFit];
    [dock addView:d1 withMargin:LayoutMarginMake(1, 1, 1, 1) dock:DockSideType_Left];
    
    
    UILabel *d2 = [[UILabel alloc] initWithFrame:CGRectZero];
    d2.text = @"right";
    [d2 sizeToFit];
    [dock addView:d2 withMargin:LayoutMarginMake(1, 1, 1, 1) dock:DockSideType_Right];
    
    
    UILabel *d3 = [[UILabel alloc] initWithFrame:CGRectZero];
    d3.text = @"top";
    [d3 sizeToFit];
    [dock addView:d3 withMargin:LayoutMarginMake(1, 1, 1, 1) dock:DockSideType_Top];
    
    UILabel *d4 = [[UILabel alloc] initWithFrame:CGRectZero];
    d4.text = @"bottom";
    [d4 sizeToFit];
    [dock addView:d4 withMargin:LayoutMarginMake(1, 1, 1, 1) dock:DockSideType_Bottom];
    
    
    UILabel *d5 = [[UILabel alloc] initWithFrame:CGRectZero];
    d5.text = @"fill";
    [d5 sizeToFit];
    [dock addView:d5 withMargin:LayoutMarginMake(1, 1, 1, 1) dock:DockSideType_Fill];
    
    [self.view addSubview:dock];
    
    grid = [[GridPanel alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
    [grid setRows:[[NSMutableArray alloc] initWithObjects:@"60%", @"40%" , nil] andColumn:[[NSMutableArray alloc] initWithObjects:@"40%", @"60%", nil]] ;
    grid.backgroundColor = [UIColor whiteColor];
    // [self.view addSubview:grid];
    
    UILabel *name = [[UILabel alloc] init];
    name.text = @"1";
    name.textAlignment = NSTextAlignmentCenter;
    name.backgroundColor = [UIColor greenColor];
    
    UILabel *pass = [[UILabel alloc] init];
    pass.text = @"3";
    pass.textAlignment = NSTextAlignmentCenter;
    pass.backgroundColor = [UIColor greenColor];
    
    UILabel *nameInput = [[UILabel alloc] init];
    nameInput.textAlignment = NSTextAlignmentCenter;
    nameInput.text = @"2";
    nameInput.backgroundColor = [UIColor greenColor];
    
    GridPanel * grid1_1= [[GridPanel alloc] init];
    [grid1_1 setRows:[[NSMutableArray alloc] initWithObjects:@"30%", @"70%", nil] andColumn:[[NSMutableArray alloc] initWithObjects:@"30%",@"70%", nil]];
    [grid1_1 setBackgroundColor:[UIColor redColor]];
    
    [grid addView:name atRow:0 andColumn:0 withMargin:LayoutMarginMake(1, 1, 1, 1) archor:eGridPanelArchorType_CenterCenter | eGridPanelArchorType_FillAll];
    [grid addView:nameInput atRow:0 andColumn:1 withMargin:LayoutMarginMake(1, 1, 1, 1) archor:eGridPanelArchorType_CenterCenter | eGridPanelArchorType_FillAll];
    [grid addView:pass atRow:1 andColumn:0 withMargin:LayoutMarginMake(1, 1, 1, 1) archor:eGridPanelArchorType_LeftTop | eGridPanelArchorType_FillAll];
    [grid addView:grid1_1 atRow:1 andColumn:1 withMargin:LayoutMarginMake(10, 10, 10, 10) archor:eGridPanelArchorType_LeftTop | eGridPanelArchorType_FillAll];
    
    UILabel *name1 = [[UILabel alloc] init];
    name1.text = @"1";
    name1.textAlignment = NSTextAlignmentCenter;
    name1.backgroundColor = [UIColor greenColor];
    
    [grid1_1 addView:name1 atRow:0 andColumn:0 withMargin:LayoutMarginMake(1, 1, 1, 1) archor:eGridPanelArchorType_LeftTop | eGridPanelArchorType_FillAll ] ;
    
    UILabel *name2 = [[UILabel alloc] init];
    name2.text = @"2";
    name2.textAlignment = NSTextAlignmentCenter;
    name2.backgroundColor = [UIColor greenColor];
    [grid1_1 addView:name2 atRow:0 andColumn:1 withMargin:LayoutMarginMake(1, 1, 1, 1) archor:eGridPanelArchorType_LeftTop | eGridPanelArchorType_FillAll ] ;
    
    UILabel *name3 = [[UILabel alloc] init];
    name3.text = @"3";
    name3.textAlignment = NSTextAlignmentCenter;
    name3.backgroundColor = [UIColor greenColor];
    [grid1_1 addView:name3 atRow:1 andColumn:0 withMargin:LayoutMarginMake(1, 1, 1, 1) archor:eGridPanelArchorType_LeftTop | eGridPanelArchorType_FillAll ] ;
    
    UILabel *name4 = [[UILabel alloc] init];
    name4.text = @"4";
    name4.textAlignment = NSTextAlignmentCenter;
    name4.backgroundColor = [UIColor greenColor];
    [grid1_1 addView:name4 atRow:1 andColumn:1 withMargin:LayoutMarginMake(1, 1, 1, 1) archor:eGridPanelArchorType_LeftTop | eGridPanelArchorType_FillAll ] ;
    
    
    tstack = [[StackPanel alloc] initWithFrame:CGRectMake(0, 0, 320, 230)];
    tstack.backgroundColor = [UIColor redColor];
    tstack.flowDirector = eStackPanelFlowDirector_BottomToTop;
    //[self.view addSubview:tstack];
    
    UILabel *st1 = [[UILabel alloc] init];
    st1.text = @"1";
    [st1 sizeToFit];
    
    [tstack addView:st1 withMargin:LayoutMarginMake(1, 1, 1, 1) archor:eStackPanelArchorType_RightBottom | eStackPanelArchorType_FillAll];
    
    UILabel *st2 = [[UILabel alloc] init];
    st2.text = @"222222";
    [st2 sizeToFit];
    
    [tstack addView:st2 withMargin:LayoutMarginMake(1, 1, 1, 1) archor:eStackPanelArchorType_RightBottom | eStackPanelArchorType_FillAll];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if (toInterfaceOrientation == UIDeviceOrientationPortrait) {
        NSLog(@"v!!!");
        CGRect frame = grid.frame;
        frame.size = CGSizeMake(320, 460);
        grid.frame = frame;
        tstack.frame = frame;
        dock.frame = frame;
    } else if (toInterfaceOrientation == UIDeviceOrientationLandscapeLeft || toInterfaceOrientation == UIDeviceOrientationLandscapeRight)
    {
        NSLog(@"h!!!");
        CGRect frame = grid.frame;
        frame.size = CGSizeMake(480, 300);
        grid.frame = frame;
        tstack.frame = frame;
        dock.frame = frame;
    }

}


@end
