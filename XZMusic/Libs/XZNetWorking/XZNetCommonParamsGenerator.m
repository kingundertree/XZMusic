//
//  XZNetCommonParamsGenerator.m
//  XZMusic
//
//  Created by xiazer on 14/10/21.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "XZNetCommonParamsGenerator.h"
#import "XZAppContext.h"
#import "UIDevice+XZIdentifierAddition.h"

@implementation XZNetCommonParamsGenerator
+ (NSDictionary *)commonParamsDictionary
{
    XZAppContext *context = [XZAppContext sharedInstance];
    
    //@"cid":context.cid,
    return @{@"ostype2":context.ostype2,
                                  @"udid2":context.udid2,
                                  @"uuid2":context.uuid2,
                                  @"app":context.appName,
                                  @"cv":context.cv,
                                  @"from":context.from,
                                  @"m":context.m,
                                  @"macid":context.macid,
                                  @"o":context.o,
                                  @"pm":context.pm,
                                  @"qtime":context.qtime,
                                  @"uuid":context.uuid,
                                  @"i":context.i,
                                  @"v":context.v
                                  };
}

+ (NSDictionary *)commonParamsDictionaryForLog
{
    XZAppContext *context = [XZAppContext sharedInstance];
    return @{
             @"guid":context.guid,
             @"dvid":context.dvid,
             @"net":context.net,
             @"ver":context.ver,
             @"ip":context.ip,
             @"mac":context.mac,
             @"geo":context.geo,
             @"uid":context.uid,
             @"chat_id":context.chatid,
             @"ccid":context.ccid,
             @"gcid":context.gcid,
             @"p":context.p,
             @"os":context.os,
             @"v":context.v,
             @"app":context.app,
             @"ch":context.channelID,
             @"ct":context.ct,
             @"pmodel":context.pmodel
             };
}

+ (NSDictionary *)sigCommParamsOldWithService:(XZNetService<XZNetServiceProtocal> *)service
{
    XZAppContext *context = [XZAppContext sharedInstance];
    return @{
             @"i":[[UIDevice currentDevice] XZNet_udid],
             @"macid":context.macid,
             @"m":context.m,
             @"o":context.os,
             @"v":context.v,
             @"cv":context.cv,
             @"pm":context.channelID,
             @"app":service.appName,
             @"cid":context.cid
             };
}

+ (NSDictionary *)outSigCommParamsOldWithService:(XZNetService<XZNetServiceProtocal> *)service
{
    XZAppContext *context = [XZAppContext sharedInstance];
    return @{
             @"ostype2": context.ostype2,
             @"udid2": context.udid2,
             @"uuid2": context.uuid2
             };
}

@end
