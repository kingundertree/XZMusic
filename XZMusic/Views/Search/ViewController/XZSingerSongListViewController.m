//
//  XZSingerSongListViewController.m
//  XZMusic
//
//  Created by xiazer on 14/11/8.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "XZSingerSongListViewController.h"
#import "XZTableForSingerSongsList.h"
#import "XZMusicReuqestForSingerSongsManager.h"
#import "XZMusicSongModel.h"
#import "XZSingerSongsInfoConvertOb.h"
#import "XZSongCell.h"
#import "XZTableMoreCell.h"
#import "XZMusicPlayViewController.h"

@interface XZSingerSongListViewController () <XZBaseTableEventDelegate>
@property(nonatomic, strong) XZMusicReuqestForSingerSongsManager *singerSongsRequest;
@property(nonatomic, assign) BOOL isHaseNext;
@property(nonatomic, assign) NSInteger songsNum;
@property(nonatomic, assign) NSInteger totalSongsNum;
@property(nonatomic, strong) XZTableForSingerSongsList *tableView;
@property(nonatomic, strong) NSMutableArray *singerSongsArr;
@end

@implementation XZSingerSongListViewController

- (XZMusicReuqestForSingerSongsManager *)singerSongsRequest{
    if (!_singerSongsRequest) {
        _singerSongsRequest = [[XZMusicReuqestForSingerSongsManager alloc] init];
    }
    return _singerSongsRequest;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initData];
    [self initUI];
    
    [self setTitleViewWithString:self.singerInfoModel.name];
    
    [self addRightButton:@"Play"];
}


- (void)rightButtonAction:(id)sender
{
    XZMusicPlayViewController *musicPlayVC = [XZMusicPlayViewController shareInstance];
    musicPlayVC.backType = BackTypePopBack;
    [self.navigationController pushViewController:musicPlayVC animated:YES];
}

- (void)viewDidAppear:(BOOL)animated{
}

- (void)initData{
    self.singerSongsArr = [NSMutableArray array];
    self.totalSongsNum = self.singerInfoModel.songs_total;
    
    if (self.singerInfoModel.songs_total <= 20) {
        self.songsNum = self.singerInfoModel.songs_total;
    }else{
        self.songsNum = 20;
    }
}

- (void)initUI{
    self.tableView = [[XZTableForSingerSongsList alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64) style:UITableViewStylePlain];
    self.tableView.isConMore = YES;
    self.tableView.cellHeight = 80;
    self.tableView.eventDelegate = self;
    [self.tableView addRefreshView];
    [self.view addSubview:self.tableView];
    
    self.tableView.cellHeight = 80.0;
    
    [self getSingerSongs];
}

#pragma mark - UITableViewEventDelegate
- (void)didSelect:(id)data indexPath:(NSIndexPath *)indexPath{
    if (self.navigationController.view.frame.origin.x != 0) {
        return;
    }

    XZMusicSongModel *singerInfoMode = (XZMusicSongModel *)[self.singerSongsArr objectAtIndex:indexPath.row];

    XZMusicPlayViewController *playVC = [XZMusicPlayViewController shareInstance];
    if ([[XZGlobalManager shareInstance].playMusicId isEqualToString:[NSString stringWithFormat:@"%lld",singerInfoMode.song_id]] && [XZGlobalManager shareInstance].isPlaying) {
        [self.navigationController pushViewController:playVC animated:YES];
    } else {
        [playVC playingMusicWithSong:singerInfoMode];
        [XZGlobalManager shareInstance].isPlaying = YES;
        [XZGlobalManager shareInstance].playIndex = indexPath.row;
        // 设置全局播放数据
        [XZGlobalManager shareInstance].musicArr = self.singerSongsArr;
        [XZGlobalManager shareInstance].playMusicId = [NSString stringWithFormat:@"%lld",singerInfoMode.song_id];
        
        [self.navigationController pushViewController:playVC animated:YES];
    }
}

- (void)tableStatus:(enum XZBaseTableStatus)status{
    if (status == XZBaseTableStatusLoadingNextPageData) {
        [self getSingerSongs];
    }else if (status == XZBaseTableStatusRefresh){
        if (self.singerInfoModel.songs_total <= 20) {
            self.songsNum = self.singerInfoModel.songs_total;
        }else{
            self.songsNum = 20;
        }
        [self getSingerSongs];
    }
}

#pragma mark --Request
- (void)getSingerSongs{
    [self showLoading];
    self.isLoading = YES;
    self.tableView.isLoading = YES;
    
    NSDictionary *params = @{@"tinguid":[NSString stringWithFormat:@"%lld",self.singerInfoModel.ting_uid], @"limits":[NSString stringWithFormat:@"%ld",(long)self.songsNum]};
    
    __weak XZSingerSongListViewController *this = self;
    [self.singerSongsRequest requestForSingerSongsBlock:params block:^(XZRequestResponse *response) {
        [self hideLoading];
        self.isLoading = NO;
        self.tableView.isLoading = NO;

        if (response.status == XZNetWorkingResponseStatusSuccess) {
            if ([response.content isKindOfClass:[NSDictionary class]]) {
                NSArray *songsArr = [NSArray arrayWithArray:response.content[@"songlist"]];
                self.singerSongsArr = [XZSingerSongsInfoConvertOb converSongsListToArr:songsArr];
                if (self.singerSongsArr.count < self.totalSongsNum) {
                    self.isHaseNext = YES;
                }else{
                    self.isHaseNext = NO;
                }
                
                self.tableView.tableData = self.singerSongsArr;
                self.tableView.isHasNextPage = self.isHaseNext;
                
                if (self.singerSongsArr.count > 0) {
                    [self.tableView reloadData];
                    
                    [self.tableView.refreshControl endRefreshing];
                    self.songsNum += 20;
                }
                
            }
        }else if (response.status == XZNetWorkingResponseStatusNetError){
            [this showTips:@"请检查网络"];
        }else{
            DLog(@"获取歌手歌曲列表获取失败");
        };
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
