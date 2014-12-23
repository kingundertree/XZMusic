//
//  XZDowningView.m
//  XZMusic
//
//  Created by xiazer on 14/12/17.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "XZDowningView.h"
#import "XZDownloadIngCell.h"

@interface XZDowningView () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *tableData;
@end

@implementation XZDowningView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor greenColor];
        [self initUI];
        [self initData];
    }
    return self;
}


- (void)initUI
{
    self.tableView = [[UITableView alloc] initWithFrame:self.bounds];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self addSubview:self.tableView];
}

- (void)initData
{
    self.tableData = [[NSMutableArray alloc] initWithArray:[XZGlobalManager shareInstance].musicDownArr];
    [self.tableView reloadData];
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
    XZDownloadIngCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[XZDownloadIngCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    
    XZMusicInfo *musicInfo = (XZMusicInfo *)[self.tableData objectAtIndex:indexPath.row];
    
    [cell configCell:musicInfo];
    
    return cell;}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
