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

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.musicDownArr = [NSMutableArray new];
    }
    return self;
}

- (void)updateMusicDownInfo:(XZMusicInfo *)musicInfo
{
    float progress = musicInfo.downProgress;
    
    if (progress == -2.0) {
        // 网络错误
    } else if (progress == -1.0) {
        // 下载失败
    } else if (progress == 1.0) {
        // 下载成功
    } else if (progress >= 0 && progress < 1.0) {
        // 下载中
    }
}

@end
