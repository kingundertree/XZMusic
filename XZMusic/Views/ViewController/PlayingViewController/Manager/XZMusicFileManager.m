//
//  XZMusicFileManager.m
//  XZMusic
//
//  Created by xiazer on 14/12/6.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "XZMusicFileManager.h"

@implementation XZMusicFileManager

+ (BOOL)isHasMusicOrLrc:(BOOL)isMusic songModel:(XZMusicInfo *)songModel {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSArray *myPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *myDocPath = [myPaths objectAtIndex:0];
    
    NSString *path;
    if (isMusic) {
        path = [myDocPath stringByAppendingString:[NSString stringWithFormat:@"/music/%@/%@.%@",songModel.musicId,songModel.musicId,songModel.musicFormat]];
    }else {
        path = [myDocPath stringByAppendingString:[NSString stringWithFormat:@"/music/%@/%@.lrc",songModel.musicId,songModel.musicId]];
    }
    
    if ([fileManager fileExistsAtPath:path]) {
        return YES;
    }else {
        return NO;
    }
}

+ (NSString *)getMusicPath:(XZMusicInfo *)songModel {
    NSArray *myPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *myDocPath = [myPaths objectAtIndex:0];
    
    NSString *musicPath = [myDocPath stringByAppendingString:[NSString stringWithFormat:@"/music/%@/%@.%@",songModel.musicId,songModel.musicId,songModel.musicFormat]];
    
    return musicPath;
}

+ (NSString *)getMusicLrcPath:(XZMusicInfo *)songModel {
    NSArray *myPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *myDocPath = [myPaths objectAtIndex:0];
    
    NSString *lrcPath = [myDocPath stringByAppendingString:[NSString stringWithFormat:@"/music/%@/%@.lrc",songModel.musicId,songModel.musicId]];

    return lrcPath;
}



@end
