//
//  XZMusicDataCenter.h
//  XZMusic
//
//  Created by xiazer on 14/11/8.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+LKDBHelper.h"
#import "XZMusicSingerModel.h"

@interface XZMusicDataCenter : NSObject

+ (XZMusicDataCenter *)shareInstance;


- (NSMutableArray *)topMusic100;
- (NSMutableArray *)searchMusicWithKeyword:(NSString *)keyword;

@end
