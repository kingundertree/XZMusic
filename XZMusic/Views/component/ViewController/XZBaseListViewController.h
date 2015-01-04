//
//  XZBaseListViewController.h
//  XZMusic
//
//  Created by xiazer on 15/1/3.
//  Copyright (c) 2015年 xiazer. All rights reserved.
//

#import "XZBaseViewController.h"

@interface XZBaseListViewController : XZBaseViewController <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableList;
@property (nonatomic, strong) NSMutableArray *tableData;
@end
