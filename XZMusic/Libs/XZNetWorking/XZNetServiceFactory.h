//
//  XZNetServiceFactory.h
//  XZMusic
//
//  Created by xiazer on 14/10/21.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XZNetService.h"

@interface XZNetServiceFactory : NSObject
+ (id)shareInstance;

- (XZNetService<XZNetServiceProtocal> *)serviceWithIdentifier:(NSString *)identifier;

@end
