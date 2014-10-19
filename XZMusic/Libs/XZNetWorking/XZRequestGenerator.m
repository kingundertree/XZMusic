//
//  XZRequestGenerator.m
//  XZMusic
//
//  Created by xiazer on 14/10/19.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "XZRequestGenerator.h"

@implementation XZRequestGenerator

- (NSURLRequest *)generateGETRequestWithServiceIdentifier:(NSString *)serviceIdentifier requestParams:(NSDictionary *)requestParams methodName:(NSString *)methodName{
//    XZNetService *service = [[XZNetServiceFactory shareInstance] serviceWithIdentifier:serviceIdentifier];
//    
//    NSMutableDictionary *sigParams = [NSMutableDictionary dictionaryWithDictionary:requestParams];
//    sigParams[@"api_key"] = service.publicKey;
//    NSString *signature = [AIFSignatureGenerator signGetWithSigParams:sigParams methodName:methodName apiVersion:service.apiVersion privateKey:service.privateKey publicKey:service.publicKey];
//    
//    NSMutableDictionary *allParams = [NSMutableDictionary dictionaryWithDictionary:[AIFCommonParamsGenerator commonParamsDictionary]];
//    [allParams addEntriesFromDictionary:sigParams];
//    NSString *urlString = [NSString stringWithFormat:@"%@%@/%@?%@&sig=%@", service.apiBaseUrl, service.apiVersion, methodName, [allParams AIF_urlParamsStringSignature:NO], signature];
//    
//    NSMutableURLRequest *request = [self.httpRequestSerializer requestWithMethod:@"GET" URLString:urlString parameters:nil error:NULL];
//    request.timeoutInterval = kAIFNetworkingTimeoutSeconds;
//    request.requestParams = requestParams;
//    [AIFApiDebugger logDebugInfoWithRequest:request apiName:methodName service:service requestParams:requestParams httpMethod:@"GET"];
//    return request;
    return nil;
}

@end
