//
//  XZMusicDownOperation.h
//  XZMusic
//
//  Created by xiazer on 14/11/19.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XZMusicDownloadResponse.h"

NS_ENUM(NSInteger, XZMusicDownloadtype) {
    XZMusicDownloadtypeForMusic = 1, // 音乐
    XZMusicDownloadtypeForLrc = 2, // 歌词
};

@interface XZMusicDownloadCenter : NSObject

+ (XZMusicDownloadCenter *)shareInstance;
- (void)cancleAllRequest;
- (NSUInteger)currentCountOfOperations;
- (void)cancleOperationWithIdentify:(NSString *)identify;

- (void)downloadMusicWithMusicId:(NSString *)musicId format:(NSString *)format musicUrlStr:(NSString *)musicUrlStr identify:(NSString *)identify downloadType:(enum XZMusicDownloadtype)downloadType downloadBlock:(void(^)(XZMusicDownloadResponse *response))downloadBlock;


@end
