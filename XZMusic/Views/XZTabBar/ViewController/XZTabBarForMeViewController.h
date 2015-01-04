//
//  XZTabBarForMeViewController.h
//  XZMusic
//
//  Created by xiazer on 14-8-24.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XZBaseViewController.h"

@protocol TabBarForMeDelegate <NSObject>

- (void)pushForMeVC:(XZBaseViewController *)vc;

@end

@interface XZTabBarForMeViewController : XZBaseViewController
@property (nonatomic, assign) id<TabBarForMeDelegate> meDelegate;
@end
