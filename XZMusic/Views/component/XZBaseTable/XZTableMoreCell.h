//
//  XZTableMoreCell.h
//  XZMusic
//
//  Created by xiazer on 14/11/8.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "XZBaseTableViewCell.h"

NS_ENUM(NSInteger, XZMusicMoreCellStatus){
    LoadingMoreCellStatusForReadLoading, // 准备加载下一页
    LoadingMoreCellStatusForIsLoading, // 正在下一页
    LoadingMoreCellStatusForNoNeedLoading, // 无下一页数据，无需加载
};


@interface XZTableMoreCell : XZBaseTableViewCell

@property(nonatomic, assign) enum XZMusicMoreCellStatus moreCellStatus;

@end
