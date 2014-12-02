//
//  XZConvertTo.m
//  XZMusic
//
//  Created by xiazer on 14/11/11.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "XZMusicSongConvertToOb.h"

@implementation XZMusicSongConvertToOb

+ (XZSongModel *)converMusicSong:(NSDictionary *)musicInfo{
    XZSongModel *musicSongModel = [[XZSongModel alloc] init];
    
    if ([[musicInfo allKeys] count]>1) {
        NSDictionary * data = [musicInfo objectForKey:@"data"];
        NSArray *songList = [data objectForKey:@"songList"];
        for (NSDictionary *sub in songList) {
            musicSongModel.songLink = [sub objectForKey:@"songLink"];
            NSRange range = [musicSongModel.songLink rangeOfString:@"src"];
            if (range.location != 2147483647 && range.length != 0) {
                NSString * temp = [musicSongModel.songLink substringToIndex:range.location-1];
                musicSongModel.songLink = temp;
            }
            musicSongModel.songName = [sub objectForKey:@"songName"];
            musicSongModel.lrcLink = [sub objectForKey:@"lrcLink"];
            musicSongModel.songPicBig = [sub objectForKey:@"songPicBig"];
            musicSongModel.time = [[sub objectForKey:@"time"] intValue];
            musicSongModel.songId = [[sub objectForKey:@"songId"] intValue];
            musicSongModel.lrcLink = [sub objectForKey:@"lrcLink"];
            musicSongModel.format = [sub objectForKey:@"format"];
            musicSongModel.time = [[sub objectForKey:@"time"] intValue];
        }
    }
    
    return musicSongModel;
}

@end
