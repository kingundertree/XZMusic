//
//  XZNetCommonParamsGenerator.h
//  XZMusic
//
//  Created by xiazer on 14/10/21.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XZNetService.h"

@interface XZNetCommonParamsGenerator : NSObject
+ (NSDictionary *)commonParamsDictionary;
+ (NSDictionary *)commonParamsDictionaryForLog;

+ (NSDictionary *)sigCommParamsOldWithService:(XZNetService<XZNetServiceProtocal> *)service;
+ (NSDictionary *)outSigCommParamsOldWithService:(XZNetService<XZNetServiceProtocal> *)service;

@end
