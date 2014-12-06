//
//  XZMusicFileManager.m
//  XZMusic
//
//  Created by xiazer on 14/12/6.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "XZMusicFileManager.h"

@implementation XZMusicFileManager

+ (BOOL)isHasMusicOrLrc:(BOOL)isMusic songModel:(XZSongModel *)songModel {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSArray *myPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *myDocPath = [myPaths objectAtIndex:0];
    
    NSString *path;
    if (isMusic) {
        path = [myDocPath stringByAppendingString:[NSString stringWithFormat:@"/music/%lld/%lld.%@",songModel.songId,songModel.songId,songModel.format]];
    }else {
        path = [myDocPath stringByAppendingString:[NSString stringWithFormat:@"/music/%lld/%lld.lrc",songModel.songId,songModel.songId]];
    }
    
    if ([fileManager fileExistsAtPath:path]) {
        return YES;
    }else {
        return NO;
    }
}

+ (NSString *)getMusicPath:(XZSongModel *)songModel {
    NSArray *myPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *myDocPath = [myPaths objectAtIndex:0];
    
    NSString *musicPath = [myDocPath stringByAppendingString:[NSString stringWithFormat:@"/music/%lld/%lld.%@",songModel.songId,songModel.songId,songModel.format]];
    
    return musicPath;
}

+ (NSString *)getMusicLrcPath:(XZSongModel *)songModel {
    NSArray *myPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *myDocPath = [myPaths objectAtIndex:0];
    
    NSString *lrcPath = [myDocPath stringByAppendingString:[NSString stringWithFormat:@"/music/%lld/%lld.lrc",songModel.songId,songModel.songId]];

    return lrcPath;
}



@end
