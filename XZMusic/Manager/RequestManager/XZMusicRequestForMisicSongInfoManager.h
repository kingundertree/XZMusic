//
//  XZMusicRequestForMisicSongInfoManager.h
//  XZMusic
//
//  Created by xiazer on 14/11/11.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "XZBaseRequestManager.h"

@interface XZMusicRequestForMisicSongInfoManager : XZBaseRequestManager

@property(nonatomic, copy) void(^requestForMusicSongInfoBlock)(XZRequestResponse *response);

- (void)requestForMusicSongInfoBlock:(NSDictionary *)params block:(void(^)(XZRequestResponse *response))Block;


@end
