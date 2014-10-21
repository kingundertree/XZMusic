//
//  NSURLRequest+XZNetMethod.m
//  XZMusic
//
//  Created by xiazer on 14/10/21.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "NSURLRequest+XZNetMethod.h"
#import <objc/runtime.h>

static void *XZNetworkingRequestParams;

@implementation NSURLRequest (XZNetMethod)
- (void)setRequestParams:(NSDictionary *)requestParams{
    objc_setAssociatedObject(self, &XZNetworkingRequestParams, requestParams, OBJC_ASSOCIATION_COPY);
}

- (NSDictionary *)requestParams{
    return objc_getAssociatedObject(self, &XZNetworkingRequestParams);
}
@end
