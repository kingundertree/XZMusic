//
//  XZMainViewController.h
//  XZMusic
//
//  Created by xiazer on 14-8-24.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XZBaseViewController.h"
#import "XZTabBarViewController.h"

typedef enum : NSUInteger {
    MainViewOnEles = 0,
    MainViewOnMain,
    MainViewOnRightStatic,
} mainViewStatus;

@interface XZMenuMainViewController : XZBaseViewController<UIGestureRecognizerDelegate,xzTabBarDelegate>
@property(nonatomic, assign) mainViewStatus status;
@property(nonatomic, assign) BOOL isOnFirstView;

@end
