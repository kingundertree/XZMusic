//
//  XZBaseTable.h
//  XZMusic
//
//  Created by xiazer on 14/11/8.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ENUM(NSInteger, XZBaseTableStatus){
    XZBaseTableStatusNoral, // 普通状态
    XZBaseTableStatusRefresh, // 刷新数据
    XZBaseTableStatusLoadingNextPageData // 加载下一页数据
};

@protocol XZBaseTableEventDelegate <NSObject>
- (void)tableStatus:(enum XZBaseTableStatus)status;
- (void)didSelect:(id)data indexPath:(NSIndexPath *)indexPath;
@end

@interface XZBaseTable : UITableView <UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, assign) id<XZBaseTableEventDelegate> eventDelegate;
@property(nonatomic, assign) BOOL isConMore;
@property(nonatomic, assign) BOOL isHasNextPage;
@property(nonatomic, strong) NSMutableArray *tableData;
@property(nonatomic, assign) NSInteger cellHeight;
@property(nonatomic, assign) BOOL isLoading;
@property(nonatomic, strong) UIRefreshControl *refreshControl;


- (void)addRefreshView;
- (void)endRefresh:(id)data;
@end
