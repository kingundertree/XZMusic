//
//  XZMusicPlayingTimeProgress.h
//  XZMusic
//
//  Created by xiazer on 14/12/1.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XZMusicPlayingTimeProgress : UIView
@property(nonatomic, strong) UISlider *timeSlider;
@property(nonatomic, strong) UILabel *playingTime;
@property(nonatomic, strong) UILabel *totalTime;

- (void)initTimeProgressData:(NSInteger)time;
- (void)updatePlayingTime:(NSInteger)time;
- (void)updateProgress:(NSInteger)playTime;

@end
