//
//  pushBackLock.m
//  PushBackDemo
//
//  Created by xiazer on 14-4-16.
//  Copyright (c) 2014年 夏至. All rights reserved.
//

#import "pushBackLock.h"
#import "PushBackNavigationController.h"


@implementation pushBackLock
+ (void)setDisableGestureForBack:(UINavigationController *)nav disable:(BOOL)disable{
    PushBackNavigationController *passNav = (PushBackNavigationController*)nav;
    passNav.disablePushBack = YES;
    }
@end
