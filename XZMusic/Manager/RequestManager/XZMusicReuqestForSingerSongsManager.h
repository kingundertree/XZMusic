//
//  XZMusicReuqestForSingerSongsManager.h
//  XZMusic
//
//  Created by xiazer on 14/11/8.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "XZBaseRequestManager.h"

@interface XZMusicReuqestForSingerSongsManager : XZBaseRequestManager

@property(nonatomic, copy) void(^requestForSingerSongsBlock)(XZRequestResponse *response);

- (void)requestForSingerSongsBlock:(NSDictionary *)params block:(void(^)(XZRequestResponse *response))Block;

@end
