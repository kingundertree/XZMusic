//
//  XZRequestManager.h
//  XZMusic
//
//  Created by xiazer on 14/10/19.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XZRequestResponse.h"
#import "XZNetBridge.h"

unsigned int XZMusicGetServiceID;
unsigned int XZMusicPostServiceID;
unsigned int XZMusicRESTGetServiceID;
unsigned int XZMusicRESTPostServiceID;

@interface XZRequestManager : NSObject

+ (id)shareInstance;

#pragma mark --Normal request
- (XZRequestID)asyncGetWithServiceID:(XZServiceType)serviceID methodName:(NSString *)methodName params:(NSDictionary *)params target:(id)target action:(SEL)action;
- (XZRequestID)asyncPostWithServiceID:(XZServiceType)serviceID methodName:(NSString *)methodName params:(NSDictionary *)params target:(id)target action:(SEL)action;
- (XZRequestResponse *)syncGetWithServiceID:(XZServiceType)serviceID methodName:(NSString *)methodName params:(NSDictionary *)params;
- (XZRequestResponse *)syncPostWithServiceID:(XZServiceType)serviceID methodName:(NSString *)methodName params:(NSDictionary *)params;

#pragma mark - REST
- (XZRequestID)asyncRESTGetWithServiceID:(XZServiceType)serviceID methodName:(NSString *)methodName params:(NSDictionary *)params target:(id)target action:(SEL)action;
- (XZRequestID)asyncRESTPostWithServiceID:(XZServiceType)serviceID methodName:(NSString *)methodName params:(NSDictionary *)params target:(id)target action:(SEL)action;
- (XZRequestResponse *)syncRESTPostWithServiceID:(XZServiceType)serviceID methodName:(NSString *)methodName params:(NSDictionary *)params;
- (XZRequestResponse *)syncRESTGetWithServiceID:(XZServiceType)serviceID methodName:(NSString *)methodName params:(NSDictionary *)params;

#pragma mark - Cancel request
- (void)cancelRequest:(XZRequestID)requestID;
- (void)cancelRequestsWithTarget:(id)target;



@end
