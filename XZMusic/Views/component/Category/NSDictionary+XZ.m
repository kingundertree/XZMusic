//
//  NSDictionary+XZ.m
//  XZMusic
//
//  Created by xiazer on 14/12/14.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "NSDictionary+XZ.h"

@implementation NSDictionary (XZ)

- (NSString *)dataTransformToString
{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    if ([jsonData length] > 0 && error == nil){
        NSString *jsonString = [[NSString alloc] initWithData:jsonData
                                                     encoding:NSUTF8StringEncoding];
        return jsonString;
    }else{
        return nil;
    }
}

@end
