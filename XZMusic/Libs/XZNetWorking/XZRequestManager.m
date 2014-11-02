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

+ (void)initServieId
{
    [XZNetBridge initServieId];
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
            SuppressPerformSelectorLeakWarning(
                                               [target performSelector:action withObject:[response returnNetworkResponse]]
                                               );
        }
    } fail:^(XZRequestResponse *response) {
        if ([target respondsToSelector:action]) {
            SuppressPerformSelectorLeakWarning(
                                               [target performSelector:action withObject:[response returnNetworkResponse]]
                                               );
        }
    }];
    
    return (XZRequestID)requestId;
}


- (XZRequestID)asyncPostWithServiceID:(XZServiceType)serviceID methodName:(NSString *)methodName params:(NSDictionary *)params target:(id)target action:(SEL)action{
    NSInteger requestId = [[XZApiManager shareInstance] callPostWithParams:params
                                                         serviceIdentifier:[XZNetBridge bridgeServiceWithId:serviceID]
                                                                methodName:methodName
                                                                   success:^(XZRequestResponse *response)
                           {
                               if ([target respondsToSelector:action]) {
                                   SuppressPerformSelectorLeakWarning(
                                                                      [target performSelector:action withObject:[response returnNetworkResponse]]
                                                                      );
                               }
                           } fail:^(XZRequestResponse *response) {
                               if ([target respondsToSelector:action]) {
                                   SuppressPerformSelectorLeakWarning(
                                                                      [target performSelector:action withObject:[response returnNetworkResponse]]
                                                                      );
                               }
                           }];
    
    return (XZRequestID)requestId;
}

- (XZRequestResponse *)syncGetWithServiceID:(XZServiceType)serviceID methodName:(NSString *)methodName params:(NSDictionary *)params{
    if ([self isRest:serviceID]) {
        
    }
    
    return [[XZApiManager shareInstance] callGETWithParams:params serviceIdentifier:[XZNetBridge bridgeServiceWithId:serviceID] methodName:methodName];
}
- (XZRequestResponse *)syncPostWithServiceID:(XZServiceType)serviceID methodName:(NSString *)methodName params:(NSDictionary *)params{
    return [[XZApiManager shareInstance] callPostWithParams:params
                                          serviceIdentifier:[XZNetBridge bridgeServiceWithId:serviceID]
                                                 methodName:methodName];
    
}

#pragma mark - REST
- (XZRequestID)asyncRESTGetWithServiceID:(XZServiceType)serviceID methodName:(NSString *)methodName params:(NSDictionary *)params target:(id)target action:(SEL)action{
    NSInteger requestId = [[XZApiManager shareInstance] callRestfulGETWithParams:params
                                                               serviceIdentifier:[XZNetBridge bridgeServiceWithId:serviceID] methodName:methodName
                                                                         success:
                           ^(XZRequestResponse *response)
                           {
                               if ([target respondsToSelector:action]) {
                                   SuppressPerformSelectorLeakWarning(
                                                                      [target performSelector:action withObject:[response returnNetworkResponse]]
                                                                      );
                               }
                           }fail:^(XZRequestResponse *response)
                           {
                               if ([target respondsToSelector:action]) {
                                   SuppressPerformSelectorLeakWarning(
                                                                      [target performSelector:action withObject:[response returnNetworkResponse]]
                                                                      );
                               }
                           }];

    
    return (XZRequestID)requestId;
}

- (XZRequestID)asyncRESTPostWithServiceID:(XZServiceType)serviceID methodName:(NSString *)methodName params:(NSDictionary *)params target:(id)target action:(SEL)action{
    NSInteger requestId = [[XZApiManager shareInstance] callRestfulPOSTWithParams:params
                                                                serviceIdentifier:[XZNetBridge bridgeServiceWithId:serviceID]
                                                                       methodName:methodName
                                                                          success:^(XZRequestResponse *response)
                           {
                               if ([target respondsToSelector:action]) {
                                   SuppressPerformSelectorLeakWarning(
                                                                      [target performSelector:action withObject:[response returnNetworkResponse]]
                                                                      );
                               }
                           }
                                                                             fail:^(XZRequestResponse *response)
                           {
                               if ([target respondsToSelector:action]) {
                                   SuppressPerformSelectorLeakWarning(
                                                                      [target performSelector:action withObject:[response returnNetworkResponse]]
                                                                      );
                               }
                           }];

    return (XZRequestID)requestId;
}
- (XZRequestResponse *)syncRESTPostWithServiceID:(XZServiceType)serviceID methodName:(NSString *)methodName params:(NSDictionary *)params{
    return [[XZApiManager shareInstance] callRestfulPOSTWithParams:params serviceIdentifier:[XZNetBridge bridgeServiceWithId:serviceID] methodName:methodName];
}

- (XZRequestResponse *)syncRESTGetWithServiceID:(XZServiceType)serviceID methodName:(NSString *)methodName params:(NSDictionary *)params{
    return [[XZApiManager shareInstance] callRestfulGETWithParams:params serviceIdentifier:[XZNetBridge bridgeServiceWithId:serviceID] methodName:methodName];
}

#pragma mark - Cancel requests
- (void)cancelRequest:(XZRequestID)requestID
{
    [[XZApiManager shareInstance] cancelRequestWithRequestID:@(requestID)];
}

- (void)cancelRequestsWithTarget:(id)target
{
    //    [apiRequestProxy cancelRequestsWithTarget:target];
}

- (BOOL)isRest:(XZServiceType)serviceID{
    if (serviceID == XZMusicGetServiceID ||
        serviceID == XZMusicPostServiceID) {
        return NO;
    }
    
    return YES;
}


@end
