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
#import "XZNetServiceFactory.h"
#import "XZNetDebug.h"

static NSString * const httpMethodRestfulGet = @"GET";
static NSString * const httpMethodRestfulPost = @"POST";
static NSString * const httpMethodRestfulPut = @"PUT";
static NSString * const httpMethodRestfulDelete = @"DELETE";

static NSTimeInterval kAIFNetworkingTimeoutSeconds = 20.0f;

@interface XZRequestGenerator ()
@property(nonatomic, strong) AFHTTPRequestSerializer *httpRequestSerializer;
@end

@implementation XZRequestGenerator

#pragma mark - public methods
+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static XZRequestGenerator *sharedInstance = nil;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[XZRequestGenerator alloc] init];
    });
    return sharedInstance;
}


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
//    sigParams[@"api_key"] = service.publicKey;
    NSString *signature = [XZSignatureGenerator signGetWithSigParams:sigParams methodName:methodName apiVersion:service.apiVersion privateKey:service.privateKey publicKey:service.publicKey];

    NSMutableDictionary *allParams = [NSMutableDictionary dictionaryWithDictionary:[XZNetCommonParamsGenerator commonParamsDictionary]];
    [allParams addEntriesFromDictionary:sigParams];
//    NSString *urlString = [NSString stringWithFormat:@"%@%@/%@?%@&sig=%@", service.apiBaseUrl, service.apiVersion, methodName, [allParams XZNet_urlParamsStringSignature:NO], signature];
    NSString *urlString = [NSString stringWithFormat:@"%@/%@?%@&sig=%@", service.apiBaseUrl, methodName, [allParams XZNet_urlParamsStringSignature:NO], signature];

    NSMutableURLRequest *request = [self.httpRequestSerializer requestWithMethod:@"GET" URLString:urlString parameters:nil error:NULL];
    request.timeoutInterval = 20;
    request.requestParams = requestParams;
    
    [XZNetDebug logDebugInfoWithRequest:request apiName:methodName service:service requestParams:requestParams httpMethod:@"GET"];
    return request;
}

- (NSURLRequest *)generatePostRequestWithServiceIdentifier:(NSString *)serviceIdentifier requestParams:(NSDictionary *)requestParams methodName:(NSString *)methodName{
    XZNetService *service = [[XZNetServiceFactory shareInstance] serviceWithIdentifier:serviceIdentifier];
    
    NSString *signature = [XZSignatureGenerator signPostWithApiParams:requestParams privateKey:service.privateKey publicKey:service.publicKey];
    NSString *urlString = [NSString stringWithFormat:@"%@%@/%@?api_key=%@&sig=%@&%@", service.apiBaseUrl, service.apiVersion, methodName, service.publicKey, signature, [[XZNetCommonParamsGenerator commonParamsDictionary] XZNet_urlParamsStringSignature:NO]];

    NSURLRequest *request = [self.httpRequestSerializer requestWithMethod:@"POST" URLString:urlString parameters:requestParams error:NULL];
    request.requestParams = requestParams;
//    [AIFApiDebugger logDebugInfoWithRequest:request apiName:methodName service:service requestParams:requestParams httpMethod:@"POST"];
    return request;
}

- (NSURLRequest *)generateRestfulGETRequestWithServiceIdentifier:(NSString *)serviceIdentifier requestParams:(NSDictionary *)requestParams methodName:(NSString *)methodName httpMethod:(NSString *)httpMethod
{
    NSMutableDictionary *allParams = [NSMutableDictionary dictionaryWithDictionary:[XZNetCommonParamsGenerator commonParamsDictionary]];
    [allParams addEntriesFromDictionary:requestParams];

    XZNetService *service = [[XZNetServiceFactory shareInstance] serviceWithIdentifier:serviceIdentifier];
    NSString *signature = [XZSignatureGenerator signRestfulGetWithAllParams:requestParams methodName:methodName apiVersion:service.apiVersion privateKey:service.privateKey];
    NSString *urlString = [NSString stringWithFormat:@"%@%@/%@?%@", service.apiBaseUrl, service.apiVersion, methodName, [allParams XZNet_urlParamsStringSignature:NO]];
    
    NSDictionary *restfulHeader = [self commRESTHeadersWithService:service signature:signature];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:kAIFNetworkingTimeoutSeconds];
    request.HTTPMethod = httpMethod;
    [restfulHeader enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [request setValue:obj forHTTPHeaderField:key];
    }];
    request.requestParams = requestParams;
//    [AIFApiDebugger logDebugInfoWithRequest:request apiName:methodName service:service requestParams:requestParams httpMethod:[NSString stringWithFormat:@"Restful %@",httpMethod]];
    return request;
}

- (NSURLRequest *)generateRestfulPOSTRequestWithServiceIdentifier:(NSString *)serviceIdentifier requestParams:(NSDictionary *)requestParams methodName:(NSString *)methodName httpMethod:(NSString *)httpMethod{
    XZNetService *service = [[XZNetServiceFactory shareInstance] serviceWithIdentifier:serviceIdentifier];
    NSDictionary *commonParams = [XZNetCommonParamsGenerator commonParamsDictionary];
    NSString *signature = [XZSignatureGenerator signRestfulPOSTWithApiParams:requestParams commonParams:commonParams methodName:methodName apiVersion:service.apiVersion privateKey:service.privateKey];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@/%@?%@", service.apiBaseUrl, service.apiVersion, methodName, [commonParams XZNet_urlParamsStringSignature:NO]];
    
    NSDictionary *restfulHeader = [self commRESTHeadersWithService:service signature:signature];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:kAIFNetworkingTimeoutSeconds];
    request.HTTPMethod = httpMethod;
    [restfulHeader enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [request setValue:obj forHTTPHeaderField:key];
    }];
    request.HTTPBody = [NSJSONSerialization dataWithJSONObject:requestParams options:NSJSONWritingPrettyPrinted error:NULL];
    request.requestParams = requestParams;
//    [AIFApiDebugger logDebugInfoWithRequest:request apiName:methodName service:service requestParams:requestParams httpMethod:[NSString stringWithFormat:@"Restful %@",httpMethod]];
    return request;
}

- (NSURLRequest *)generateRestfulGETRequestWithServiceIdentifier:(NSString *)serviceIdentifier requestParams:(NSDictionary *)requestParams methodName:(NSString *)methodName
{
    return [self generateRestfulGETRequestWithServiceIdentifier:serviceIdentifier requestParams:requestParams methodName:methodName httpMethod:httpMethodRestfulGet];
}

- (NSURLRequest *)generateRestfulPOSTRequestWithServiceIdentifier:(NSString *)serviceIdentifier requestParams:(NSDictionary *)requestParams methodName:(NSString *)methodName
{
    return [self generateRestfulPOSTRequestWithServiceIdentifier:serviceIdentifier requestParams:requestParams methodName:methodName httpMethod:httpMethodRestfulGet];
}

#pragma mark - private methods
- (NSDictionary *)commRESTHeadersWithService:(XZNetService *)service signature:(NSString *)signature
{
    NSMutableDictionary *headerDic = [NSMutableDictionary dictionary];
    [headerDic setValue:signature forKey:@"sig"];
    [headerDic setValue:service.publicKey forKey:@"key"];
    [headerDic setValue:@"application/json" forKey:@"Accept"];
    [headerDic setValue:@"application/json" forKey:@"Content-Type"];
    NSDictionary *loginResult = [[NSUserDefaults standardUserDefaults] objectForKey:@"anjuke_chat_login_info"];
    if (loginResult[@"auth_token"]) {
        [headerDic setValue:loginResult[@"auth_token"] forKey:@"AuthToken"];
    }
    return headerDic;
}

@end
