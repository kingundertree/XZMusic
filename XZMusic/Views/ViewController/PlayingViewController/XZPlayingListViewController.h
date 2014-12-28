//
//  XZPlayingListViewController.h
//  XZMusic
//
//  Created by xiazer on 14/12/2.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "XZBaseViewController.h"

typedef NS_ENUM(NSInteger, SongListType){
    SongListTypeForNoraml = 1, // 搜索歌曲列表
    SongListTypeForExist = 2 // 下载歌曲列表
};

@interface XZPlayingListViewController : XZBaseViewController
@property (nonatomic, assign) SongListType songListType;
@end
