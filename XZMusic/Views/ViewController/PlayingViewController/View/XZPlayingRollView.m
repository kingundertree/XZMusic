//
//  XZPlayingRollView.m
//  XZMusic
//
//  Created by xiazer on 14/12/2.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "XZPlayingRollView.h"
#import <QuartzCore/QuartzCore.h>

@implementation XZPlayingRollView

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
    self.songBgImg = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth/2 - self.frame.size.height/2 + 15, 15, self.frame.size.height - 30, self.frame.size.height - 30)];
    self.songBgImg.layer.masksToBounds = YES;
    self.songBgImg.layer.cornerRadius = self.frame.size.height/2 - 15;
    self.songBgImg.layer.borderWidth = 6;
    self.songBgImg.layer.borderColor = [UIColor blackColor].CGColor;
    [self addSubview:self.songBgImg];

    self.songPlayingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.songPlayingBtn.frame = self.songBgImg.frame;
    self.songPlayingBtn.backgroundColor = [UIColor clearColor];
    [self.songPlayingBtn setTitle:@"播放" forState:UIControlStateNormal];
    self.songPlayingBtn.titleLabel.font = [UIFont boldSystemFontOfSize:40];
    [self.songPlayingBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.songPlayingBtn addTarget:self action:@selector(playingControl:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.songPlayingBtn];

    // 动画控制
    CABasicAnimation *monkeyAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    monkeyAnimation.toValue = [NSNumber numberWithFloat:2.0 *M_PI];
    monkeyAnimation.duration = 4.0f;
    monkeyAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    monkeyAnimation.cumulative = NO;
    monkeyAnimation.removedOnCompletion = NO; //No Remove
    
    monkeyAnimation.repeatCount = FLT_MAX;
    [self.songBgImg.layer addAnimation:monkeyAnimation forKey:@"AnimatedKey"];
    [self.songBgImg stopAnimating];
    
    self.songBgImg.layer.speed = 0.0;
}

- (void)configRooViewData:(NSString *)bigImgUrl {
    [self.songBgImg setImageWithURL:[NSURL URLWithString:bigImgUrl] placeholderImage:nil];
}

- (void)playingControl:(id)sender {
    _rollPlayingPlayStatus = (_rollPlayingPlayStatus == XZPlayingRollViewActionTypeForPlaying) ? XZPlayingRollViewActionTypeForPause : XZPlayingRollViewActionTypeForPlaying;

    if (self.rollViewDelegate && [self.rollViewDelegate respondsToSelector:@selector(playingRollViewAction:)]) {
        [self.rollViewDelegate playingRollViewAction:_rollPlayingPlayStatus];
    }
}

- (void)setRollPlayingPlayStatus:(enum XZPlayingRollViewActionType)rollPlayingPlayStatus{
    _rollPlayingPlayStatus = rollPlayingPlayStatus;
    
    if (_rollPlayingPlayStatus == XZPlayingRollViewActionTypeForPlaying) {
        [self.songPlayingBtn setTitle:@"播放" forState:UIControlStateNormal];
        [self.songPlayingBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];

        // 开始播放
        self.songBgImg.layer.speed = 1.0;
        self.songBgImg.layer.beginTime = 0.0;
        CFTimeInterval pausedTime = [self.songBgImg.layer timeOffset];
        CFTimeInterval timeSincePause = [self.songBgImg.layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
        self.songBgImg.layer.beginTime = timeSincePause;
    }else {
        [self.songPlayingBtn setTitle:@"暂停" forState:UIControlStateNormal];
        [self.songPlayingBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];

        // 暂停播放
        CFTimeInterval pausedTime = [self.songBgImg.layer convertTime:CACurrentMediaTime() fromLayer:nil];
        self.songBgImg.layer.speed = 0.0;
        self.songBgImg.layer.timeOffset = pausedTime;
    }
}

@end
