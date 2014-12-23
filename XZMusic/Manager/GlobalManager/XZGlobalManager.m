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

    if (self.musicDownArr.count == 0 && progress != 1.0) {
        [self.musicDownArr addObject:musicInfo];
    } else {
        BOOL isHasMusicInfo = NO;
        for (NSInteger i = 0; i < self.musicDownArr.count; i++) {
            XZMusicInfo *info = [self.musicDownArr objectAtIndex:i];
            
            if ([info.musicId isEqualToString:musicInfo.musicId]) {
                isHasMusicInfo = YES;
                
                if (progress == 1.0) {
//                    [self.musicDownArr removeObjectAtIndex:i];
                } else {
                    [self.musicDownArr replaceObjectAtIndex:i withObject:musicInfo];
                }
            }
        }
        
        if (!isHasMusicInfo) {
            if (progress == 1.0) {
                return;
            } else {
                [self.musicDownArr addObject:musicInfo];
            }
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"musicDownloadNotification" object:nil userInfo:nil];
    }
}

@end
