//
//  XZNetBridge.m
//  XZMusic
//
//  Created by xiazer on 14/10/19.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "XZNetBridge.h"

unsigned int XZMusicGetServiceID;
unsigned int XZMusicPostServiceID;
unsigned int XZMusicRESTGetServiceID;
unsigned int XZMusicRESTPostServiceID;

static unsigned int RTServiceID = 0;
static NSArray *bridgeServiceTypeMap = nil;

NSString * const NXZMusicServiceGet = @"NXZMusicServiceGet";
NSString * const NXZMusicServicePost = @"NXZMusicServicePost";
NSString * const NXZMusicServiceRESTGet = @"NXZMusicServiceRESTGet";
NSString * const NXZMusicServiceRESTPost = @"NXZMusicServiceRESTPost";


@interface XZNetBridge ()
@end

@implementation XZNetBridge

+ (id)sharedInstance
{
    static dispatch_once_t pred;
    static XZNetBridge *sharedInstance = nil;
    dispatch_once(&pred, ^{
        sharedInstance = [[XZNetBridge alloc] init];
    });
    return sharedInstance;
}

+ (void)initialize{
    bridgeServiceTypeMap = @[NXZMusicServiceGet,
                             NXZMusicServicePost,
                             NXZMusicServiceRESTGet,
                             NXZMusicServiceRESTPost];
 
    XZMusicGetServiceID = RTServiceID;
    XZMusicPostServiceID = [self nextService];
    XZMusicRESTGetServiceID = [self nextService];
    XZMusicRESTPostServiceID = [self nextService];
}

+ (NSString *)bridgeServiceWithId:(unsigned int)serviceId{
    return [[XZNetBridge sharedInstance] bridgeServiceWithId:serviceId];
}

- (NSString *)bridgeServiceWithId:(unsigned int)serviceId
{
    return bridgeServiceTypeMap[serviceId];
}

+ (unsigned int)nextService{
    return ++RTServiceID;
};

@end
