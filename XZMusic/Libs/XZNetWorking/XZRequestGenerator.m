//
//  XZRequestGenerator.m
//  XZMusic
//
//  Created by xiazer on 14/10/19.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "XZRequestGenerator.h"
#import "XZSignatureGenerator.h"
#import "XZNetCommonParamsGenerator.h"
#import "NSDictionary+XZNetMethod.h"
#import "XZSignatureGenerator.h"
#import "XZNetServiceFactory.h"
#import "XZNetCommonParamsGenerator.h"
#import "NSObject+XZNetMethod.h"
#import <AFNetworking/AFNetworking.h>
#import "XZNetService.h"
#import "AFURLRequestSerialization.h"
#import "NSURLRequest+XZNetMethod.h"

@interface XZRequestGenerator ()
@property(nonatomic, strong) AFHTTPRequestSerializer *httpRequestSerializer;
@end

@implementation XZRequestGenerator

#pragma mark - getters and setters
- (AFHTTPRequestSerializer *)httpRequestSerializer{
    if (_httpRequestSerializer == nil) {
        _httpRequestSerializer = [AFHTTPRequestSerializer serializer];
        _httpRequestSerializer.timeoutInterval = 20;
        _httpRequestSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;
    }
    return _httpRequestSerializer;
}

- (NSURLRequest *)generateGETRequestWithServiceIdentifier:(NSString *)serviceIdentifier requestParams:(NSDictionary *)requestParams methodName:(NSString *)methodName{
    XZNetService *service = [[XZNetServiceFactory shareInstance] serviceWithIdentifier:serviceIdentifier];

    NSMutableDictionary *sigParams = [NSMutableDictionary dictionaryWithDictionary:requestParams];
    sigParams[@"api_key"] = service.publicKey;
    NSString *signature = [XZSignatureGenerator signGetWithSigParams:sigParams methodName:methodName apiVersion:service.apiVersion privateKey:service.privateKey publicKey:service.publicKey];

    NSMutableDictionary *allParams = [NSMutableDictionary dictionaryWithDictionary:[XZNetCommonParamsGenerator commonParamsDictionary]];
    [allParams addEntriesFromDictionary:sigParams];
    NSString *urlString = [NSString stringWithFormat:@"%@%@/%@?%@&sig=%@", service.apiBaseUrl, service.apiVersion, methodName, [allParams XZNet_urlParamsStringSignature:NO], signature];

    NSMutableURLRequest *request = [self.httpRequestSerializer requestWithMethod:@"GET" URLString:urlString parameters:nil error:NULL];
    request.timeoutInterval = 20;
    request.requestParams = requestParams;
//    [AIFApiDebugger logDebugInfoWithRequest:request apiName:methodName service:service requestParams:requestParams httpMethod:@"GET"];
    return request;
}

@end
