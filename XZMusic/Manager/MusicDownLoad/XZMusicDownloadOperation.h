//
//  XZMusicDownloadOperation.h
//  XZMusic
//
//  Created by xiazer on 14/11/22.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "XZMusicDownloadResponse.h"

@interface XZMusicDownloadOperation : NSObject

- (AFHTTPRequestOperation *)downloadMusic:(NSString *)musicId musicUrlStr:(NSString *)musicUrlStr identify:(NSString *)identify isMusic:(BOOL)isMusic downloadBlock:(void(^)(XZMusicDownloadResponse *response))downloadBlock;

@end
