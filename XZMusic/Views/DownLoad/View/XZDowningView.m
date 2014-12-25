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
@property (nonatomic, assign) BOOL isUpdateing;
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
    [self updateTabTitle];
}

- (void)updateTable
{
    if (self.isUpdateing) {
        return;
    }
    self.isUpdateing = YES;
    NSMutableArray *updateMusicArr = [[NSMutableArray alloc] initWithArray:[XZGlobalManager shareInstance].musicDownArr];
    NSMutableArray *addNewMusicInfo = [NSMutableArray new];
    
    if (updateMusicArr.count > 0) {
        if (self.tableData.count > 0) {
            for (NSInteger i = 0; i < updateMusicArr.count; i++) {
                XZMusicInfo *musicInfo = [updateMusicArr objectAtIndex:i];

                NSInteger indexNum = [self isConMusic:self.tableData musicInfo:musicInfo];
                if (indexNum >= 0) {
                    NSIndexPath *path = [NSIndexPath indexPathForRow:indexNum inSection:0];
                    XZDownloadIngCell *cell = (XZDownloadIngCell *)[self.tableView cellForRowAtIndexPath:path];
                    [cell updateDownProgress:musicInfo];
                    DLog(@"updatedProgress--->>%f",musicInfo.downProgress);
                    
                    [self.tableData replaceObjectAtIndex:indexNum withObject:musicInfo];
                } else {
                    NSInteger addIndexNum = [self isConMusic:addNewMusicInfo musicInfo:musicInfo];
                    if (addIndexNum < 0) {
                        [addNewMusicInfo addObject:musicInfo];
                    }
                }
            }
        } else {
            self.tableData = [[NSMutableArray alloc] initWithArray:[XZGlobalManager shareInstance].musicDownArr];
            [self.tableView reloadData];
            [self updateTabTitle];
        }
    }
    
    if (addNewMusicInfo.count > 0) {
        for (NSInteger k = 0; k < addNewMusicInfo.count; k++) {
            NSIndexPath *path = [NSIndexPath indexPathForItem:0 inSection:0];
            [self.tableData insertObject:[addNewMusicInfo objectAtIndex:k] atIndex:0];
            [self.tableView insertRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationMiddle];
        }
    }
    
    self.isUpdateing = NO;
}


- (void)updateTabTitle
{
    if (self.downingViewDelegate && [self.downingViewDelegate respondsToSelector:@selector(downingMusicNum:)]) {
        [self.downingViewDelegate downingMusicNum:self.tableData.count];
    }
}

- (NSInteger)isConMusic:(NSArray *)musicArr musicInfo:(XZMusicInfo *)musicInfo
{
    NSInteger indexNum = -100;
    if (musicArr.count > 0) {
        for (NSInteger i = 0; i < musicArr.count; i++) {
            XZMusicInfo *musicInfoOne = (XZMusicInfo *)[musicArr objectAtIndex:i];
            if ([musicInfo.musicId isEqualToString:musicInfoOne.musicId]) {
                indexNum = i;
                break;
            }
        }
    } else {
        indexNum = -100;
    }
    
    return indexNum;
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
