//
//  XZSingerSongListViewController.m
//  XZMusic
//
//  Created by xiazer on 14/11/8.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "XZSingerSongListViewController.h"
#import "XZBaseTableForTurnPage.h"
#import "XZMusicReuqestForSingerSongsManager.h"
#import "XZMusicSongModel.h"
#import "XZSingerSongsInfoConvertOb.h"

@interface XZSingerSongListViewController () <UITableViewDataSource,UITableViewDelegate,XZBaseTableForTurnPageEventDelegate>
@property(nonatomic, strong) XZMusicReuqestForSingerSongsManager *singerSongsRequest;
@property(nonatomic, assign) BOOL isHaseNext;
@property(nonatomic, assign) NSInteger songsNum;
@property(nonatomic, strong) XZBaseTableForTurnPage *tableView;
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
}

- (void)viewDidAppear:(BOOL)animated{
}

- (void)initData{
    self.singerSongsArr = [NSMutableArray array];
    self.songsNum = 20;
}

- (void)initUI{
    self.tableView = [[XZBaseTableForTurnPage alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.eventDelegate = self;
    [self.view addSubview:self.tableView];
    
    [self getSingerSongs];
}


#pragma mark -
#pragma mark - UIDataSourceDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.singerSongsArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentify = @"cell";
//    XZSingerInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
//    if (!cell) {
//        cell = [[XZSingerInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
//    }
//    
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
//    
//    XZMusicSingerModel *singerInfoMode = (XZMusicSingerModel *)[self.singerListArr objectAtIndex:indexPath.row];
//    
//    [cell configCell:singerInfoMode];
//    
//    return cell;
    return nil;
}

#pragma mark -
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.navigationController.view.frame.origin.x != 0) {
        return;
    }
    
    [XZAppDelegate sharedAppDelegate].menuMainVC.isOnFirstView = NO;
    
//    XZMusicSingerModel *singerInfoMode = (XZMusicSingerModel *)[self.singerListArr objectAtIndex:indexPath.row];
//    XZSingerSongListViewController *singerSongListVC = [[XZSingerSongListViewController alloc] init];
//    singerSongListVC.singerInfoModel = singerInfoMode;
//    [self.navigationController pushViewController:singerSongListVC animated:YES];
}

- (void)getSingerSongs{
    NSDictionary *params = @{@"tinguid":[NSString stringWithFormat:@"%lld",self.singerInfoModel.ting_uid], @"limits":[NSString stringWithFormat:@"%ld",(long)self.songsNum]};
    
    __weak XZSingerSongListViewController *this = self;
    [self.singerSongsRequest requestForSingerSongsBlock:params block:^(XZRequestResponse *response) {
        if (response.status == XZNetWorkingResponseStatusSuccess) {
            if ([response.content isKindOfClass:[NSDictionary class]]) {
                self.isHaseNext = YES ? NO : [response.content[@"havemore"] isEqualToString:@"1"];
                NSArray *songsArr = [NSArray arrayWithArray:response.content[@"songlist"]];
                self.singerSongsArr = [XZSingerSongsInfoConvertOb converSongsListToArr:songsArr];
                
                if (self.singerSongsArr.count > 0) {
                    
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
