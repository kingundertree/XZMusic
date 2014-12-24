//
//  XZMusicPlayingView.m
//  XZMusic
//
//  Created by xiazer on 14/12/1.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "XZMusicPlayingView.h"
#import "XZGlobalManager.h"
#import "XZMusicDownloadCenter.h"
#import "XZMusicFileManager.h"
#import "XZMusicPlayViewController.h"
#import "XZMusicSongModel.h"

static void *kStatusKVOKey = &kStatusKVOKey;
static void *kDurationKVOKey = &kDurationKVOKey;
static void *kBufferingRatioKVOKey = &kBufferingRatioKVOKey;


@interface XZMusicPlayingView ()
@property(nonatomic, strong) XZMusicLrcView *lrcView;
@property(nonatomic, strong) XZMusicInfo *musicInfo;
@property(nonatomic, strong) NSTimer *timer;
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

- (NSTimer *)timer {
    if (_timer) {
        [_timer invalidate];
    }
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(musicPlaying) userInfo:nil repeats:YES];

    return _timer;
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
    [self.timer fire];
}

- (void)initUI{
    [self addSubview:self.timeProgress];
    [self addSubview:self.lrcView];
    [self addSubview:self.playingRollView];
    [self addSubview:self.playingMoreView];
}

- (void)musicPlaying{
    if ([XZMusicFileManager isHasMusicOrLrc:NO songModel:self.musicInfo]) {
        int time = self.audioPlayer.currentTime;
        [self.lrcView moveLrcWithTime:time];
        [self updateProgress:time];
    }
}

#pragma mark - method
- (void)playMusic:(XZPlaySongModel *)songMode{
    [self emptyAudio];
    
    self.audioPlayer = [DOUAudioStreamer streamerWithAudioFile:songMode];
    [self.audioPlayer addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:kStatusKVOKey];
    [self.audioPlayer addObserver:self forKeyPath:@"duration" options:NSKeyValueObservingOptionNew context:kDurationKVOKey];
    [self.audioPlayer addObserver:self forKeyPath:@"bufferingRatio" options:NSKeyValueObservingOptionNew context:kBufferingRatioKVOKey];
    
    [self.audioPlayer play];
    [self.playingRollView setRollPlayingPlayStatus:XZPlayingRollViewActionTypeForPlaying];
}

- (void)emptyAudio {
    if (self.audioPlayer) {
        [self.audioPlayer pause];
        [self.audioPlayer removeObserver:self forKeyPath:@"status"];
        [self.audioPlayer removeObserver:self forKeyPath:@"duration"];
        [self.audioPlayer removeObserver:self forKeyPath:@"bufferingRatio"];
        self.audioPlayer = nil;
    }
}

- (void)showLrcWithPath:(NSString *)lrcPath{
    [self.lrcView initLrcViewWithPath:lrcPath];
}


- (void)updateProgress:(int)playingTime{
    [self.timeProgress updatePlayingTime:playingTime];
    [self.timeProgress updateProgress:playingTime];
}

- (void)congfigPlaying:(XZMusicInfo *)songModel{
    self.musicInfo = songModel;
    
    [self.timeProgress initTimeProgressData:[self.musicInfo.musicTime intValue]];
    [self.playingRollView configRooViewData:self.musicInfo.musicBigImgUrl];
    [self.playingMoreView configData];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
        if (context == kStatusKVOKey) {
            [self performSelector:@selector(updatePlayingStatus)
                         onThread:[NSThread mainThread]
                       withObject:nil
                    waitUntilDone:NO];
        }
        else if (context == kDurationKVOKey) {
            [self performSelector:@selector(musicPlaying)
                         onThread:[NSThread mainThread]
                       withObject:nil
                    waitUntilDone:NO];
        }
        else if (context == kBufferingRatioKVOKey) {
            [self performSelector:@selector(updateBufferingStatus)
                         onThread:[NSThread mainThread]
                       withObject:nil
                    waitUntilDone:NO];
        }
        else {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
}

- (void)downloadMusic {
    NSString *identify = [[NSProcessInfo processInfo] globallyUniqueString];
    __weak XZMusicPlayingView *this =self;
    
    [[XZGlobalManager shareInstance] updateMusicDownInfo:self.musicInfo];
    [[XZGlobalManager shareInstance] setValue:[XZGlobalManager shareInstance].musicDownArr forKey:@"musicDownArr"];

    [[XZMusicDownloadCenter shareInstance] downloadMusicWithMusicId:[NSString stringWithFormat:@"%@",self.musicInfo.musicId] format:self.musicInfo.musicFormat musicUrlStr:self.musicInfo.musicSongUrl identify:identify downloadType:XZMusicDownloadtypeForMusic downloadBlock:^(XZMusicDownloadResponse *response) {
        DLog(@"response---->>%ld/%f/%@",(long)response.downloadStatus,response.progress,response.downloadIdentify);
        
        if (response.downloadStyle == XZMusicdownloadStyleForMusic) {
            if (response.downloadStatus == XZMusicDownloadSuccess) {
                DLog(@"music下载=========下载成功");
                [this.playingMoreView showCircleProgress:1.0];
                [[XZMusicCoreDataCenter shareInstance] updateMusicInfo:[NSString stringWithFormat:@"%@",self.musicInfo.musicId] isMusicDown:YES];
           
                self.musicInfo.downProgress = 1.0;
                [[XZGlobalManager shareInstance] updateMusicDownInfo:self.musicInfo];
            }else if (response.downloadStatus == XZMusicDownloadIng) {
                DLog(@"music下载=========正在下载中...");
                DLog(@"response.progress --->>%f",response.progress);
                [this.playingMoreView showCircleProgress:response.progress];
                
                self.musicInfo.downProgress = response.progress;
                [[XZGlobalManager shareInstance] updateMusicDownInfo:self.musicInfo];
            }else if (response.downloadStatus == XZMusicDownloadFail) {
                DLog(@"music下载=========下载失败");
                self.musicInfo.downProgress = -1.0;
                [[XZGlobalManager shareInstance] updateMusicDownInfo:self.musicInfo];
            }else if (response.downloadStatus == XZMusicDownloadNetError) {
                DLog("music下载=========网络错误");
                self.musicInfo.downProgress = -2.0;
                [[XZGlobalManager shareInstance] updateMusicDownInfo:self.musicInfo];
            }
        }
    }];
}

#pragma mark - playingKVO
- (void)updatePlayingStatus {
    switch ([self.audioPlayer status]) {
        case DOUAudioStreamerPlaying:
            
            break;
        case DOUAudioStreamerPaused:
            
            break;
        case DOUAudioStreamerIdle:
            
            break;
        case DOUAudioStreamerFinished:
            [[XZMusicCoreDataCenter shareInstance] updateMusicInfoForPlayedCount:self.musicInfo.musicId];

            [self getNextMusic];
            break;
        case DOUAudioStreamerBuffering:
            
            break;
        case DOUAudioStreamerError:
            
            break;
            
        default:
            break;
    }
}

- (void)updateBufferingStatus {
    
}

#pragma mark - XZPlayingRollViewDelegate
- (void)playingRollViewAction:(enum XZPlayingRollViewActionType)actionType{
    if (actionType == XZPlayingRollViewActionTypeForPlaying) {
        [self.timer fire];
        [self.audioPlayer play];
        [self.playingRollView setRollPlayingPlayStatus:XZPlayingRollViewActionTypeForPlaying];
    }else {
        [self.timer invalidate];
        [self.audioPlayer pause];
        [self.playingRollView setRollPlayingPlayStatus:XZPlayingRollViewActionTypeForPause];
    }
}

#pragma mark - XZPlayMoreFuncViewDelegate
- (void)funcViewAction:(enum XZPlayMoreFuncViewActionType)actionType {
    if (actionType == XZPlayMoreFuncViewActionTypeForDown) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self downloadMusic];
        });
    } else if (actionType == XZPlayMoreFuncViewActionTypeForPre) {
        [self getPreMusic];
    } else if (actionType == XZPlayMoreFuncViewActionTypeForNext) {
        [self getNextMusic];
    }
}

- (void)getPreMusic {
    XZMusicPlayViewController *playVC = [XZMusicPlayViewController shareInstance];
    
    if ([XZGlobalManager shareInstance].playIndex == 0) {
        DLog(@"已经是第一首了");
        [XZGlobalManager shareInstance].playIndex -= [XZGlobalManager shareInstance].musicArr.count-1;
        XZMusicSongModel *singerInfoMode = (XZMusicSongModel *)[[XZGlobalManager shareInstance].musicArr objectAtIndex:[XZGlobalManager shareInstance].playIndex];
        
        [playVC playingMusicWithSong:singerInfoMode];
    } else {
        [XZGlobalManager shareInstance].playIndex -= 1;
        XZMusicSongModel *singerInfoMode = (XZMusicSongModel *)[[XZGlobalManager shareInstance].musicArr objectAtIndex:[XZGlobalManager shareInstance].playIndex];
        
        [playVC playingMusicWithSong:singerInfoMode];
    }
}

- (void)getNextMusic {
    XZMusicPlayViewController *playVC = [XZMusicPlayViewController shareInstance];
    
    if ([XZGlobalManager shareInstance].playIndex == [XZGlobalManager shareInstance].musicArr.count-1) {
        DLog(@"已经是最后一首了");

        [XZGlobalManager shareInstance].playIndex = 0;
        XZMusicSongModel *singerInfoMode = (XZMusicSongModel *)[[XZGlobalManager shareInstance].musicArr objectAtIndex:[XZGlobalManager shareInstance].playIndex];
        
        [playVC playingMusicWithSong:singerInfoMode];
    } else {
        [XZGlobalManager shareInstance].playIndex += 1;
        XZMusicSongModel *singerInfoMode = (XZMusicSongModel *)[[XZGlobalManager shareInstance].musicArr objectAtIndex:[XZGlobalManager shareInstance].playIndex];
        
        [playVC playingMusicWithSong:singerInfoMode];
    }
}

@end
