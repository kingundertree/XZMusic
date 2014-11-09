//
//  XZTableForSingerList.m
//  XZMusic
//
//  Created by xiazer on 14/11/9.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "XZTableForSingerList.h"
#import "XZSingerInfoCell.h"
#import "XZMusicSingerModel.h"

@implementation XZTableForSingerList

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
    }
    return self;
}

#pragma mark -
#pragma mark - UIDataSourceDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentify = @"cell";
    XZSingerInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[XZSingerInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    
    XZMusicSingerModel *singerInfoMode = (XZMusicSingerModel *)[self.tableData objectAtIndex:indexPath.row];
    
    [cell configCell:singerInfoMode];
    
    return cell;
}

#pragma mark -
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (self.eventDelegate && [self.eventDelegate respondsToSelector:@selector(didSelect:indexPath:)]) {
        XZMusicSingerModel *singerInfoMode = (XZMusicSingerModel *)[self.tableData objectAtIndex:indexPath.row];

        [self.eventDelegate didSelect:singerInfoMode indexPath:indexPath];
    }
}

@end
