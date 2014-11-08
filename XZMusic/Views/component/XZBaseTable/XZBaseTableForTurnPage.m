//
//  XZBaseTableForTurnPage.m
//  XZMusic
//
//  Created by xiazer on 14/11/8.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "XZBaseTableForTurnPage.h"

@interface XZBaseTableForTurnPage ()
@property(nonatomic, strong) UIRefreshControl *refreshControl;
@end

@implementation XZBaseTableForTurnPage

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style]) {
        [self initData];
        [self initUI];
    }
    return self;
}

- (UIRefreshControl *)refreshControl{
    if (!_refreshControl) {
        _refreshControl = [[UIRefreshControl alloc] init];
        _refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
        [_refreshControl addTarget:self action:@selector(refreshData) forControlEvents:UIControlEventValueChanged];
    }
    
    return _refreshControl;
}

- (void)refreshData{
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"加载数据中..."];
    
    if (self.eventDelegate && [self.eventDelegate respondsToSelector:@selector(tableStatus:)]) {
        [self.eventDelegate tableStatus:XZBaseTableForTurnPageStatusRefresh];
    }
}

- (void)initData{
    self.isHasNextPage = NO;
    self.tableData = [NSMutableArray array];
}

- (void)initUI{
}

- (void)addRefreshView{
    [self addSubview:self.refreshControl];
}

- (void)endRefresh:(id)data{

}


@end
