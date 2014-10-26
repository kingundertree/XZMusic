//
//  XZMusicForWeibo.m
//  XZMusic
//
//  Created by xiazer on 14/10/26.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "XZMusicForWeibo.h"
#import "XZAppContext.h"

@implementation XZMusicForWeibo

- (BOOL)isOnline
{
    return [[XZAppContext sharedInstance] isApiOnline];
}

- (NSString *)onlineApiBaseUrl
{
    return @"";
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
