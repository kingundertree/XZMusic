//
//  XZMusicForBaidu.m
//  XZMusic
//
//  Created by xiazer on 14/10/19.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "XZMusicForBaidu.h"
#import "XZAppContext.h"

@implementation XZMusicForBaidu

- (BOOL)isOnline
{
    return [[XZAppContext sharedInstance] isApiOnline];
}

- (NSString *)onlineApiBaseUrl
{
    return @"http://tingapi.ting.baidu.com/v1";
}

- (NSString *)onlineApiVersion
{
    return @"";
}

- (NSString *)onlinePrivateKey
{
    return @"";
}

- (NSString *)onlinePublicKey
{
    return @"";;
}

- (NSString *)offlineApiBaseUrl
{
    return @"";
}

- (NSString *)offlineApiVersion
{
    return @"";
}

- (NSString *)offlinePrivateKey
{
    return self.onlinePrivateKey;
}

- (NSString *)offlinePublicKey
{
    return self.offlinePublicKey;
}

@end
