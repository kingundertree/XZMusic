//
//  XZMusicRequestForWeiboInfoManager.h
//  XZMusic
//
//  Created by xiazer on 14/11/8.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "XZBaseRequestManager.h"

@interface XZMusicRequestForWeiboInfoManager : XZBaseRequestManager

@property(nonatomic, copy) void(^requestForWeiboInfoBlock)(XZRequestResponse *response);

- (void)requestForWeiboInfo:(NSDictionary *)params block:(void(^)(XZRequestResponse *response))Block;

@end
