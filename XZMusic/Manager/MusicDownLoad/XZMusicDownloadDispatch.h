//
//  XZMusicDownloadDispatch.h
//  XZMusic
//
//  Created by xiazer on 14/11/22.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XZMusicDownloadResponse.h"

@interface XZMusicDownloadDispatch : NSObject
@property(nonatomic, copy) void(^downloadBlock)(XZMusicDownloadResponse *response);
@property(nonatomic, strong) NSString *identifyStr;
@end
