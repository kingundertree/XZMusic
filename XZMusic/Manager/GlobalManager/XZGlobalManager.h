//
//  XZGlobalManager.h
//  XZMusic
//
//  Created by xiazer on 14/12/6.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XZMusicInfo.h"

@interface XZGlobalManager : NSObject

+ (XZGlobalManager *)shareInstance;

@property (nonatomic, assign) BOOL isPlaying;
@property (nonatomic, assign) BOOL isNeedDown;
@property (nonatomic, strong) NSString *playMusicId;
@property (nonatomic, assign) NSInteger playIndex;
@property (nonatomic, strong) NSMutableArray *musicArr;
@property (nonatomic, strong) NSMutableArray *musicDownArr;
@property (nonatomic, strong) NSString *userWeiboId;


- (void)updateMusicDownInfo:(XZMusicInfo *)musicInfo;
@end
