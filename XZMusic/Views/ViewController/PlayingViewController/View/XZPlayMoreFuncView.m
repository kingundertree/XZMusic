//
//  XZPlayMoreFuncView.m
//  XZMusic
//
//  Created by xiazer on 14/12/2.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "XZPlayMoreFuncView.h"
#import "XZCircleProgress.h"
#import "XZMusicInfo.h"

@interface XZPlayMoreFuncView ()
@property (nonatomic, strong) UIButton *redBtn;
@property (nonatomic, strong) UIButton *downBtn;
@property (nonatomic, strong) XZCircleProgress *downProgress;
@property (nonatomic, assign) float progress;
@end

@implementation XZPlayMoreFuncView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self){
        self.backgroundColor = [UIColor clearColor];
        
        [self initUI];
    }
    return self;
}

- (void)initUI {
    UIButton *preBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    preBtn.frame = CGRectMake(10, self.frame.size.height/2-20, 60, 40);
    preBtn.backgroundColor = [UIColor clearColor];
    [preBtn setTitle:@"上一首" forState:UIControlStateNormal];
    [preBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [preBtn addTarget:self action:@selector(preMusic:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:preBtn];

    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    nextBtn.frame = CGRectMake(ScreenWidth-70, self.frame.size.height/2-20, 60, 40);
    nextBtn.backgroundColor = [UIColor clearColor];
    [nextBtn setTitle:@"下一首" forState:UIControlStateNormal];
    [nextBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [nextBtn addTarget:self action:@selector(nextMusic:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:nextBtn];

    self.redBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.redBtn.frame = CGRectMake(ScreenWidth/2-80, self.frame.size.height/2-20, 60, 40);
    self.redBtn.backgroundColor = [UIColor clearColor];
    [self.redBtn setTitle:@"赞" forState:UIControlStateNormal];
    [self.redBtn addTarget:self action:@selector(addCount:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.redBtn];

    [self addSubview:self.downProgress];
    
    self.downBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.downBtn.frame = self.downProgress.bounds;
    self.downBtn.backgroundColor = [UIColor clearColor];
    [self.downBtn setTitle:@"下载" forState:UIControlStateNormal];
    [self.downBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.downBtn addTarget:self action:@selector(downMusic:) forControlEvents:UIControlEventTouchUpInside];
    [self.downProgress addSubview:self.downBtn];

}

- (void)configData
{
    self.progress = 0.0;
    [self showCircleProgress:0.0];

    XZMusicInfo *musicInfo = [[XZMusicCoreDataCenter shareInstance] fetchMusicInfo:[XZGlobalManager shareInstance].playMusicId];
    if ([musicInfo.musicIsPraised boolValue]) {
        [self.redBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    } else {
        [self.redBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
}

- (XZCircleProgress *)downProgress{
    if (!_downProgress) {
        _downProgress = [[XZCircleProgress alloc] initWithFrame:CGRectMake(ScreenWidth/2+10, self.frame.size.height/2 - 30, 60, 60)];
        _downProgress.progressStyle = XZCircleProgressStyleForMusicDown;
    }
    
    return _downProgress;
}

- (void)preMusic:(id)sender {
    if (self.funcViewDelegate && [self.funcViewDelegate respondsToSelector:@selector(funcViewAction:)]) {
        [self.funcViewDelegate funcViewAction:XZPlayMoreFuncViewActionTypeForPre];
    }
}

- (void)nextMusic:(id)sender {
    if (self.funcViewDelegate && [self.funcViewDelegate respondsToSelector:@selector(funcViewAction:)]) {
        [self.funcViewDelegate funcViewAction:XZPlayMoreFuncViewActionTypeForNext];
    }
}

- (void)addCount:(id)sender {
    XZMusicInfo *musicInfo = [[XZMusicCoreDataCenter shareInstance] fetchMusicInfo:[XZGlobalManager shareInstance].playMusicId];
    if ([musicInfo.musicIsPraised boolValue]) {
        [[XZMusicCoreDataCenter shareInstance] updateMusicInfo:[XZGlobalManager shareInstance].playMusicId isAddPraise:NO];
        [self.redBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    } else {
        [[XZMusicCoreDataCenter shareInstance] updateMusicInfo:[XZGlobalManager shareInstance].playMusicId isAddPraise:YES];
        [self.redBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }

    if (self.funcViewDelegate && [self.funcViewDelegate respondsToSelector:@selector(funcViewAction:)]) {
        [self.funcViewDelegate funcViewAction:XZPlayMoreFuncViewActionTypeForAddPraise];
    }
}

- (void)downMusic:(id)sender {
    if (self.progress != 0 && [XZGlobalManager shareInstance].isNeedDown) {
        return;
    }
    
    if (self.funcViewDelegate && [self.funcViewDelegate respondsToSelector:@selector(funcViewAction:)]) {
        [self.funcViewDelegate funcViewAction:XZPlayMoreFuncViewActionTypeForDown];
    }
}

- (void)showCircleProgress:(float)progress {
    self.progress = progress;
    
    if (progress >= 1.0) {
        [self.downBtn setTitle:@"完成" forState:UIControlStateNormal];
    }else if (progress == 0.0){
        [self.downBtn setTitle:@"下载" forState:UIControlStateNormal];
    }else {
        [self.downBtn setTitle:@"下载..." forState:UIControlStateNormal];
    }
    self.downProgress.progressV = progress;
}

@end
