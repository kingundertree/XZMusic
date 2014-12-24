//
//  XZMusicDownloadResponse.h
//  XZMusic
//
//  Created by xiazer on 14/11/20.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ENUM(NSInteger, XZMusicDownloadStatus) {
    XZMusicDownloadSuccess = 1, // 下载成功
    XZMusicDownloadIng = 2, // 下载中
    XZMusicDownloadFail = 3, // 下载失败
    XZMusicDownloadNetError = 4, // 网络不畅

};

NS_ENUM(NSInteger, XZMusicdownloadStyle){
    XZMusicdownloadStyleForMusic = 1, // 音乐
    XZMusicdownloadStyleForLrc = 2 // 歌词
};

@interface XZMusicDownloadResponse : NSObject

@property(nonatomic, strong) NSDictionary *content;
@property(nonatomic, strong) NSString *downloadIdentify;
@property(nonatomic, strong) NSString *musicId;
@property(nonatomic, assign) float progress;
@property(nonatomic, assign) enum XZMusicDownloadStatus downloadStatus;
@property(nonatomic, assign) enum XZMusicdownloadStyle downloadStyle;

@end
