//
//  UIViewController+TipsView.h
//  XZMusic
//
//  Created by xiazer on 14-9-23.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (TipsView)

- (void)showLoading;
- (void)hideLoading;
- (void)showTips:(NSString *)tips;
- (void)showDetailTips:(NSString *)tips;
- (void)hideHudTips;

@end
