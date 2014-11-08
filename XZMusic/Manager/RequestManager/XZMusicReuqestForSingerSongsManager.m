//
//  XZMusicReuqestForSingerSongsManager.m
//  XZMusic
//
//  Created by xiazer on 14/11/8.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "XZMusicReuqestForSingerSongsManager.h"

@implementation XZMusicReuqestForSingerSongsManager

- (void)requestForSingerSongsBlock:(NSDictionary *)params block:(void(^)(XZRequestResponse *response))Block{
    self.requestForSingerSongsBlock = Block;
    
    if (![XZRequestManager isNetWorkReachable]) {
        XZRequestResponse *response = [[XZRequestResponse alloc] init];
        response.status = XZNetWorkingResponseStatusNetError;
        
        self.requestForSingerSongsBlock(response);
        return;
    }

    NSString *method = @"restserver/ting?from=ios&version=2.4.0&method=baidu.ting.artist.getSongList&format=json&order=2&offset=0";
    
    [[XZRequestManager shareInstance] asyncGetWithServiceID:XZMusicGetServiceID methodName:method params:params target:self action:@selector(requestReturn:)];
}

- (void)requestReturn:(XZRequestResponse *)response{
    self.requestForSingerSongsBlock(response);
}

@end
