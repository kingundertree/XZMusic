//
//  XZRequestResponse+XZNetMethod.m
//  XZMusic
//
//  Created by xiazer on 14/10/22.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "XZRequestResponse+XZNetMethod.h"

@implementation XZRequestResponse (XZNetMethod)
- (void)updateWithRTNetworkResponse:(XZRequestResponse *)response
{
    enum XZNetWorkingResponseStatus status;
    if (response.status == XZNetWorkingResponseStatusSuccess) {
        status = XZNetWorkingResponseStatusSuccess;
    } else {
        status = XZNetWorkingResponseStatusError;
    }
    
    [self updateWithContent:response.content requestId:response.requestID status:status];
}

- (XZRequestResponse *)returnNetworkResponse
{
    XZRequestResponse *response = [[XZRequestResponse alloc] init];
    response.requestID = (XZRequestID)self.requestId;
    if (self.status == XZNetWorkingResponseStatusSuccess) {
        response.status = XZNetWorkingResponseStatusSuccess;
    } else {
        response.status = XZNetWorkingResponseStatusError;
    }
    response.content = self.content;
    
    return response;
}

@end
