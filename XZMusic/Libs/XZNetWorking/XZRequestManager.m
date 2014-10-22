//
//  XZRequestManager.m
//  XZMusic
//
//  Created by xiazer on 14/10/19.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "XZRequestManager.h"
#import "XZApiManager.h"
#import "XZRequestResponse+XZNetMethod.h"

@implementation XZRequestManager

+ (id)shareInstance{
    static dispatch_once_t pred;
    static XZRequestManager *sharedInstance = nil;
    dispatch_once(&pred, ^{
        sharedInstance = [[XZRequestManager alloc] init];
    });
    return sharedInstance;
}

#pragma mark --Normal request
- (XZRequestID)asyncGetWithServiceID:(XZServiceType)serviceID methodName:(NSString *)methodName params:(NSDictionary *)params target:(id)target action:(SEL)action
{
    NSInteger requestId = [[XZApiManager shareInstance] callGETWithParams:params
                                                        serviceIdentifier:[XZNetBridge bridgeServiceWithId:serviceID]
                                                               methodName:methodName
                                                                  success:^(XZRequestResponse *response)
    {
        if ([target respondsToSelector:action]) {
            [target performSelector:action withObject:[response returnNetworkResponse]];
        }
    } fail:^(XZRequestResponse *response) {
        if ([target respondsToSelector:action]) {
            [target performSelector:action withObject:[response returnNetworkResponse]];
        }
    }];
    
    return (XZRequestID)requestId;
}


//- (XZRequestID)asyncPostWithServiceID:(XZServiceType)serviceID methodName:(NSString *)methodName params:(NSDictionary *)paras target:(id)target action:(SEL)action;
- (XZRequestResponse *)syncGetWithServiceID:(XZServiceType)serviceID methodName:(NSString *)methodName params:(NSDictionary *)params{
    if ([self isRest:serviceID]) {
        
    }
    
    return [[XZApiManager shareInstance] callGETWithParams:params serviceIdentifier:[XZNetBridge bridgeServiceWithId:serviceID] methodName:methodName];
}
//- (XZRequestResponse *)syncPostWithServiceID:(XZServiceType)serviceID methodName:(NSString *)methodName params:(NSString *)params;


- (BOOL)isRest:(XZServiceType)serviceID{
    if (serviceID == XZMusicGetServiceID ||
        serviceID == XZMusicPostServiceID) {
        return NO;
    }
    
    return YES;
}


@end
