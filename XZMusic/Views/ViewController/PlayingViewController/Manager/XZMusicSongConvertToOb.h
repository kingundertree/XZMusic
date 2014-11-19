//
//  XZConvertTo.h
//  XZMusic
//
//  Created by xiazer on 14/11/11.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XZSongModel.h"

@interface XZMusicSongConvertToOb : NSObject

+ (XZSongModel *)converMusicSong:(NSDictionary *)musicInfo;

@end
