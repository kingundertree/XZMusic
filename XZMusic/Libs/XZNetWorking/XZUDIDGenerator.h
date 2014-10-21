//
//  XZUDIDGenerator.h
//  XZMusic
//
//  Created by xiazer on 14/10/21.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface XZUDIDGenerator : NSObject
@property (nonatomic, copy, readonly) NSString *udid;

+ (id)sharedInstance;

- (void)saveUDID:(NSString *)udid;

@end
