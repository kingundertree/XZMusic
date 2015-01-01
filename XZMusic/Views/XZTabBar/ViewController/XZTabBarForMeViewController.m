//
//  XZTabBarForMeViewController.m
//  XZMusic
//
//  Created by xiazer on 14-8-24.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "XZTabBarForMeViewController.h"
#import "XZMyLovedView.h"

@interface XZTabBarForMeViewController ()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) XZMyLovedView *lovedView;

@end

@implementation XZTabBarForMeViewController

- (XZMyLovedView *)lovedView
{
    if (!_lovedView) {
        _lovedView = [[XZMyLovedView alloc] initWithFrame:CGRectMake(0, 15, ScreenWidth, 100)];
    }
    return _lovedView;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = [UIColor yellowColor];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self initUI];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initUI
{
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64-50)];
    [self.view addSubview:self.scrollView];
    
    [self.lovedView displayUI:^(BOOL completed) {
        DLog(@"completed");
    }];
    [self.scrollView addSubview:self.lovedView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
