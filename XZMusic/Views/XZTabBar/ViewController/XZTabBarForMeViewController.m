//
//  XZTabBarForMeViewController.m
//  XZMusic
//
//  Created by xiazer on 14-8-24.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "XZTabBarForMeViewController.h"
#import "XZMyAddPraiseView.h"
#import "XZAddPraiseViewController.h"
#import "XZMyLocalView.h"
#import "XZDownloadedViewController.h"
#import "XZMyLovedView.h"
#import "XZLovedViewController.h"
#import "XZMyHeardView.h"
#import "XZHeardedViewController.h"


@interface XZTabBarForMeViewController ()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) XZMyAddPraiseView *praisedView;
@property (nonatomic, strong) XZMyLocalView *localView;
@property (nonatomic, strong) XZMyLovedView *lovedView;
@property (nonatomic, strong) XZMyHeardView *heardView;

@end

@implementation XZTabBarForMeViewController

- (XZMyAddPraiseView *)praisedView
{
    if (!_praisedView) {
        _praisedView = [[XZMyAddPraiseView alloc] initWithFrame:CGRectMake(0, 15, ScreenWidth, 100)];
    }
    return _praisedView;
}

- (XZMyLocalView *)localView
{
    if (!_localView) {
        _localView = [[XZMyLocalView alloc] initWithFrame:CGRectMake(0, 15+100+15, ScreenWidth, 100)];
    }
    return _localView;
}

- (XZMyLovedView *)lovedView
{
    if (!_lovedView) {
        _lovedView = [[XZMyLovedView alloc] initWithFrame:CGRectMake(0, 15+100+15+100+15, ScreenWidth, 100)];
    }
    return _lovedView;
}

- (XZMyHeardView *)heardView
{
    if (!_heardView) {
        _heardView = [[XZMyHeardView alloc] initWithFrame:CGRectMake(0, 15+100+15+100+15+100+15, ScreenWidth, 100)];
    }
    return _heardView;
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
    self.scrollView.contentSize = CGSizeMake(ScreenWidth, ScreenHeight-64-50+1);
    [self.view addSubview:self.scrollView];
    
    __weak XZTabBarForMeViewController *this = self;
    [self.praisedView displayUI:^(BOOL completed) {
        XZAddPraiseViewController *addPraiseVC = [[XZAddPraiseViewController alloc] init];
        if (this.meDelegate && [this.meDelegate respondsToSelector:@selector(pushForMeVC:)]) {
            [this.meDelegate pushForMeVC:addPraiseVC];
        }
    }];
    [self.scrollView addSubview:self.praisedView];
    
    [self.localView displayUI:^(BOOL completed) {
        XZDownloadedViewController *downloadVC = [[XZDownloadedViewController alloc] init];
        if (this.meDelegate && [this.meDelegate respondsToSelector:@selector(pushForMeVC:)]) {
            [this.meDelegate pushForMeVC:downloadVC];
        }
    }];
    [self.scrollView addSubview:self.localView];

    [self.lovedView displayUI:^(BOOL completed) {
        XZLovedViewController *lovedVC = [[XZLovedViewController alloc] init];
        if (this.meDelegate && [this.meDelegate respondsToSelector:@selector(pushForMeVC:)]) {
            [this.meDelegate pushForMeVC:lovedVC];
        }
    }];
    [self.scrollView addSubview:self.lovedView];


    [self.heardView displayUI:^(BOOL completed) {
        XZHeardedViewController *hearVC = [[XZHeardedViewController alloc] init];
        if (this.meDelegate && [this.meDelegate respondsToSelector:@selector(pushForMeVC:)]) {
            [this.meDelegate pushForMeVC:hearVC];
        }
    }];
    [self.scrollView addSubview:self.heardView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
