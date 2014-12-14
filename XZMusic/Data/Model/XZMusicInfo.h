//
//  XZMusicInfo.h
//  XZMusic
//
//  Created by xiazer on 14/12/9.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface XZMusicInfo : NSManagedObject

@property (nonatomic, retain) NSString * musicId;
@property (nonatomic, retain) NSString * musicName;
@property (nonatomic, retain) NSString * musicSongUrl;
@property (nonatomic, retain) NSNumber * musicIsDown;
@property (nonatomic, retain) NSNumber * musicLrcIsDown;
@property (nonatomic, retain) NSString * musicDetailInfoString;
@property (nonatomic, retain) NSNumber * musicPlayTime;
@property (nonatomic, retain) NSNumber * musicPlayedTime;
@property (nonatomic, retain) NSNumber * musicIsPraised;
@property (nonatomic, retain) NSString * musicAlbum;
@property (nonatomic, retain) NSString * musicAlbumId;
@property (nonatomic, retain) NSString * musicSonger;
@property (nonatomic, retain) NSNumber * musicTime;
@property (nonatomic, retain) NSString * musicLrcString;
@property (nonatomic, retain) NSString * musicLrcUrl;
@property (nonatomic, retain) NSString * musicFormat;
@property (nonatomic, retain) NSString * musicBigImgUrl;
@end
