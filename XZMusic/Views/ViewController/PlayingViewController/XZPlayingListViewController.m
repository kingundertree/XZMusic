//
//  XZPlayingListViewController.m
//  XZMusic
//
//  Created by xiazer on 14/12/2.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "XZPlayingListViewController.h"
#import "XZSongCell.h"
#import "XZTableForSingerSongsList.h"
#import "XZMusicPlayViewController.h"

@interface XZPlayingListViewController () <UITableViewDataSource, UITableViewDelegate>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *tableData;
@end

@implementation XZPlayingListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitleViewWithString:@"播放列表"];
    // Do any additional setup after loading the view.
    
    [self initUI];
}

- (void)initUI{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
    self.tableData = [XZGlobalManager shareInstance].musicArr;
    [self.tableView reloadData];
}

- (void)setSongListType:(SongListType)songListType
{
    _songListType = songListType;
}

#pragma mark -
#pragma mark - UIDataSourceDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentify = @"cell";
    XZSongCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[XZSongCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
        cell.cellType = CellTypeForNormal;
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    
    id data = [self.tableData objectAtIndex:indexPath.row];
    
    [cell configCell:data];
    
    return cell;
}

#pragma mark -
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    id data = [self.tableData objectAtIndex:indexPath.row];

    [self dismissViewControllerAnimated:YES completion:^{
        if ([data isKindOfClass:[XZMusicSongModel class]]) {
            XZMusicSongModel *singerInfoMode = (XZMusicSongModel *)data;
            
            if (![[XZGlobalManager shareInstance].playMusicId isEqualToString:[NSString stringWithFormat:@"%lld",singerInfoMode.song_id]]) {
                XZMusicPlayViewController *playVC = [XZMusicPlayViewController shareInstance];
                [playVC playingMusicWithSong:singerInfoMode];
                
                // 设置全局播放数据
                [XZGlobalManager shareInstance].isPlaying = YES;
                [XZGlobalManager shareInstance].playIndex = indexPath.row;
                [XZGlobalManager shareInstance].playMusicId = [NSString stringWithFormat:@"%lld",singerInfoMode.song_id];
            }
        } else if ([data isKindOfClass:[XZMusicInfo class]]) {
            XZMusicInfo *musicInfo = (XZMusicInfo *)data;
            
            if (![[XZGlobalManager shareInstance].playMusicId isEqualToString:musicInfo.musicId]) {
                XZMusicPlayViewController *playVC = [XZMusicPlayViewController shareInstance];
                [playVC playingMusicWithExistSong:musicInfo];
                
                // 设置全局播放数据
                [XZGlobalManager shareInstance].isPlaying = YES;
                [XZGlobalManager shareInstance].playIndex = indexPath.row;
                [XZGlobalManager shareInstance].playMusicId = musicInfo.musicId;
            }
        }
    }];
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
