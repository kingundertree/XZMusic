//
//  XZPlaySongModel.h
//  XZMusic
//
//  Created by xiazer on 14/11/12.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DOUAudioFile.h"

@interface XZPlaySongModel : NSObject <DOUAudioFile>

@property (nonatomic, strong) NSString *artist;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSURL *audioFileURL;

@end
