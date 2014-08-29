//
//  XZTabBarViewController.h
//  XZMusic
//
//  Created by xiazer on 14-8-24.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XZBaseViewController.h"

@protocol xzTabBarDelegate <NSObject>

- (void)tabBarRightButtonAction;

@end

@interface XZTabBarViewController : XZBaseViewController
@property(nonatomic, assign) NSInteger tabBarIndex;
@property(nonatomic, assign) id<xzTabBarDelegate> tabBarDelegate;

@end
