//
//  XZAppDelegate.h
//  XZMusic
//
//  Created by xiazer on 14-8-22.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XZMenuMainViewController.h"

@interface XZAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(nonatomic, strong) XZMenuMainViewController *menuMainVC;

+ (XZAppDelegate *)sharedAppDelegate;

@end
