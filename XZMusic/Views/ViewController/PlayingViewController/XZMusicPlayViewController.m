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
#import "XZMusicDownloadCenter.h"

static void *kStatusKVOKey = &kStatusKVOKey;
static void *kDurationKVOKey = &kDurationKVOKey;
static void *kBufferingRatioKVOKey = &kBufferingRatioKVOKey;


@interface XZMusicPlayViewController ()
@property(nonatomic, strong) XZMusicRequestForMisicSongInfoManager *musicSongInfoRequest;
@property(nonatomic, strong) XZSongModel *songModel;

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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitleViewWithString:[NSString stringWithFormat:@"%@-playing",self.musicSongModel.title]];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initData];
}

- (void)initData{
    self.playSongModel = [[XZPlaySongModel alloc] init];
}

- (void)playingMusicWithSong:(XZMusicSongModel *)musicSongModel{
    self.musicSongModel = musicSongModel;
    [self requestSongInfo];
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
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSArray *myPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *myDocPath = [myPaths objectAtIndex:0];

    NSString *path = [myDocPath stringByAppendingString:[NSString stringWithFormat:@"/music/%lld/%lld.%@",self.songModel.songId,self.songModel.songId,self.songModel.format]];

    if ([fileManager fileExistsAtPath:path]) {
        self.playSongModel.audioFileURL = [NSURL fileURLWithPath:path];
    }else {
        self.playSongModel.audioFileURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@",self.songModel.songLink]];
    }

    return YES;
}

- (void)playMusic{
    self.audioPlayer = [DOUAudioStreamer streamerWithAudioFile:self.playSongModel];
    [self.audioPlayer addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:kStatusKVOKey];
    [self.audioPlayer addObserver:self forKeyPath:@"duration" options:NSKeyValueObservingOptionNew context:kDurationKVOKey];
    [self.audioPlayer addObserver:self forKeyPath:@"bufferingRatio" options:NSKeyValueObservingOptionNew context:kBufferingRatioKVOKey];
    
    [self.audioPlayer play];
    
    // 下载歌词
    [self downloadMusic:[NSString stringWithFormat:@"%lld",self.songModel.songId] format:self.songModel.format   musciUrlStr:self.songModel.songLink downloadType:XZMusicDownloadtypeForMusic];
    // 下载歌曲
    NSString *lrcUrl = [NSString stringWithFormat:@"http://ting.baidu.com%@",self.songModel.lrcLink];
    [self downloadMusic:[NSString stringWithFormat:@"%lld",self.songModel.songId] format:self.songModel.format  musciUrlStr:lrcUrl downloadType:XZMusicDownloadtypeForLrc];
}

- (void)downloadMusic:(NSString *)musicId format:(NSString *)format musciUrlStr:(NSString *)musciUrlStr downloadType:(enum XZMusicDownloadtype)downloadType {
    NSString *identify = [[NSProcessInfo processInfo] globallyUniqueString];
    [[XZMusicDownloadCenter shareInstance] downloadMusicWithMusicId:musicId format:format musicUrlStr:musciUrlStr identify:identify downloadType:downloadType downloadBlock:^(XZMusicDownloadResponse *response) {
        DLog(@"response---->>%ld/%f/%@",response.downloadStatus,response.progress,response.downloadIdentify);
        
        if (response.downloadStyle == XZMusicdownloadStyleForMusic) {
            if (response.downloadStatus == XZMusicDownloadSuccess) {
                DLog(@"music下载=========下载成功");
            }else if (response.downloadStatus == XZMusicDownloadIng) {
                DLog(@"music下载=========正在下载中...");
            }else if (response.downloadStatus == XZMusicDownloadFail) {
                DLog(@"music下载=========下载失败");
            }else if (response.downloadStatus == XZMusicDownloadNetError) {
                DLog("music下载=========网络错误");
            }
        }else{
            if (response.downloadStatus == XZMusicDownloadSuccess) {
                DLog(@"歌词下载=========下载成功");
            }else if (response.downloadStatus == XZMusicDownloadIng) {
                DLog(@"歌词下载=========正在下载中...");
            }else if (response.downloadStatus == XZMusicDownloadFail) {
                DLog(@"歌词下载=========下载失败");
            }else if (response.downloadStatus == XZMusicDownloadNetError) {
                DLog("歌词下载=========网络错误");
            }
        }
    }];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
