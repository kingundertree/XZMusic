//
//  XZNetService.h
//  XZMusic
//
//  Created by xiazer on 14/10/19.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import <Foundation/Foundation.h>

// 所有XZNetService的派生类都要符合这个protocal
@protocol XZNetServiceProtocal <NSObject>
@property (nonatomic, readonly) BOOL isOnline;
@property (nonatomic, readonly) NSString *offlineApiBaseUrl;
@property (nonatomic, readonly) NSString *onlineApiBaseUrl;
@property (nonatomic, readonly) NSString *offlineApiVersion;
@property (nonatomic, readonly) NSString *onlineApiVersion;
@property (nonatomic, readonly) NSString *onlinePublicKey;
@property (nonatomic, readonly) NSString *offlinePublicKey;
@property (nonatomic, readonly) NSString *onlinePrivateKey;
@property (nonatomic, readonly) NSString *offlinePrivateKey;
@end

@interface XZNetService : NSObject

//+ (id)shareInstance;

@property (nonatomic, strong, readonly) NSString *publicKey;
@property (nonatomic, strong, readonly) NSString *privateKey;
@property (nonatomic, strong, readonly) NSString *apiBaseUrl;
@property (nonatomic, strong, readonly) NSString *apiVersion;
@property (nonatomic, strong, readonly) NSString *appName;

@property (nonatomic, readonly) BOOL isOldApi;
@property (nonatomic, readonly) BOOL isREST;

@property (nonatomic, weak) id<XZNetServiceProtocal> child;

@end
