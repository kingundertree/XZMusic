//
//  XZPlayMoreFuncView.m
//  XZMusic
//
//  Created by xiazer on 14/12/2.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "XZPlayMoreFuncView.h"
#import "XZCircleProgress.h"

@interface XZPlayMoreFuncView ()
@property (nonatomic, strong) UIButton *redBtn;
@property (nonatomic, strong) UIButton *downBtn;
@property (nonatomic, strong) XZCircleProgress *downProgress;
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
    [self.redBtn setTitle:@"点赞" forState:UIControlStateNormal];
    [self.redBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
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

- (XZCircleProgress *)downProgress{
    if (!_downProgress) {
        _downProgress = [[XZCircleProgress alloc] initWithFrame:CGRectMake(ScreenWidth/2+10, self.frame.size.height/2 - 30, 60, 60)];
        _downProgress.progressStyle = XZCircleProgressStyleForMusicDown;
    }
    
    return _downProgress;
}

- (void)preMusic:(id)sender {

}

- (void)nextMusic:(id)sender {
    
}

- (void)addCount:(id)sender {
    
}

- (void)downMusic:(id)sender {
    
}


@end
