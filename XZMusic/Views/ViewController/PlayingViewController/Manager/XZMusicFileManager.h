//
//  XZMusicFileManager.h
//  XZMusic
//
//  Created by xiazer on 14/12/6.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XZSongModel.h"

@interface XZMusicFileManager : NSObject

+ (BOOL)isHasMusicOrLrc:(BOOL)isMusic songModel:(XZSongModel *)songModel;
+ (NSString *)getMusicPath:(XZSongModel *)songModel;
+ (NSString *)getMusicLrcPath:(XZSongModel *)songModel;
@end
