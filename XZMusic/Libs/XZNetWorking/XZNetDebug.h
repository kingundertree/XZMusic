//
//  XZNetDebug.h
//  XZMusic
//
//  Created by xiazer on 14/11/3.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XZNetService.h"
#import "XZRequestResponse.h"

@interface XZNetDebug : NSObject
+ (instancetype)sharedInstance;

@property (nonatomic, assign) BOOL showLogs;
@property (nonatomic, assign) BOOL showRequests;
@property (nonatomic, assign) BOOL showResponses;

+ (void)logDebugInfoWithRequest:(NSURLRequest *)request apiName:(NSString *)apiName service:(XZNetService *)service requestParams:(id)requestParams httpMethod:(NSString *)httpMethod;
+ (void)logDebugInfoWithResponse:(NSHTTPURLResponse *)response resposeString:(NSString *)responseString request:(NSURLRequest *)request error:(NSError *)error;
+ (void)logDebugInfoWithCachedResponse:(XZRequestResponse *)response methodName:(NSString *)methodName serviceIdentifier:(XZNetService *)service;

@end
