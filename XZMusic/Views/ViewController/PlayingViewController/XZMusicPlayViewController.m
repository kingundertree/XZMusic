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

@interface XZMusicPlayViewController ()
@property(nonatomic, strong) XZMusicRequestForMisicSongInfoManager *musicSongInfoRequest;
@property(nonatomic, strong) XZSongModel *songModel;
@property(nonatomic, strong) NSTimer *timer;
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
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitleViewWithString:[NSString stringWithFormat:@"%@-playing",self.musicSongModel.title]];
    [self addRightButton:@"列表"];
    
    self.view.backgroundColor = [UIColor whiteColor];

    [self initUI];
    [self initData];
}

- (void)initData{
    self.playSongModel = [[XZPlaySongModel alloc] init];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(musicPlaying) userInfo:nil repeats:YES];
}

- (void)initUI{
    [self.view addSubview:self.musicPlayIngView];
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
                    [self createPlayView];
                }
            }
        }else if (response.status == XZNetWorkingResponseStatusNetError){
            [this showTips:@"请检查网络"];
        }else{
            DLog(@"获取歌曲信息失败");
        };
    }];
}

- (void)createPlayView{
    [self.musicPlayIngView playMusic:self.playSongModel];
    [self.musicPlayIngView congfigPlaying:self.songModel];
    [self initLrcView];
}

- (BOOL)initPlaySong{
    self.playSongModel.artist = self.songModel.artistName;
    self.playSongModel.title = self.songModel.songName;
    
    NSArray *myPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *myDocPath = [myPaths objectAtIndex:0];

    NSString *musicPath = [myDocPath stringByAppendingString:[NSString stringWithFormat:@"/music/%lld/%lld.%@",self.songModel.songId,self.songModel.songId,self.songModel.format]];

    if ([self isHasMusicOrLrc:YES]) {
        self.playSongModel.audioFileURL = [NSURL fileURLWithPath:musicPath];
    }else {
        self.playSongModel.audioFileURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@",self.songModel.songLink]];
        [self downloadMusic];
    }

    return YES;
}



- (void)downloadMusic{
    // 下载歌曲
    [self downloadMusic:[NSString stringWithFormat:@"%lld",self.songModel.songId] format:self.songModel.format   musciUrlStr:self.songModel.songLink downloadType:XZMusicDownloadtypeForMusic];
}
- (void)downloadLrc{
    // 下载歌词
    NSString *lrcUrl = [NSString stringWithFormat:@"http://ting.baidu.com%@",self.songModel.lrcLink];
    [self downloadMusic:[NSString stringWithFormat:@"%lld",self.songModel.songId] format:self.songModel.format  musciUrlStr:lrcUrl downloadType:XZMusicDownloadtypeForLrc];
}


- (BOOL)isHasMusicOrLrc:(BOOL)isMusic{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSArray *myPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *myDocPath = [myPaths objectAtIndex:0];
    
    NSString *path;
    if (isMusic) {
        path = [myDocPath stringByAppendingString:[NSString stringWithFormat:@"/music/%lld/%lld.%@",self.songModel.songId,self.songModel.songId,self.songModel.format]];
    }else {
        path = [myDocPath stringByAppendingString:[NSString stringWithFormat:@"/music/%lld/%lld.lrc",self.songModel.songId,self.songModel.songId]];
    }
    
    if ([fileManager fileExistsAtPath:path]) {
        return YES;
    }else {
        return NO;
    }
}

- (void)downloadMusic:(NSString *)musicId format:(NSString *)format musciUrlStr:(NSString *)musciUrlStr downloadType:(enum XZMusicDownloadtype)downloadType {
    NSString *identify = [[NSProcessInfo processInfo] globallyUniqueString];
    __weak XZMusicPlayViewController *this =self;
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
    if ([self isHasMusicOrLrc:NO]) {
        NSArray *myPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *myDocPath = [myPaths objectAtIndex:0];
        
        NSString *lrcPath = [myDocPath stringByAppendingString:[NSString stringWithFormat:@"/music/%lld/%lld.lrc",self.songModel.songId,self.songModel.songId]];
        
        [self.musicPlayIngView showLrcWithPath:lrcPath];
    }else {
        [self downloadLrc];
    }
}

- (void)musicPlaying{
    if ([self isHasMusicOrLrc:NO]) {
        int time = self.musicPlayIngView.audioPlayer.currentTime;
        [self.musicPlayIngView showLrcWithTime:time];
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

