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

@interface XZDownLoadViewController ()<UIScrollViewDelegate,XZDownOverViewDelegate>
@property (nonatomic, strong) XZLineView *line;
@property (nonatomic, strong) UIButton *downOverBtn;
@property (nonatomic, strong) UIButton *downIngBtn;
@property (nonatomic, strong) UIScrollView *scrollView;
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

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, ScreenWidth, ScreenHeight-64-40)];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.contentSize = CGSizeMake(ScreenWidth, ScreenHeight-64-40);
    }
    return _scrollView;
}

- (XZDownOverView *)downOverView
{
    if (!_downOverView) {
        _downOverView = [[XZDownOverView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64-40)];
        _downOverView.downOverDelegate = self;
    }
    return _downOverView;
}

- (XZDowningView *)downIngView
{
    if (!_downIngView) {
        _downIngView = [[XZDowningView alloc] initWithFrame:CGRectMake(ScreenWidth, 0, ScreenWidth, ScreenHeight-64-40)];
    }
    
    return _downIngView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.downOverView initData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addRightButton:@"play"];
    [self setTitleViewWithString:@"下载"];
    
    [self initData];
    [self initUI];
    
    [self addNotification];
}

- (void)initData
{
}

- (void)initUI
{
    [self addDownActionView];
    
    [self.scrollView addSubview:self.downOverView];
    [self.scrollView addSubview:self.downIngView];
    
    [self.view addSubview:self.scrollView];
    
    XZGlobalManager *globalManager = [XZGlobalManager shareInstance];
    [globalManager addObserver:self forKeyPath:@"musicDownArr" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
}


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqualToString:@"musicDownArr"])
    {
        [self refreshDownMusic];
    }
}

- (void)refreshDownMusic
{
    [self.downOverView initData];
    [self.downIngView initData];
    
    DLog(@"refreshDownMusic-->>%@",[XZGlobalManager shareInstance].musicDownArr);
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
- (void)rightButtonAction:(id)sender
{
    XZMusicPlayViewController *musicPlayVC = [XZMusicPlayViewController shareInstance];
    musicPlayVC.backType = BackTypePopBack;
    [self.navigationController pushViewController:musicPlayVC animated:YES];
}

- (void)downOverAction:(id)sender
{
    if (self.scrollView.contentOffset.x != 0) {
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        
        CGRect frame = self.line.frame;
        frame.origin.x = 0;
        [UIView animateWithDuration:0.2 animations:^{
            self.line.frame = frame;
        }];
    }
}

- (void)downIngAction:(id)sender
{
    if (self.scrollView.contentOffset.x == 0) {
        [self.scrollView setContentOffset:CGPointMake(ScreenWidth, 0) animated:YES];

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

#pragma mark - XZDownOverViewDelegate
- (void)downOverMusicNum:(NSInteger)num
{
    if (num > 0) {
        [self.downOverBtn setTitle:[NSString stringWithFormat:@"下载结束(%ld)",num] forState:UIControlStateNormal];
    } else {
        [self.downOverBtn setTitle:@"下载结束" forState:UIControlStateNormal];
    }
}

- (void)didSelectMusicInfo:(NSInteger)indexNum musicInfo:(XZMusicInfo *)musicInfo
{
    XZMusicPlayViewController *musicPlayVC = [XZMusicPlayViewController shareInstance];
    musicPlayVC.backType = BackTypePopBack;
    [musicPlayVC playingMusicWithExistSong:musicInfo];
    [self.navigationController pushViewController:musicPlayVC animated:YES];
}

- (void)dealloc{
    [self removeObserver:self forKeyPath:@"musicDownArr"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
