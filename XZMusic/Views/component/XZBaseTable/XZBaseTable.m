//
//  XZBaseTable.m
//  XZMusic
//
//  Created by xiazer on 14/11/8.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "XZBaseTable.h"
#import "XZTableMoreCell.h"

@interface XZBaseTable ()
@end

@implementation XZBaseTable

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
        [self.eventDelegate tableStatus:XZBaseTableStatusRefresh];
    }
}

- (void)initData{
    self.isHasNextPage = NO;
    self.tableData = [NSMutableArray array];
}

- (void)initUI{
    self.dataSource = self;
    self.delegate = self;
}

- (void)addRefreshView{
    [self addSubview:self.refreshControl];
}

#pragma mark -
#pragma mark - UIDataSourceDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.isHasNextPage) {
        return [self.tableData count]+1;
    }
    return [self.tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

#pragma mark
#pragma mark --UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    DLog(@"contenty--->>%f/%f",scrollView.contentOffset.y,self.tableData.count*self.cellHeight + 40 - ScreenHeight + 64);
    
    if (self.isConMore && self.isHasNextPage && !self.isLoading && self.tableData.count != 0) {
        if (scrollView.contentOffset.y >= self.tableData.count*self.cellHeight + 40 - ScreenHeight + 64) {
            NSIndexPath *path = [NSIndexPath indexPathForRow:self.tableData.count inSection:0];
            XZTableMoreCell *loadingCell = (XZTableMoreCell *)[self cellForRowAtIndexPath:path];
            loadingCell.moreCellStatus = LoadingMoreCellStatusForIsLoading;
            
            if (self.eventDelegate && [self.eventDelegate respondsToSelector:@selector(tableStatus:)]) {
                [self.eventDelegate  tableStatus:XZBaseTableStatusLoadingNextPageData];
            }
            
        }
    }
}

- (void)endRefresh:(id)data{

}


@end
