//
//  ViewController.m
//  LayoutPanel
//
//  Created by nekle on 13-9-7.
//  Copyright (c) 2013年 nekle. All rights reserved.
//

#import "ViewController.h"
#import "StackPanel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    StackPanel *stack = [[[StackPanel alloc] initWithFrame:CGRectMake(0, 0, 80, 460)] autorelease];
    stack.backgroundColor = [UIColor grayColor];
    stack.archor = evLayoutArchorTopRight;
    stack.flowDirector = eLayoutFlowDirectorVertical;
    [self.view addSubview:stack];
    
    UILabel *l1 = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 60)] autorelease];
    l1.backgroundColor = [UIColor redColor];
    l1.textAlignment = NSTextAlignmentCenter;
    l1.text = @"Home";
    [l1 sizeToFit];
    [stack addView:l1 withMargin:LayoutMarginMake(30, 0, 0, 2)];
    
    UILabel *l2 = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 60)] autorelease];
    l2.backgroundColor = [UIColor blueColor];
    l2.textAlignment = NSTextAlignmentCenter;
    l2.text = @"My Blog";
    [l2 sizeToFit];
    [stack addView:l2 withMargin:LayoutMarginMake(30, 0, 0, 2)];
    
    UILabel *l3 = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 60)] autorelease];
    l3.backgroundColor = [UIColor greenColor];
    l3.textAlignment = NSTextAlignmentCenter;
    l3.text = @"Topic";
    [l3 sizeToFit];
    [stack addView:l3 withMargin:LayoutMarginMake(30, 0, 0, 2)];
    
    /*
    //CGRect frame = self.view.frame;
    StackPanel *stack2 = [[[StackPanel alloc]initWithFrame:CGRectMake(0, 80, 80, 460-80*2)] autorelease];
    stack2.backgroundColor = [UIColor darkGrayColor];
    stack2.flowDirector = eLayoutFlowDirectorVertical;
    stack2.archor = evLayoutArchorCenterRight;
    UILabel *l4 = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 60)] autorelease];
    l4.backgroundColor = [UIColor redColor];
    l4.textAlignment = NSTextAlignmentCenter;
    l4.text = @"4";
    [stack2 addView:l4];
    UILabel *l5 = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 60)] autorelease];
    l5.backgroundColor = [UIColor blueColor];
    l5.textAlignment = NSTextAlignmentCenter;
    l5.text = @"5";
    [stack2 addView:l5];
    UILabel *l6 = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 60)] autorelease];
    l6.backgroundColor = [UIColor greenColor];
    l6.textAlignment = NSTextAlignmentCenter;
    l6.text = @"6";
    [stack2 addView:l6];
    
    [self.view addSubview:stack2];
    
    StackPanel *stack3 = [[[StackPanel alloc]initWithFrame:CGRectMake(0, 460-80, 320, 80)] autorelease];
    stack3.backgroundColor = [UIColor grayColor];
    stack3.flowDirector = eLayoutFlowDirectorHorizonal;
    stack3.archor = ehLayoutArchorCenterTop;
    UILabel *l7 = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 60)] autorelease];
    l7.backgroundColor = [UIColor redColor];
    l7.textAlignment = NSTextAlignmentCenter;
    l7.text = @"7";
    [stack3 addView:l7];
    UILabel *l8 = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 60)] autorelease];
    l8.backgroundColor = [UIColor blueColor];
    l8.textAlignment = NSTextAlignmentCenter;
    l8.text = @"8";
    [stack3 addView:l8];
    UILabel *l9 = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 60)] autorelease];
    l9.backgroundColor = [UIColor greenColor];
    l9.textAlignment = NSTextAlignmentCenter;
    l9.text = @"9";
    [stack3 addView:l9];
    
    [self.view addSubview:stack3];
    
    
    StackPanel *stack4 = [[[StackPanel alloc]initWithFrame:CGRectMake(320-80, 80, 80, 460-80*2)] autorelease];
    stack4.backgroundColor = [UIColor darkGrayColor];
    stack4.flowDirector = eLayoutFlowDirectorVertical;
    stack4.archor = evLayoutArchorCenterLeft;
    UILabel *l10 = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 60)] autorelease];
    l10.backgroundColor = [UIColor redColor];
    l10.textAlignment = NSTextAlignmentCenter;
    l10.text = @"10";
    [stack4 addView:l10];
    UILabel *l11 = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 60)] autorelease];
    l11.backgroundColor = [UIColor blueColor];
    l11.textAlignment = NSTextAlignmentCenter;
    l11.text = @"11";
    [stack4 addView:l11];
    UILabel *l12 = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 60)] autorelease];
    l12.backgroundColor = [UIColor greenColor];
    l12.text = @"12";
    l12.textAlignment = NSTextAlignmentCenter;
    [stack4 addView:l12];
    
    [self.view addSubview:stack4];
    */
    StackPanel *stack5 = [[[StackPanel alloc]initWithFrame:CGRectMake(0, 460-80, 320, 80)] autorelease];
    stack5.backgroundColor = [UIColor darkGrayColor];
    stack5.flowDirector = eLayoutFlowDirectorHorizonal;
    stack5.archor = ehLayoutArchorCenterTop;
    UIButton *l13 = [UIButton buttonWithType:UIButtonTypeCustom];
    [l13 setImage :[UIImage imageNamed:@"safari.png"] forState:UIControlStateNormal ];
    [l13 sizeToFit];
    [stack5 addView:l13 withMargin:LayoutMarginMake(0, 0, 0, 0)];
    UIButton *l14 = [UIButton buttonWithType:UIButtonTypeCustom];
    [l14 setImage :[UIImage imageNamed:@"photos.png"] forState:UIControlStateNormal ];
    [l14 sizeToFit];
    [stack5 addView:l14 withMargin:LayoutMarginMake(0, 30, 0, 0)];
    UIButton *l15 = [UIButton buttonWithType:UIButtonTypeCustom] ;
    [l15 setImage :[UIImage imageNamed:@"settings.png"] forState:UIControlStateNormal ];
    [l15 sizeToFit];
    [stack5 addView:l15 withMargin:LayoutMarginMake(0, 30, 0, 0)];
    
    [self.view addSubview:stack5];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
