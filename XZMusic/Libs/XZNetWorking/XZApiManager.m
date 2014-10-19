//
//  XZApiManager.m
//  XZMusic
//
//  Created by xiazer on 14/10/19.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "XZApiManager.h"

@implementation XZApiManager

+ (id)shareInstance{
    static dispatch_once_t pred;
    static XZApiManager *sharedInstance = nil;
    dispatch_once(&pred, ^{
        sharedInstance = [[XZApiManager alloc] init];
    });
    return sharedInstance;
}

- (XZRequestResponse *)callGETWithParams:(NSDictionary *)params serviceIdentifier:(NSString *)servieIdentifier methodName:(NSString *)methodName{
    XZNetService *service = [[XZNetServiceFactory shareInstance] serviceWithIdentifier:servieIdentifier];
    
    
//    NSURLRequest *request = [[AIFRequestGenerator sharedInstance] generateGETRequestWithServiceIdentifier:servieIdentifier
//                                                                                            requestParams:params
//                                                                                               methodName:methodName];
//    return [self callApiWithRequestSynchronously:request];

    return nil;
}

@end
