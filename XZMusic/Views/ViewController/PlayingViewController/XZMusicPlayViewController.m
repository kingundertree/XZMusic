//
//  XZMusicPlayViewController.m
//  XZMusic
//
//  Created by xiazer on 14-8-29.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "XZMusicPlayViewController.h"
#import "XZMusicRequestForMisicSongInfoManager.h"
#import "XZMusicSongConvertToOb.h"
#import "XZMusicDownloadOperation.h"

static void *kStatusKVOKey = &kStatusKVOKey;
static void *kDurationKVOKey = &kDurationKVOKey;
static void *kBufferingRatioKVOKey = &kBufferingRatioKVOKey;


@interface XZMusicPlayViewController ()
@property(nonatomic, strong) XZMusicRequestForMisicSongInfoManager *musicSongInfoRequest;
@property(nonatomic, strong) XZSongModel *songModel;

@property(nonatomic, strong) XZMusicDownloadOperation *downloadOperation;
@end

@implementation XZMusicPlayViewController

+ (XZMusicPlayViewController *)shareInstance{
    static XZMusicPlayViewController *shareInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        shareInstance = [[self alloc] init];
    });
    
    return shareInstance;
}

- (XZMusicRequestForMisicSongInfoManager *)musicSongInfoRequest{
    if (!_musicSongInfoRequest) {
        _musicSongInfoRequest = [[XZMusicRequestForMisicSongInfoManager alloc] init];
    }
    return _musicSongInfoRequest;
}

//- (DOUAudioStreamer *)audioPlayer{
//    if (_audioPlayer) {
//        _audioPlayer = [[DOUAudioStreamer alloc] init];
//    }
//    
//    return _audioPlayer;
//}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitleViewWithString:[NSString stringWithFormat:@"%@-playing",self.musicSongModel.title]];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self requestSongInfo];
    
    [self initData];
    
    self.downloadOperation = [[XZMusicDownloadOperation alloc] init];
    [self.downloadOperation downloadMusic:@"50487351" musicUrlStr:@"http://file.qianqian.com/data2/music/50487351/50487351.mp3?xcode=0d577c2b18127bfd7f0f5f3868cf11dbe2fef199f45e9251" identify:@"xiazer" isMusic:YES downloadBlock:^(XZMusicDownloadResponse *response) {
        DLog(@"response---->>%ld/%f/%@",response.downloadStatus,response.progress,response.downloadIdentify);
    }];
}

- (void)initData{
    self.playSongModel = [[XZPlaySongModel alloc] init];
}

- (void)playingMusicWithSong:(XZMusicSongModel *)musicSongModel{
    
}

- (void)requestSongInfo{
    [self showLoading];
    
    NSDictionary *params = @{@"songIds":[NSString stringWithFormat:@"%lld",self.musicSongModel.song_id]};
    
    __weak XZMusicPlayViewController *this = self;
    [self.musicSongInfoRequest requestForMusicSongInfoBlock:params block:^(XZRequestResponse *response) {
        [self hideLoading];
        if (response.status == XZNetWorkingResponseStatusSuccess) {
            if ([response.content isKindOfClass:[NSDictionary class]]) {
                self.songModel = [XZMusicSongConvertToOb converMusicSong:response.content];
                
                if ([self initPlaySong]) {
                    [self playMusic];
                }
            }
        }else if (response.status == XZNetWorkingResponseStatusNetError){
            [this showTips:@"请检查网络"];
        }else{
            DLog(@"获取歌曲信息失败");
        };
    }];
}

- (BOOL)initPlaySong{
    self.playSongModel.artist = self.songModel.artistName;
    self.playSongModel.title = self.songModel.songName;
    self.playSongModel.audioFileURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@",self.songModel.songLink]];

    return YES;
}

- (void)playMusic{
//    self.audioPlayer = [DOUAudioStreamer streamerWithAudioFile:self.playSongModel];
    [self.audioPlayer addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:kStatusKVOKey];
    [self.audioPlayer addObserver:self forKeyPath:@"duration" options:NSKeyValueObservingOptionNew context:kDurationKVOKey];
    [self.audioPlayer addObserver:self forKeyPath:@"bufferingRatio" options:NSKeyValueObservingOptionNew context:kBufferingRatioKVOKey];
    
    [self.audioPlayer play];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == kStatusKVOKey) {
//        [self performSelector:@selector(_updateStatus)
//                     onThread:[NSThread mainThread]
//                   withObject:nil
//                waitUntilDone:NO];
    }
    else if (context == kDurationKVOKey) {
//        [self performSelector:@selector(_timerAction:)
//                     onThread:[NSThread mainThread]
//                   withObject:nil
//                waitUntilDone:NO];
    }
    else if (context == kBufferingRatioKVOKey) {
//        [self performSelector:@selector(_updateBufferingStatus)
//                     onThread:[NSThread mainThread]
//                   withObject:nil
//                waitUntilDone:NO];
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

