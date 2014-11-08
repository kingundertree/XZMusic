//
//  XZBaseTableForTurnPage.h
//  XZMusic
//
//  Created by xiazer on 14/11/8.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ENUM(NSInteger, XZBaseTableForTurnPageStatus){
    XZBaseTableForTurnPageStatusNoral, // 普通状态
    XZBaseTableForTurnPageStatusRefresh, // 刷新数据
    XZBaseTableForTurnPageStatusLoadingNextPageData // 加载下一页数据
};

@protocol XZBaseTableForTurnPageEventDelegate <NSObject>
- (void)tableStatus:(enum XZBaseTableForTurnPageStatus)status;
- (void)tableViewDidSelect:(id)Data indexPath:(NSIndexPath *)indexPath;
@end

@interface XZBaseTableForTurnPage : UITableView 

@property(nonatomic, assign) id<XZBaseTableForTurnPageEventDelegate> eventDelegate;
@property(nonatomic, assign) BOOL isHasNextPage;
@property(nonatomic, strong) NSMutableArray *tableData;

- (void)addRefreshView;
- (void)endRefresh:(id)data;
@end
