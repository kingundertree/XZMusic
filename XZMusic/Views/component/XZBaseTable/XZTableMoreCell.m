//
//  XZTableMoreCell.m
//  XZMusic
//
//  Created by xiazer on 14/11/8.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "XZTableMoreCell.h"

@interface XZTableMoreCell ()
@property(nonatomic, strong) UILabel *lab;
@property(nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@end

@implementation XZTableMoreCell

- (UILabel *)lab{
    if (!_lab) {
        _lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
        _lab.backgroundColor = [UIColor clearColor];
        _lab.font = [UIFont xzH3Font];
        _lab.textAlignment = NSTextAlignmentCenter;
        _lab.textColor = [UIColor XZMiddleGrayColor];
    }
    
    return _lab;
}


- (UIActivityIndicatorView *)activityIndicator{
    if (!_activityIndicator) {
        _activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        _activityIndicator.center = CGPointMake(100.0f, 20);
        _activityIndicator.frame = CGRectMake(80, 0, 40, 40);
        _activityIndicator.color = [UIColor lightGrayColor];
        
        [_activityIndicator startAnimating];
    }
    
    return _activityIndicator;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
    }
    return self;
}

- (void)initUI{
    self.backgroundColor = [UIColor whiteColor];
}

- (void)showLoadingView{
    
    self.lab.text = @"正在加载中...";
    [self addSubview:self.lab];
}

- (void)showReadyView{
    self.lab.text = @"上拉下载数据...";
    [self addSubview:self.lab];
}

- (void)showNoNeedLoadingView{
    self.lab.text = @"下面没有啦，不要再拽我鸟~";
    [self addSubview:self.lab];
}

- (void)showActive:(BOOL)isShow{
    if (isShow) {
        [self addSubview:self.activityIndicator];
    }else{
        [self.activityIndicator removeFromSuperview];
    }
}

- (void)setMoreCellStatus:(enum XZMusicMoreCellStatus)moreCellStatus{
    if (moreCellStatus == LoadingMoreCellStatusForReadLoading) {
        [self showActive:NO];
        [self showReadyView];
    }else if (moreCellStatus == LoadingMoreCellStatusForIsLoading){
        [self showActive:YES];
        [self showLoadingView];
    }else if (moreCellStatus == LoadingMoreCellStatusForNoNeedLoading){
        [self showActive:NO];
        [self showNoNeedLoadingView];
    }
}


@end
