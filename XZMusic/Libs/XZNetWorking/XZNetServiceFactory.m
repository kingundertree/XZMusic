//
//  XZNetServiceFactory.m
//  XZMusic
//
//  Created by xiazer on 14/10/21.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "XZNetServiceFactory.h"
#import "XZMusicForBaidu.h"

// XZMusic
NSString * const kXZMusicServiceGet = @"kXZMusicServiceGet";
NSString * const kXZMusicServicePost = @"kXZMusicServicePost";
NSString * const kXZMusicServiceRESTGet = @"kXZMusicServiceRESTGet";
NSString * const kXZMusicServiceRESTPost = @"kXZMusicServiceRESTPost";

@interface XZNetServiceFactory ()
@property(nonatomic, strong) NSMutableDictionary *serviceStorage;
@end

@implementation XZNetServiceFactory

- (NSMutableDictionary *)serviceStorage{
    if (!_serviceStorage) {
        _serviceStorage = [[NSMutableDictionary alloc] init];
    }
    
    return _serviceStorage;
}

+ (id)shareInstance{
    static dispatch_once_t pred;
    static XZNetServiceFactory *sharedInstance = nil;
    dispatch_once(&pred, ^{
        sharedInstance = [[XZNetServiceFactory alloc] init];
    });
    return sharedInstance;
}

- (XZNetService<XZNetServiceProtocal> *)serviceWithIdentifier:(NSString *)identifier{
    if (!self.serviceStorage[identifier]) {
        self.serviceStorage[identifier] = [self newServiceWithIdentify:identifier];
    }
    
    return self.serviceStorage[identifier];
}

- (XZNetService<XZNetServiceProtocal> *)newServiceWithIdentify:(NSString *)identify{
    if ([identify isEqualToString:kXZMusicServiceGet]) {
        return [[XZMusicForBaidu alloc] init];
    }
    return nil;
}


@end
