//
//  NSString+XZ.m
//  XZMusic
//
//  Created by xiazer on 14/12/14.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "NSString+XZ.h"

@implementation NSString (XZ)

- (NSDictionary *)stringTransFormToDic:(NSString *)string
{
    NSData *data = [string dataUsingEncoding:NSASCIIStringEncoding];
    NSError *error = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:data
                                                    options:NSJSONReadingAllowFragments
                                                      error:&error];
    
    if (jsonObject != nil && error == nil){
        return jsonObject;
    }else{
        return nil;
    }
}
- (NSArray *)stringTransFormToArray:(NSString *)string
{
    NSData *data = [string dataUsingEncoding:NSASCIIStringEncoding];
    NSError *error = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:data
                                                    options:NSJSONReadingAllowFragments
                                                      error:&error];
    
    if (jsonObject != nil && error == nil){
        return jsonObject;
    }else{
        return nil;
    }
}


@end
