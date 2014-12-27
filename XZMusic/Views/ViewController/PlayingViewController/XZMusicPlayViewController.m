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
#import "XZPlayingListViewController.h"
#import "XZGlobalManager.h"
#import "XZMusicFileManager.h"

@interface XZMusicPlayViewController () 
@property(nonatomic, strong) XZMusicRequestForMisicSongInfoManager *musicSongInfoRequest;
@property(nonatomic, strong) XZSongModel *songModel;
@property(nonatomic, strong) XZMusicInfo *musicInfo;
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

- (XZMusicPlayingView *)musicPlayIngView{
    if (!_musicPlayIngView) {
        _musicPlayIngView = [[XZMusicPlayingView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64)];
    }
    
    return _musicPlayIngView;
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
        self.playSongModel = [[XZPlaySongModel alloc] init];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addRightButton:@"列表"];
    
    self.view.backgroundColor = [UIColor whiteColor];

    [self initUI];
    [self initData];
}

- (void)doBack:(id)sender {
    [super doBack:sender];
    if ([self.musicPlayIngView.audioPlayer status] == DOUAudioStreamerPaused || [self.musicPlayIngView.audioPlayer status] == DOUAudioStreamerFinished) {
        [XZGlobalManager shareInstance].isPlaying = NO;
    }
}

- (void)initData{
//    self.playSongModel = [[XZPlaySongModel alloc] init];
}

- (void)initUI{
    [self.view addSubview:self.musicPlayIngView];
}

- (void)playingMusicWithSong:(XZMusicSongModel *)musicSongModel{
    self.musicSongModel = musicSongModel;
    if ([[XZMusicCoreDataCenter shareInstance] isMusicExit:[NSString stringWithFormat:@"%lld",self.musicSongModel.song_id]]) {
        self.musicInfo = [[XZMusicCoreDataCenter shareInstance] fetchMusicInfo:[NSString stringWithFormat:@"%lld",self.musicSongModel.song_id]];
        if ([self initPlaySong]) {
            [self createPlayView];
        }
    } else {
        [self requestSongInfo];
    }
}

- (void)playingMusicWithExistSong:(XZMusicInfo *)musicInfo
{
    self.musicInfo = musicInfo;
    if ([self initPlaySong]) {
        [self createPlayView];
    }
}

- (void)requestSongInfo{
    [self showLoading];
    
    NSDictionary *params = @{@"songIds":[NSString stringWithFormat:@"%lld",self.musicSongModel.song_id]};
    
    __weak XZMusicPlayViewController *this = self;
    [self.musicSongInfoRequest requestForMusicSongInfoBlock:params block:^(XZRequestResponse *response) {
        [self hideLoading];
        if (response.status == XZNetWorkingResponseStatusSuccess) {
            if ([response.content isKindOfClass:[NSDictionary class]]) {
                DLog(@"response.content---->>%@",response.content);
                self.musicInfo = [[XZMusicCoreDataCenter shareInstance] saveNewMusicInfo:response.content];
                
                if ([self initPlaySong]) {
                    [self createPlayView];
                }
            }
        }else if (response.status == XZNetWorkingResponseStatusNetError){
            [this showTips:@"请检查网络"];
        } else {
            DLog(@"获取歌曲信息失败");
        };
    }];
}

- (void)createPlayView{
    [[XZMusicCoreDataCenter shareInstance] updateMusicInfoForPlayCount:[NSString stringWithFormat:@"%@",self.musicInfo.musicId]];

    [XZGlobalManager shareInstance].playMusicId = self.musicInfo.musicId;
    [self setTitleViewWithString:[NSString stringWithFormat:@"%@-playing",self.musicInfo.musicName]];

    [self.musicPlayIngView playMusic:self.playSongModel];
    [self.musicPlayIngView congfigPlaying:self.musicInfo];
    [self initLrcView];
}

- (BOOL)initPlaySong{
    self.playSongModel.artist = self.musicInfo.musicSonger;
    self.playSongModel.title = self.musicInfo.musicName;
    
   NSString *musicPath = [XZMusicFileManager getMusicPath:self.musicInfo];
    if ([self.musicInfo.musicIsDown boolValue]) {
        self.playSongModel.audioFileURL = [NSURL fileURLWithPath:musicPath];
        [XZGlobalManager shareInstance].isNeedDown = NO;
    }else {
        self.playSongModel.audioFileURL = [NSURL URLWithString:self.musicInfo.musicSongUrl];
        [XZGlobalManager shareInstance].isNeedDown = YES;
    }

    return YES;
}

- (void)downloadLrc{
    // 下载歌词
    if (!self.musicInfo.musicLrcUrl || self.musicInfo.musicLrcUrl.length == 0) {
        [self showTips:@"暂无歌词"];
        
        return;
    }
    NSString *lrcUrl = [NSString stringWithFormat:@"http://ting.baidu.com%@",self.musicInfo.musicLrcUrl];
    
    DLog(@"lrcUrl--->%@",lrcUrl);
    [self downloadMusic:[NSString stringWithFormat:@"%@",self.musicInfo.musicId] format:self.musicInfo.musicFormat musicUrlStr:lrcUrl downloadType:XZMusicDownloadtypeForLrc];
}

- (void)downloadMusic:(NSString *)musicId format:(NSString *)format musicUrlStr:(NSString *)musicUrlStr downloadType:(enum XZMusicDownloadtype)downloadType {
    NSString *identify = [[NSProcessInfo processInfo] globallyUniqueString];
    __weak XZMusicPlayViewController *this =self;
    [[XZMusicDownloadCenter shareInstance] downloadMusicWithMusicId:musicId format:format musicUrlStr:musicUrlStr identify:identify downloadType:downloadType downloadBlock:^(XZMusicDownloadResponse *response) {
        DLog(@"response---->>%ld/%f/%@",(long)response.downloadStatus,response.progress,response.downloadIdentify);
        
        if (response.downloadStyle == XZMusicdownloadStyleForLrc) {
            if (response.downloadStatus == XZMusicDownloadSuccess) {
                DLog(@"歌词下载=========下载成功");
                [[XZMusicCoreDataCenter shareInstance] updateMusicInfo:self.musicInfo.musicId isMusicLrcDown:YES];
                [this initLrcView];
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

- (void)initLrcView{
    if ([[XZMusicCoreDataCenter shareInstance] isMusicLrcDownload:self.musicInfo.musicId]) {
        NSString *lrcPath = [XZMusicFileManager getMusicLrcPath:self.musicInfo];
        
        [self.musicPlayIngView showLrcWithPath:lrcPath];
    }else {
        [self downloadLrc];
    }
}

- (void)rightButtonAction:(id)sender{
    XZPlayingListViewController *playingListVC = [[XZPlayingListViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:playingListVC];
    [self.navigationController presentViewController:nav animated:YES completion:^{
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

