//
//  XZMusicRequestForMisicSongInfoManager.m
//  XZMusic
//
//  Created by xiazer on 14/11/11.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "XZMusicRequestForMisicSongInfoManager.h"

@implementation XZMusicRequestForMisicSongInfoManager

- (void)requestForMusicSongInfoBlock:(NSDictionary *)params block:(void(^)(XZRequestResponse *response))Block{
    self.requestForMusicSongInfoBlock = Block;
    
    if (![XZRequestManager isNetWorkReachable]) {
        XZRequestResponse *response = [[XZRequestResponse alloc] init];
        response.status = XZNetWorkingResponseStatusNetError;
        
        self.requestForMusicSongInfoBlock(response);
        return;
    }
    
    NSString *method = @"data/music/links";
    
    [[XZRequestManager shareInstance] asyncGetWithServiceID:XZBaiduMusicGetServiceID methodName:method params:params target:self action:@selector(requestReturn:)];
}

- (void)requestReturn:(XZRequestResponse *)response{
    self.requestForMusicSongInfoBlock(response);
}


@end
