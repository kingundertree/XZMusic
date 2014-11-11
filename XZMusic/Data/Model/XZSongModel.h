//
//  XZSongModel.h
//  XZMusic
//
//  Created by xiazer on 14/11/11.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XZSongModel : NSObject

@property (nonatomic,assign) long long  queryId;
@property (nonatomic,assign) long long  songId;
@property (nonatomic,copy) NSString * songName;
@property (nonatomic,assign) long long  artistId;
@property (nonatomic,copy) NSString * artistName;
@property (nonatomic,assign) long long  albumId;
@property (nonatomic,copy) NSString * albumName;
@property (nonatomic,copy) NSString * songPicSmall;
@property (nonatomic,copy) NSString * songPicBig;
@property (nonatomic,copy) NSString * songPicRadio;
@property (nonatomic,copy) NSString * lrcLink;
@property (nonatomic,copy) NSString * version;
@property (nonatomic,assign) int copyType;
@property (nonatomic,assign) int time;
@property (nonatomic,assign) int linkCode;
@property (nonatomic,copy) NSString * songLink;
@property (nonatomic,copy) NSString * showLink;
@property (nonatomic,copy) NSString * format;
@property (nonatomic,assign) int rate;
@property (nonatomic,assign) long long  size;

@end
