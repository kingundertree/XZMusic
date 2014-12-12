//
//  XZWBLoginManager.h
//  XZMusic
//
//  Created by xiazer on 14-9-16.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XZWBLoginManager.h"


typedef enum : NSUInteger {
    WBLoginResultForNone,
    WBLoginResultSuccess,
    WBLoginResultFail,
    WBLoginResultCancel,
    WBLoginResultNoSupport
} WBLoginResult;

typedef void (^WBLoginBack)(WBLoginResult result, id callBackValue);

@interface XZWBLoginManager : NSObject

+ (id)sharedInstance;
- (void)WBLoginWithFinishBlock:(WBLoginBack)block;
- (BOOL)WbHandUrl:(NSURL *)url;


@end
