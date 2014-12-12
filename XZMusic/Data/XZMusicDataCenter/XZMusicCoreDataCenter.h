//
//  XZMusicDataCenter.h
//  XZMusic
//
//  Created by xiazer on 14/12/10.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "XZUserInfo.h"
#import "XZMusicInfo.h"

@class XZMusicCoreDataCenter;
@protocol XZMusicDataCenterDelegate <NSObject>

@end

@interface XZMusicCoreDataCenter : NSObject
+ (XZMusicCoreDataCenter *)shareInstance;

@property (nonatomic, assign) id<XZMusicDataCenterDelegate> dataCenterDelegate;
- (instancetype)init;

- (BOOL)isUserExit:(NSString *)userWeiboId;
- (XZUserInfo *)fetchUserInfo:(NSString *)userWeiboId;
- (XZUserInfo *)saveNewUserInfo:(NSDictionary *)userInfo;
- (BOOL)updateUserLoginInfo:(NSString *)userWeiboId isLogin:(BOOL)isLogin;
- (XZUserInfo *)fetchLoginUserInfo;


@end
