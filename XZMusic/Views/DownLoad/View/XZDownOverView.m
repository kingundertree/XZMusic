//
//  XZDownOverView.m
//  XZMusic
//
//  Created by xiazer on 14/12/17.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "XZDownOverView.h"
#import "XZSingerSongsCell.h"

@interface XZDownOverView () <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *downloadMusicArray;
@end

@implementation XZDownOverView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blueColor];
        [self initData];
        [self initUI];
    }
    return self;
}

- (void)initData
{
    self.downloadMusicArray = [NSMutableArray new];
    self.downloadMusicArray = [NSMutableArray arrayWithArray:[[XZMusicCoreDataCenter shareInstance] fetchAllMusic]];

    if (self.downOverDelegate && [self.downOverDelegate respondsToSelector:@selector(downOverMusicNum:)]) {
        [self.downOverDelegate downOverMusicNum:self.downloadMusicArray.count];
    }
    [self.tableView reloadData];
}

- (UITableView *)tableView{
    if (!_tableView) {
        self.tableView = [[UITableView alloc] initWithFrame:self.bounds];
        self.tableView.dataSource = self;
        self.tableView.delegate = self;

        [self addSubview:self.tableView];
    }
    
    return _tableView;
}

- (void)initUI
{
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.downloadMusicArray.count;
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
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    
    XZMusicInfo *singerInfoMode = (XZMusicInfo *)[self.downloadMusicArray objectAtIndex:indexPath.row];
    
    [cell configCell:singerInfoMode];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (self.downOverDelegate && [self.downOverDelegate respondsToSelector:@selector(downOverMusicNum:)]) {
        [self.downOverDelegate didSelectMusicInfo:indexPath.row musicInfo:[self.downloadMusicArray objectAtIndex:indexPath.row]];
    }
}

@end
