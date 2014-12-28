//
//  XZLovingViewController.m
//  XZMusic
//
//  Created by xiazer on 14-8-31.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "XZLovingViewController.h"
#import "XZSingerSongsCell.h"

@interface XZLovingViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableList;
@property (nonatomic, strong) NSMutableArray *tableData;
@end

@implementation XZLovingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.tableData = [[NSMutableArray alloc] initWithArray:[[XZMusicCoreDataCenter shareInstance] fetchAllMusicByPlayedTimeRank]];
    if (self.tableList) {
        [self.tableList reloadData];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self setTitleViewWithString:@"最爱"];
    [self addRightButton:@"play"];
    
    [self initData];
    [self initUI];
    
    // Do any additional setup after loading the view.
}

- (void)rightButtonAction:(id)sender
{
    XZMusicPlayViewController *musicPlayVC = [XZMusicPlayViewController shareInstance];
    [self.navigationController pushViewController:musicPlayVC animated:YES];
}

- (void)initData
{
}

- (void)initUI
{
    self.tableList = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64)];
    self.tableList.dataSource = self;
    self.tableList.delegate = self;
    [self.view addSubview:self.tableList];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentify = @"cell";
    XZSingerSongsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[XZSingerSongsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
        cell.cellType = CellTypeForLoving;
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    
    XZMusicInfo *singerInfoMode = (XZMusicInfo *)[self.tableData objectAtIndex:indexPath.row];
    
    [cell configCell:singerInfoMode];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    XZMusicInfo *musicInfo = (XZMusicInfo *)[self.tableData objectAtIndex:indexPath.row];
    
    XZMusicPlayViewController *musicPlayVC = [XZMusicPlayViewController shareInstance];
    
    [XZGlobalManager shareInstance].isPlaying = YES;
    // 设置全局播放数据
    [XZGlobalManager shareInstance].musicArr = self.tableData;
    [XZGlobalManager shareInstance].playMusicId = [NSString stringWithFormat:@"%@",musicInfo.musicId];
    [XZGlobalManager shareInstance].playIndex = indexPath.row;

    musicPlayVC.backType = BackTypePopBack;
    [musicPlayVC playingMusicWithExistSong:musicInfo];
    [self.navigationController pushViewController:musicPlayVC animated:YES];
}

#pragma mark
#pragma leftButtonAction
- (void)doBack:(id)sender{
    [[XZAppDelegate sharedAppDelegate].menuMainVC mainVCLeftMenuAction];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
