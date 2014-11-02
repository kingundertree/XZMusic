//
//  XZNetService.m
//  XZMusic
//
//  Created by xiazer on 14/10/19.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "XZNetService.h"
#import "XZAppContext.h"

@implementation XZNetService

//+ (id)shareInstance{
//    static dispatch_once_t pred;
//    static XZNetService *sharedInstance = nil;
//    dispatch_once(&pred, ^{
//        sharedInstance = [[XZNetService alloc] init];
//    });
//    return sharedInstance;
//}

- (instancetype)init
{
    self = [super init];
    if (self) {
        if ([self conformsToProtocol:@protocol(XZNetServiceProtocal)]) {
            self.child = (id<XZNetServiceProtocal>)self;
        }
    }
    return self;
}

#pragma mark - getters and setters

- (BOOL)isOldApi
{
    return NO;
}

- (BOOL)isREST
{
    return NO;
}

- (NSString *)appName
{
    return [[XZAppContext sharedInstance] appName];
}

- (NSString *)privateKey
{
    return self.child.isOnline ? self.child.onlinePrivateKey : self.child.offlinePrivateKey;
}

- (NSString *)publicKey
{
    return self.child.isOnline ? self.child.onlinePublicKey : self.child.offlinePublicKey;
}

- (NSString *)apiBaseUrl
{
    return self.child.isOnline ? self.child.onlineApiBaseUrl : self.child.offlineApiBaseUrl;
}

- (NSString *)apiVersion
{
    return self.child.isOnline ? self.child.onlineApiVersion : self.child.offlineApiVersion;
}

@end
