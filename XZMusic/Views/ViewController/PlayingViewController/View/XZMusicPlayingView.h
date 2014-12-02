//
//  XZMusicPlayingView.h
//  XZMusic
//
//  Created by xiazer on 14/12/1.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XZMusicLrcView.h"
#import "XZCircleProgress.h"
#import "DOUAudioStreamer.h"
#import "XZPlaySongModel.h"
#import "XZMusicPlayingTimeProgress.h"
#import "XZSongModel.h"
#import "XZPlayingRollView.h"
#import "XZPlayMoreFuncView.h"

@protocol XZMusicPlayingViewDelegate <NSObject>

@end

@interface XZMusicPlayingView : UIView <XZPlayingRollViewDelegate,XZPlayMoreFuncViewDelegate>

@property(nonatomic, assign) id<XZMusicPlayingViewDelegate> playIngDelegateView;
@property(nonatomic, strong) DOUAudioStreamer *audioPlayer;
@property(nonatomic, strong) XZPlaySongModel *playSongModel;
@property(nonatomic, strong) XZMusicPlayingTimeProgress *timeProgress;
@property(nonatomic, strong) XZPlayingRollView *playingRollView;
@property(nonatomic, strong) XZPlayMoreFuncView *playingMoreView;


// 歌词显示
- (void)showLrcWithPath:(NSString *)lrcPath;
- (void)showLrcWithTime:(int)time;

// 播放歌曲
- (void)playMusic:(XZPlaySongModel *)songMode;

// 控制播放进度显示
- (void)updateProgress:(int)playingTime;

// 歌曲内容控制
- (void)congfigPlaying:(XZSongModel *)songModel;
@end
