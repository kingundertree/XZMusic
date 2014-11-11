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

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitleViewWithString:[NSString stringWithFormat:@"%@-playing",self.musicSongModel.title]];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self requestSongInfo];
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
            }
        }else if (response.status == XZNetWorkingResponseStatusNetError){
            [this showTips:@"请检查网络"];
        }else{
            DLog(@"获取歌曲信息失败");
        };
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
