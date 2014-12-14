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
#import "XZMusicInfo.h"
#import "XZPlayingRollView.h"
#import "XZPlayMoreFuncView.h"

NS_ENUM(NSInteger, XZMusicPlayingStyle) {
    XZMusicPlayingStyleForRecycle = 1, // 循环
    XZMusicPlayingStyleForOneByOne = 2, // 循序渐进
};

@interface XZMusicPlayingView : UIView <XZPlayingRollViewDelegate,XZPlayMoreFuncViewDelegate>

@property (nonatomic, strong) DOUAudioStreamer *audioPlayer;
@property (nonatomic, strong) XZPlaySongModel *playSongModel;
@property (nonatomic, strong) XZMusicPlayingTimeProgress *timeProgress;
@property (nonatomic, strong) XZPlayingRollView *playingRollView;
@property (nonatomic, strong) XZPlayMoreFuncView *playingMoreView;
@property (nonatomic, assign) enum XZMusicPlayingStyle playingStyle;

// 歌词显示
- (void)showLrcWithPath:(NSString *)lrcPath;

// 播放歌曲
- (void)playMusic:(XZPlaySongModel *)songMode;

// 控制播放进度显示
- (void)updateProgress:(int)playingTime;

// 歌曲内容控制
- (void)congfigPlaying:(XZMusicInfo *)songModel;
@end
