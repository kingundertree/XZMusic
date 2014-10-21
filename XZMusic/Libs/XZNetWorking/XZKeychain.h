//
//  XZKeychain.h
//  XZMusic
//
//  Created by xiazer on 14/10/21.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XZKeychain : NSObject
- (id)initWithService:(NSString *)service withGroup:(NSString *)group;
- (BOOL)insert:(NSString *)key data:(NSData *)data;
- (BOOL)update:(NSString *)key data:(NSData *)data;
- (BOOL)remove:(NSString *)key;
- (NSData *)find:(NSString *)key;

@end
