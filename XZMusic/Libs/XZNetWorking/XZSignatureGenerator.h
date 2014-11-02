//
//  XZSignatureGenerator.h
//  XZMusic
//
//  Created by xiazer on 14/10/21.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XZSignatureGenerator : NSObject

+ (NSString *)signGetWithSigParams:(NSDictionary *)allParams methodName:(NSString *)methodName apiVersion:(NSString *)apiVersion privateKey:(NSString *)privateKey publicKey:(NSString *)publicKey;
+ (NSString *)signRestfulGetWithAllParams:(NSDictionary *)allParams methodName:(NSString *)methodName apiVersion:(NSString *)apiVersion privateKey:(NSString *)privateKey;

+ (NSString *)signPostWithApiParams:(NSDictionary *)apiParams privateKey:(NSString *)privateKey publicKey:(NSString *)publicKey;
+ (NSString *)signRestfulPOSTWithApiParams:(id)apiParams commonParams:(NSDictionary *)commonParams methodName:(NSString *)methodName apiVersion:(NSString *)apiVersion privateKey:(NSString *)privateKey;

@end
