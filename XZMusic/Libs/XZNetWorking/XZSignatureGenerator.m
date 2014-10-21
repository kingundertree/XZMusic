//
//  XZSignatureGenerator.m
//  XZMusic
//
//  Created by xiazer on 14/10/21.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "XZSignatureGenerator.h"
#import "NSString+XZNetMethod.h"
#import "NSDictionary+XZNetMethod.h"

@implementation XZSignatureGenerator

+ (NSString *)signGetWithSigParams:(NSDictionary *)allParams methodName:(NSString *)methodName apiVersion:(NSString *)apiVersion privateKey:(NSString *)privateKey publicKey:(NSString *)publicKey{
    NSString *sigString = [allParams XZNet_urlParamsStringSignature:YES];
    return [[NSString stringWithFormat:@"%@%@", sigString, privateKey] STR_md5];
}

+ (NSString *)signRestfulGetWithAllParams:(NSDictionary *)allParams methodName:(NSString *)methodName apiVersion:(NSString *)apiVersion privateKey:(NSString *)privateKey{
    return nil;
}

+ (NSString *)signPostWithApiParams:(NSDictionary *)apiParams privateKey:(NSString *)privateKey publicKey:(NSString *)publicKey{
    return nil;
}

+ (NSString *)signRestfulPOSTWithApiParams:(id)apiParams commonParams:(NSDictionary *)commonParams methodName:(NSString *)methodName apiVersion:(NSString *)apiVersion privateKey:(NSString *)privateKey{
    return nil;
}



@end
