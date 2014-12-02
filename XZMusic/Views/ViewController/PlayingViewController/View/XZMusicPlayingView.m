//
//  XZMusicPlayingView.m
//  XZMusic
//
//  Created by xiazer on 14/12/1.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "XZMusicPlayingView.h"
static void *kStatusKVOKey = &kStatusKVOKey;
static void *kDurationKVOKey = &kDurationKVOKey;
static void *kBufferingRatioKVOKey = &kBufferingRatioKVOKey;


@interface XZMusicPlayingView ()
@property(nonatomic, strong) XZMusicLrcView *lrcView;
@property(nonatomic, strong) XZSongModel *songModel;
@end

@implementation XZMusicPlayingView

- (XZMusicPlayingTimeProgress *)timeProgress{
    if (!_timeProgress) {
        _timeProgress = [[XZMusicPlayingTimeProgress alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 100)];
    }
    return _timeProgress;
}

- (XZPlayingRollView *)playingRollView{
    if (!_playingRollView) {
        _playingRollView = [[XZPlayingRollView alloc] initWithFrame:CGRectMake(0, 50, ScreenWidth, 300)];
        _playingRollView.rollViewDelegate = self;
    }
    return _playingRollView;
}
- (XZMusicLrcView *)lrcView{
    if (!_lrcView) {
        _lrcView = [[XZMusicLrcView alloc] initWithFrame:CGRectMake(0, 50 + 300, ScreenWidth, ScreenHeight-64-50-300-80)];
    }
    return _lrcView;
}
- (XZPlayMoreFuncView *)playingMoreView{
    if (!_playingMoreView) {
        _playingMoreView = [[XZPlayMoreFuncView alloc] initWithFrame:CGRectMake(0, ScreenHeight-64-80, ScreenWidth, 80)];
        _playingMoreView.funcViewDelegate = self;
    }
    return _playingMoreView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self){
        self.backgroundColor = [UIColor clearColor];
        
        [self initData];
        [self initUI];
    }
    return self;
}

- (void)initData{
}

- (void)initUI{
    [self addSubview:self.timeProgress];
    [self addSubview:self.lrcView];
    [self addSubview:self.playingRollView];
    [self addSubview:self.playingMoreView];
}

#pragma mark - method
- (void)playMusic:(XZPlaySongModel *)songMode{
    self.audioPlayer = [DOUAudioStreamer streamerWithAudioFile:songMode];
    [self.audioPlayer addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:kStatusKVOKey];
    [self.audioPlayer addObserver:self forKeyPath:@"duration" options:NSKeyValueObservingOptionNew context:kDurationKVOKey];
    [self.audioPlayer addObserver:self forKeyPath:@"bufferingRatio" options:NSKeyValueObservingOptionNew context:kBufferingRatioKVOKey];
    
    [self.audioPlayer play];
    [self.playingRollView setRollPlayingPlayStatus:XZPlayingRollViewActionTypeForPlaying];
}

- (void)showLrcWithPath:(NSString *)lrcPath{
    [self.lrcView initLrcViewWithPath:lrcPath];
}

- (void)showLrcWithTime:(int)time{
    [self updateProgress:time];
    [self.lrcView moveLrcWithTime:time];
}

- (void)updateProgress:(int)playingTime{
    [self.timeProgress updatePlayingTime:playingTime];
    [self.timeProgress updateProgress:playingTime];
}

- (void)congfigPlaying:(XZSongModel *)songModel{
    self.songModel = songModel;
    
    [self.timeProgress initTimeProgressData:songModel.time];
    [self.playingRollView configRooViewData:songModel.songPicBig];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    //    if (context == kStatusKVOKey) {
    //        [self performSelector:@selector(_updateStatus)
    //                     onThread:[NSThread mainThread]
    //                   withObject:nil
    //                waitUntilDone:NO];
    //    }
    //    else if (context == kDurationKVOKey) {
    //        [self performSelector:@selector(_timerAction:)
    //                     onThread:[NSThread mainThread]
    //                   withObject:nil
    //                waitUntilDone:NO];
    //    }
    //    else if (context == kBufferingRatioKVOKey) {
    //        [self performSelector:@selector(_updateBufferingStatus)
    //                     onThread:[NSThread mainThread]
    //                   withObject:nil
    //                waitUntilDone:NO];
    //    }
    //    else {
    //        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    //    }
}

#pragma mark - XZPlayingRollViewDelegate
- (void)playingRollViewAction:(enum XZPlayingRollViewActionType)actionType{
    if (actionType == XZPlayingRollViewActionTypeForPlaying) {
        [self.audioPlayer play];
        [self.playingRollView setRollPlayingPlayStatus:XZPlayingRollViewActionTypeForPlaying];
    }else {
        [self.audioPlayer pause];
        [self.playingRollView setRollPlayingPlayStatus:XZPlayingRollViewActionTypeForPause];
    }
}

@end
