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

- (void)updateTable
{
    NSMutableArray *updateMusicArr = [[NSMutableArray alloc] initWithArray:[XZGlobalManager shareInstance].musicDownArr];
    NSMutableArray *addNewMusicInfo = [NSMutableArray new];
    
    if (updateMusicArr.count > 0) {
        if (self.tableData.count > 0) {
            for (NSInteger i = 0; i < updateMusicArr.count; i++) {
                XZMusicInfo *musicInfo = [updateMusicArr objectAtIndex:i];
                
                for (NSInteger j = 0; j < self.tableData.count; j++) {
                    XZMusicInfo *musicInfoMore  = [self.tableData objectAtIndex:j];
                    
                    if ([musicInfo.musicId isEqualToString:musicInfoMore.musicId]) {
                        NSIndexPath *path = [NSIndexPath indexPathForRow:j inSection:0];
                        XZDownloadIngCell *cell = (XZDownloadIngCell *)[self.tableView cellForRowAtIndexPath:path];
                        [cell updateDownProgress:musicInfo];

                        [self.tableData replaceObjectAtIndex:j withObject:musicInfo];
                    } else {
                        [addNewMusicInfo addObject:musicInfo];
                    }
                }
            }            
        }
    }
    
    if (addNewMusicInfo.count > 0) {
        for (NSInteger k = 0; k < addNewMusicInfo.count; k++) {
            NSIndexPath *path = [NSIndexPath indexPathForItem:0 inSection:0];
            [self.tableData insertObject:[addNewMusicInfo objectAtIndex:k] atIndex:0];
            [self.tableView insertRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationMiddle];
        }
    }
    
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
    
    if (self.downingViewDelegate && [self.downingViewDelegate respondsToSelector:@selector(didSelectMusicInfoForDowning:musicInfo:)]) {
        [self.downingViewDelegate didSelectMusicInfoForDowning:indexPath.row musicInfo:[self.tableData objectAtIndex:indexPath.row]];
    }
}

@end
