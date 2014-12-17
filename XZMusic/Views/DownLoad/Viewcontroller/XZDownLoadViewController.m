//
//  XZDownLoadViewController.m
//  XZMusic
//
//  Created by xiazer on 14-8-31.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "XZDownLoadViewController.h"
#import "XZLineView.h"
#import "XZDownOverView.h"
#import "XZDowningView.h"

@interface XZDownLoadViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) XZLineView *line;
@property (nonatomic, strong) UIButton *downOverBtn;
@property (nonatomic, strong) UIButton *downIngBtn;
@property (nonatomic, strong) XZDownOverView *downOverView;
@property (nonatomic, strong) XZDowningView *downIngView;
@end

@implementation XZDownLoadViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (XZLineView *)line
{
    if (!_line) {
        _line = [[XZLineView alloc] initWithFrame:CGRectMake(0, 37, ScreenWidth/2, 3)];
        _line.lineColor = [UIColor redColor];
    }
    return _line;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self setTitleViewWithString:@"下载"];
    
    [self initData];
    [self initUI];
}

- (void)initData
{
    self.downOverView = [[XZDownOverView alloc] initWithFrame:CGRectMake(0, 40, ScreenWidth, ScreenHeight-64-40)];
    self.downIngView = [[XZDowningView alloc] initWithFrame:CGRectMake(0, 40, ScreenWidth, ScreenHeight-64-40)];
    self.downIngView.hidden = YES;
}

- (void)initUI
{
    [self addDownActionView];
    
    [self.view addSubview:self.downOverView];
    [self.view addSubview:self.downIngView];
}

- (void)addDownActionView
{
    UIView *menuView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
    menuView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:menuView];
    
    self.downOverBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.downOverBtn.frame = CGRectMake(0, 0, ScreenWidth/2, 40);
    self.downOverBtn.backgroundColor = [UIColor XZMiddleGrayColor];
    [self.downOverBtn setTitle:@"下载结束" forState:UIControlStateNormal];
    [self.downOverBtn addTarget:self action:@selector(downOverAction:) forControlEvents:UIControlEventTouchUpInside];
    [menuView addSubview:self.downOverBtn];
    
    self.downIngBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.downIngBtn.frame = CGRectMake(ScreenWidth/2, 0, ScreenWidth/2, 40);
    self.downIngBtn.backgroundColor = [UIColor XZMiddleGrayColor];
    [self.downIngBtn setTitle:@"下载中" forState:UIControlStateNormal];
    [self.downIngBtn addTarget:self action:@selector(downIngAction:) forControlEvents:UIControlEventTouchUpInside];
    [menuView addSubview:self.downIngBtn];

    [menuView addSubview:self.line];
}

#pragma mark - method
- (void)downOverAction:(id)sender
{
    if (self.downOverView.hidden) {
        self.downOverView.hidden = NO;
        self.downIngView.hidden = YES;
        
        CGRect frame = self.line.frame;
        frame.origin.x = 0;
        [UIView animateWithDuration:0.2 animations:^{
            self.line.frame = frame;
        }];
    }
}

- (void)downIngAction:(id)sender
{
    if (!self.downOverView.hidden) {
        self.downOverView.hidden = YES;
        self.downIngView.hidden = NO;

        CGRect frame = self.line.frame;
        frame.origin.x = ScreenWidth/2;
        [UIView animateWithDuration:0.2 animations:^{
            self.line.frame = frame;
        }];
    }
}

#pragma mark
#pragma leftButtonAction
- (void)doBack:(id)sender{
    [[XZAppDelegate sharedAppDelegate].menuMainVC mainVCLeftMenuAction];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
