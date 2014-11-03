//
//  XZNetDebug.m
//  XZMusic
//
//  Created by xiazer on 14/11/3.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "XZNetDebug.h"
#import "NSObject+XZNetMethod.h"
#import "NSString+XZNetMethod.h"
#import "NSMutableString+XZNetMethod.h"
#import "XZNetCommonParamsGenerator.h"
#import "XZAppContext.h"
#import "NSArray+XZNetMethod.h"
#import "XZApiManager.h"
#import "XZNetServiceFactory.h"


@implementation XZNetDebug

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static XZNetDebug *sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[XZNetDebug alloc] init];
    });
    return sharedInstance;
}

+ (void)logDebugInfoWithRequest:(NSURLRequest *)request apiName:(NSString *)apiName service:(XZNetService *)service requestParams:(id)requestParams httpMethod:(NSString *)httpMethod
{
#ifdef DEBUG
    if (![[XZNetDebug sharedInstance] showLogs]) {
        if ([[[request URL] absoluteString] rangeOfString:@"admin.writeAppLog"].length > 0 ||
            [[[request URL] absoluteString] rangeOfString:@"admin.recordaction"].length > 0 ||
            [[[request URL] absoluteString] rangeOfString:@"nlog/"].length > 0) {
            return;
        }
    }
    
    if (![[XZNetDebug sharedInstance] showRequests]) {
        return;
    }
    
    [[XZNetDebug sharedInstance] logDebugInfoWithRequest:request apiName:apiName service:service requestParams:requestParams httpMethod:httpMethod];
#endif
}

+ (void)logDebugInfoWithResponse:(NSHTTPURLResponse *)response resposeString:(NSString *)responseString request:(NSURLRequest *)request error:(NSError *)error
{
#ifdef DEBUG
    
    if (![[XZNetDebug sharedInstance] showLogs]) {
        if ([[[request URL] absoluteString] rangeOfString:@"admin.writeAppLog"].length > 0 ||
            [[[request URL] absoluteString] rangeOfString:@"admin.recordaction"].length > 0 ||
            [[[request URL] absoluteString] rangeOfString:@"nlog/"].length > 0) {
            return;
        }
    }
    
    if (![[XZNetDebug sharedInstance] showResponses]) {
        return;
    }
    
    [[XZNetDebug sharedInstance] logDebugInfoWithResponse:response resposeString:responseString request:request error:error];
#endif
}

+ (void)logDebugInfoWithCachedResponse:(XZRequestResponse *)response methodName:(NSString *)methodName serviceIdentifier:(XZNetService *)service
{
#ifdef DEBUG
    
    if (![[XZNetDebug sharedInstance] showResponses]) {
        return;
    }
    
    [[XZNetDebug sharedInstance] logDebugInfoWithCachedResponse:response methodName:methodName serviceIdentifier:service];
#endif
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _showLogs = NO;
        _showRequests = YES;
        _showResponses = YES;
    }
    return self;
}

#pragma mark - private

- (void)logDebugInfoWithRequest:(NSURLRequest *)request apiName:(NSString *)apiName service:(XZNetService *)service requestParams:(id)requestParams httpMethod:(NSString *)httpMethod
{
    BOOL isOnline = NO;
    if ([service respondsToSelector:@selector(isOnline)]) {
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[service methodSignatureForSelector:@selector(isOnline)]];
        invocation.target = service;
        invocation.selector = @selector(isOnline);
        [invocation invoke];
        [invocation getReturnValue:&isOnline];
    }
    
    NSMutableString *logString = [NSMutableString stringWithString:@"\n\n**************************************************************\n*                       Request Start                        *\n**************************************************************\n\n"];
    
    [logString appendFormat:@"API Name:\t\t%@\n", [apiName XZNet_defaultValue:@"N/A"]];
    [logString appendFormat:@"Method:\t\t\t%@\n", [httpMethod XZNet_defaultValue:@"N/A"]];
    [logString appendFormat:@"Version:\t\t%@\n", [service.apiVersion XZNet_defaultValue:@"N/A"]];
    [logString appendFormat:@"Service:\t\t%@\n", [service class]];
    [logString appendFormat:@"Status:\t\t\t%@\n", isOnline ? @"online" : @"offline"];
    [logString appendFormat:@"Public Key:\t\t%@\n", [service.publicKey XZNet_defaultValue:@"N/A"]];
    [logString appendFormat:@"Private Key:\t%@\n", [service.privateKey XZNet_defaultValue:@"N/A"]];
    [logString appendFormat:@"Params:\n%@", requestParams];
    
    [logString appendURLRequest:request];
    
    [logString appendFormat:@"\n\n**************************************************************\n*                         Request End                        *\n**************************************************************\n\n\n\n"];
    NSLog(@"%@", logString);
}

- (void)logDebugInfoWithResponse:(NSHTTPURLResponse *)response resposeString:(NSString *)responseString request:(NSURLRequest *)request error:(NSError *)error
{
    BOOL shouldLogError = error ? YES : NO;
    
    NSMutableString *logString = [NSMutableString stringWithString:@"\n\n==============================================================\n=                        API Response                        =\n==============================================================\n\n"];
    
    [logString appendFormat:@"Status:\t%ld\t(%@)\n\n", (long)response.statusCode, [NSHTTPURLResponse localizedStringForStatusCode:response.statusCode]];
    [logString appendFormat:@"Content:\n\t%@\n\n", responseString];
    if (shouldLogError) {
        [logString appendFormat:@"Error Domain:\t\t\t\t\t\t\t%@\n", error.domain];
        [logString appendFormat:@"Error Domain Code:\t\t\t\t\t\t%ld\n", (long)error.code];
        [logString appendFormat:@"Error Localized Description:\t\t\t%@\n", error.localizedDescription];
        [logString appendFormat:@"Error Localized Failure Reason:\t\t\t%@\n", error.localizedFailureReason];
        [logString appendFormat:@"Error Localized Recovery Suggestion:\t%@\n\n", error.localizedRecoverySuggestion];
    }
    
    [logString appendString:@"\n---------------  Related Request Content  --------------\n"];
    
    [logString appendURLRequest:request];
    
    [logString appendFormat:@"\n\n==============================================================\n=                        Response End                        =\n==============================================================\n\n\n\n"];
    
    NSLog(@"%@", logString);
}

- (void)logDebugInfoWithCachedResponse:(XZRequestResponse *)response methodName:(NSString *)methodName serviceIdentifier:(XZNetService *)service
{
    NSMutableString *logString = [NSMutableString stringWithString:@"\n\n==============================================================\n=                      Cached Response                       =\n==============================================================\n\n"];
    
    [logString appendFormat:@"API Name:\t\t%@\n", [methodName XZNet_defaultValue:@"N/A"]];
    [logString appendFormat:@"Version:\t\t%@\n", [service.apiVersion XZNet_defaultValue:@"N/A"]];
    [logString appendFormat:@"Service:\t\t%@\n", [service class]];
    [logString appendFormat:@"Public Key:\t\t%@\n", [service.publicKey XZNet_defaultValue:@"N/A"]];
    [logString appendFormat:@"Private Key:\t%@\n", [service.privateKey XZNet_defaultValue:@"N/A"]];
    [logString appendFormat:@"Method Name:\t%@\n", methodName];
    [logString appendFormat:@"Params:\n%@\n\n", response.requestParams];
    [logString appendFormat:@"Content:\n\t%@\n\n", response.contentString];
    
    [logString appendFormat:@"\n\n==============================================================\n=                        Response End                        =\n==============================================================\n\n\n\n"];
    NSLog(@"%@", logString);
}

@end
