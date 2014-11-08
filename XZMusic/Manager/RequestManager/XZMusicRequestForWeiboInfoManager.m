//
//  XZMusicRequestForWeiboInfoManager.m
//  XZMusic
//
//  Created by xiazer on 14/11/8.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "XZMusicRequestForWeiboInfoManager.h"

@implementation XZMusicRequestForWeiboInfoManager


- (void)requestForWeiboInfo:(NSDictionary *)params block:(void(^)(XZRequestResponse *response))Block{
    self.requestForWeiboInfoBlock = Block;
    
    if (![XZRequestManager isNetWorkReachable]) {
        XZRequestResponse *response = [[XZRequestResponse alloc] init];
        response.status = XZNetWorkingResponseStatusNetError;

        self.requestForWeiboInfoBlock(response);
        return;
    }
    
    NSString *method = @"users/show.json";
    
    [[XZRequestManager shareInstance] asyncGetWithServiceID:XZWeiboGetServiceID methodName:method params:params target:self action:@selector(requestReturn:)];
}

- (void)requestReturn:(XZRequestResponse *)response{
    self.requestForWeiboInfoBlock(response);
}

@end
