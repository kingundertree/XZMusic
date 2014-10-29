//
//  XZNetBridge.h
//  XZMusic
//
//  Created by xiazer on 14/10/19.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import <Foundation/Foundation.h>

unsigned int XZMusicGetServiceID;
unsigned int XZMusicPostServiceID;
unsigned int XZMusicRESTGetServiceID;
unsigned int XZMusicRESTPostServiceID;

unsigned int XZWeiboGetServiceID;


@interface XZNetBridge : NSObject

+ (id)sharedInstance;
+ (void)initServieId;

+ (NSString *)bridgeServiceWithId:(unsigned int)serviceId;

@end
