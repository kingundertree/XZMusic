//
//  NSDictionary+XZNetMethod.h
//  XZMusic
//
//  Created by xiazer on 14/10/21.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (XZNetMethod)
- (NSString *)XZNet_urlParamsStringSignature:(BOOL)isForSignature;
- (NSString *)XZNet_jsonString;
- (NSArray *)XZNet_transformedUrlParamsArraySignature:(BOOL)isForSignature;

@end
