//
//  XZTableForSingerSongsList.m
//  XZMusic
//
//  Created by xiazer on 14/11/9.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "XZTableForSingerSongsList.h"
#import "XZSingerSongsCell.h"
#import "XZMusicSongModel.h"
#import "XZTableMoreCell.h"

@implementation XZTableForSingerSongsList

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
    }
    return self;
}

#pragma mark -
#pragma mark - UIDataSourceDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.isConMore) {
        return [self.tableData count]+1;
    }
    return [self.tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row < self.tableData.count) {
        static NSString *cellIdentify = @"cell";
        XZSingerSongsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
        if (!cell) {
            cell = [[XZSingerSongsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
            cell.cellType = CellTypeForNormal;
        }
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        
        XZMusicSongModel *singerInfoMode = (XZMusicSongModel *)[self.tableData objectAtIndex:indexPath.row];
        
        [cell configCell:singerInfoMode];
        
        return cell;
    }else{
        if (self.isConMore) {
            static NSString *moreCellIdentify = @"moreCell";
            XZTableMoreCell *cell = [tableView dequeueReusableCellWithIdentifier:moreCellIdentify];
            if (!cell) {
                cell = [[XZTableMoreCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:moreCellIdentify];
            }
            
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleDefault;
            
            if (self.isHasNextPage) {
                cell.moreCellStatus = LoadingMoreCellStatusForReadLoading;
            }else{
                cell.moreCellStatus = LoadingMoreCellStatusForNoNeedLoading;
            }
            
            return cell;
        }
        return nil;
    }
}

#pragma mark -
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row < self.tableData.count) {
        return 80;
    }
    
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.eventDelegate && [self.eventDelegate respondsToSelector:@selector(didSelect:indexPath:)]) {
        XZMusicSongModel *singerInfoMode = (XZMusicSongModel *)[self.tableData objectAtIndex:indexPath.row];
        
        [self.eventDelegate didSelect:singerInfoMode indexPath:indexPath];
    }
}

@end
