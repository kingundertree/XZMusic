//
//  XZTabBarForHomeViewController.h
//  XZMusic
//
//  Created by xiazer on 14-8-24.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XZBaseViewController.h"

@protocol TabBarForHomeDelegate <NSObject>

- (void)pushForHomeVC:(XZBaseViewController *)vc;

@end

@interface XZTabBarForHomeViewController : XZBaseViewController

@property (nonatomic, assign) id<TabBarForHomeDelegate> homeDelegate;

@end
