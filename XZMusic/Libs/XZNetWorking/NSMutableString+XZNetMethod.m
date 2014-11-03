//
//  NSMutableString+XZNetMethod.m
//  XZMusic
//
//  Created by xiazer on 14/11/3.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "NSMutableString+XZNetMethod.h"
#import "NSObject+XZNetMethod.h"

@implementation NSMutableString (XZNetMethod)

- (void)appendURLRequest:(NSURLRequest *)request{
    [self appendFormat:@"\n\nHTTP URL:\n\t%@", request.URL];
    [self appendFormat:@"\n\nHTTP Header:\n%@", request.allHTTPHeaderFields ? request.allHTTPHeaderFields : @"\t\t\t\t\tN/A"];
    [self appendFormat:@"\n\nHTTP Body:\n\t%@", [[[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding] XZNet_defaultValue:@"\t\t\t\tN/A"]];
}


@end
