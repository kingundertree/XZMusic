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
#import "DOUAudioStreamer.h"
#import "XZPlaySongModel.h"

@interface XZMusicPlayViewController : XZBaseViewController

@property(nonatomic, strong) XZMusicSongModel *musicSongModel;
@property(nonatomic, strong) XZPlaySongModel *playSongModel;
@property(nonatomic, strong) DOUAudioStreamer *audioPlayer;

+ (XZMusicPlayViewController *)shareInstance;
- (void)playingMusicWithSong:(XZMusicSongModel *)musicSongModel;

@end
