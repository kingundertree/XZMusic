//
//  XZApiManager.h
//  XZMusic
//
//  Created by xiazer on 14/10/19.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XZRequestResponse.h"
#import "XZNetService.h"
#import "XZNetServiceFactory.h"

typedef void(^XZCallback)(XZRequestResponse *response);

typedef NS_ENUM(NSUInteger, XZNetworkDetailStatus)
{
    XZNetworkDetailStatusNone,
    XZNetworkDetailStatus2G,
    XZNetworkDetailStatus3G,
    XZNetworkDetailStatus4G,
    XZNetworkDetailStatusLTE,
    XZNetworkDetailStatusWIFI,
    XZNetworkDetailStatusUnknown
};

@interface XZApiManager : NSObject
+ (id)shareInstance;

- (NSInteger)callGETWithParams:(NSDictionary *)params serviceIdentifier:(NSString *)servieIdentifier methodName:(NSString *)methodName success:(XZCallback)success fail:(XZCallback)fail;
- (NSInteger)callPostWithParams:(NSDictionary *)params serviceIdentifier:(NSString *)servieIdentifier methodName:(NSString *)methodName success:(XZCallback)success fail:(XZCallback)fail;
- (XZRequestResponse *)callGETWithParams:(NSDictionary *)params serviceIdentifier:(NSString *)servieIdentifier methodName:(NSString *)methodName;
- (XZRequestResponse *)callPostWithParams:(NSDictionary *)params serviceIdentifier:(NSString *)servieIdentifier methodName:(NSString *)methodName;

- (NSInteger)callRestfulGETWithParams:(NSDictionary *)params serviceIdentifier:(NSString *)servieIdentifier methodName:(NSString *)methodName success:(XZCallback)success fail:(XZCallback)fail;
- (NSInteger)callRestfulPOSTWithParams:(NSDictionary *)params serviceIdentifier:(NSString *)servieIdentifier methodName:(NSString *)methodName success:(XZCallback)success fail:(XZCallback)fail;
- (XZRequestResponse *)callRestfulPOSTWithParams:(NSDictionary *)params serviceIdentifier:(NSString *)servieIdentifier methodName:(NSString *)methodName;
- (XZRequestResponse *)callRestfulGETWithParams:(NSDictionary *)params serviceIdentifier:(NSString *)servieIdentifier methodName:(NSString *)methodName;

#pragma mark - Cancel request
- (void)cancelRequest:(XZRequestID)requestID;
- (void)cancelRequestsWithTarget:(id)target;
- (void)cancelRequestWithRequestID:(NSNumber *)requestID;
@end
