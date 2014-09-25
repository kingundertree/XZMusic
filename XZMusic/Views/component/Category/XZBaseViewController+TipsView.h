//
//  XZBaseViewController+TipsView.h
//  XZMusic
//
//  Created by xiazer on 14-9-25.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "XZBaseViewController.h"

@interface XZBaseViewController (TipsView)
- (void)showLoading;
- (void)hideLoading;
- (void)showTips:(NSString *)tips;
- (void)hideHudTips;

@end
