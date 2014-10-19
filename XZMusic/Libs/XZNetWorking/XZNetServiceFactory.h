//
//  XZNetServiceFactory.h
//  XZMusic
//
//  Created by xiazer on 14/10/19.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XZNetService.h"
#import "XZMusicForBaidu.h"

@interface XZNetServiceFactory : NSObject

#pragma mark - public methods
+ (id)shareInstance;

- (XZNetService<XZNetServiceProtocal> *)serviceWithIdentifier:(NSString *)identifier;

@end
