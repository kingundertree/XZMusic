//
//  XZMusicFileManager.h
//  XZMusic
//
//  Created by xiazer on 14/12/6.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XZMusicInfo.h"

@interface XZMusicFileManager : NSObject

+ (BOOL)isHasMusicOrLrc:(BOOL)isMusic songModel:(XZMusicInfo *)songModel;
+ (NSString *)getMusicPath:(XZMusicInfo *)songModel;
+ (NSString *)getMusicLrcPath:(XZMusicInfo *)songModel;
@end
