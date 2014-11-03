//
//  XZRequestResponse.m
//  XZMusic
//
//  Created by xiazer on 14/10/19.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "XZRequestResponse.h"
#import "NSObject+XZNetMethod.h"
#import "NSURLRequest+XZNetMethod.h"

@interface XZRequestResponse ()
@property (nonatomic, copy, readwrite) NSURLRequest *request;
@property (nonatomic, copy, readwrite) NSData *responseData;
@property (nonatomic, assign, readwrite) BOOL isCache;
@end

@implementation XZRequestResponse

- (instancetype)initWithResponseString:(NSString *)responseString requestId:(NSNumber *)requestId request:(NSURLRequest *)request responseData:(NSData *)responseData status:(enum XZNetWorkingResponseStatus)status
{
    self = [super init];
    if (self) {
        self.contentString = [responseString XZNet_defaultValue:@""];
        self.status = status;
        self.requestId = [requestId integerValue];
        self.request = request;
        self.responseData = responseData;
        self.requestParams = request.requestParams;
        self.isCache = NO;
        self.content = [self createContentWithData:self.responseData];
    }
    return self;
}

- (instancetype)initWithResponseString:(NSString *)responseString requestId:(NSNumber *)requestId request:(NSURLRequest *)request responseData:(NSData *)responseData error:(NSError *)error
{
    self = [super init];
    if (self) {
        self.contentString = [responseString XZNet_defaultValue:@""];
        self.status = [self responseStatusWithError:error];
        self.requestId = [requestId integerValue];
        self.request = request;
        self.responseData = responseData;
        self.requestParams = request.requestParams;
        self.isCache = NO;
        self.content = [self createContentWithData:self.responseData];
    }
    return self;
}


#pragma mark - private methods
- (enum XZNetWorkingResponseStatus)responseStatusWithError:(NSError *)error
{
    if (error) {
        enum XZNetWorkingResponseStatus result = XZNetWorkingResponseStatusError;
        
        // 除了超时以外，所有错误都当成是无网络
        if (error.code == NSURLErrorTimedOut) {
            result = XZNetWorkingResponseStatusTimeOut;
        }
        return result;
    } else {
        return XZNetWorkingResponseStatusSuccess;
    }
}

- (void)updateWithContent:(id)content requestId:(NSInteger)requestId status:(enum XZNetWorkingResponseStatus)status
{
    self.content = content;
    self.requestId = requestId;
    self.status = status;
    
    if (![self checkMutableContainer:self.content]) {
        self.content = nil;
    }
}

- (id)createContentWithData:(NSData *)data
{
    id content = data ? [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil] : nil;
    if (![self checkMutableContainer:content]) {
        content = nil;
    }
    
    return content;
}

- (BOOL)checkMutableContainer:(id)value
{
    return ([value isKindOfClass:[NSArray class]] ||
            [value isKindOfClass:[NSDictionary class]]);
}


@end
