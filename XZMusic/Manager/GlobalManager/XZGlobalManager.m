//
//  XZGlobalManager.m
//  XZMusic
//
//  Created by xiazer on 14/12/6.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "XZGlobalManager.h"

@implementation XZGlobalManager

+ (XZGlobalManager *)shareInstance {
    static XZGlobalManager *shareInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        shareInstance = [[self alloc] init];
        
    });
    
    return shareInstance;
}

@end
