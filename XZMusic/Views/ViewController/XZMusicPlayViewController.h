//
//  XZMusicPlayViewController.h
//  XZMusic
//
//  Created by xiazer on 14-8-29.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "XZBaseViewController.h"
#import "XZMusicSongModel.h"
#import "XZSongModel.h"

@interface XZMusicPlayViewController : XZBaseViewController

@property(nonatomic, strong) XZMusicSongModel *musicSongModel;

+ (XZMusicPlayViewController *)shareInstance;
- (void)playingMusicWithSong:(XZMusicSongModel *)musicSongModel;

@end
