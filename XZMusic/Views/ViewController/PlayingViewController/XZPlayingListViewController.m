//
//  XZPlayingListViewController.m
//  XZMusic
//
//  Created by xiazer on 14/12/2.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "XZPlayingListViewController.h"
#import "XZSingerSongsCell.h"
#import "XZTableForSingerSongsList.h"
#import "XZMusicPlayViewController.h"

@interface XZPlayingListViewController () <XZBaseTableEventDelegate>
@property(nonatomic, strong) XZTableForSingerSongsList *tableView;
@end

@implementation XZPlayingListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitleViewWithString:@"播放列表"];
    // Do any additional setup after loading the view.
    
    [self initUI];
}

- (void)initUI{
    self.tableView = [[XZTableForSingerSongsList alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64) style:UITableViewStylePlain];
    self.tableView.isConMore = YES;
    self.tableView.cellHeight = 80;
    self.tableView.eventDelegate = self;
    [self.tableView addRefreshView];
    [self.view addSubview:self.tableView];
    
    self.tableView.tableData = [XZGlobalManager shareInstance].musicArr;
    [self.tableView reloadData];
}

#pragma mark - UITableViewEventDelegate
- (void)didSelect:(id)data indexPath:(NSIndexPath *)indexPath{
    [self dismissViewControllerAnimated:YES completion:^{
        if (indexPath.row != [XZGlobalManager shareInstance].playIndex) {
            XZMusicPlayViewController *playVC = [XZMusicPlayViewController shareInstance];
            XZMusicSongModel *singerInfoMode = (XZMusicSongModel *)[self.tableView.tableData objectAtIndex:indexPath.row];
            [playVC playingMusicWithSong:singerInfoMode];

            // 设置全局播放数据
            [XZGlobalManager shareInstance].playIndex = indexPath.row;
        }
    }];
}

- (void)tableStatus:(enum XZBaseTableStatus)status{
}

- (void)doBack:(id)sender{
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
