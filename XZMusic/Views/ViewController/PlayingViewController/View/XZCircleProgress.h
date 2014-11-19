//
//  XZCircleProgress.h
//  XZCirclProgress
//
//  Created by xiazer on 14/11/19.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ENUM(NSInteger, XZCircleProgressStyle){
    XZCircleProgressStyleForMusicDown = 1, // 下载音乐
    XZCircleProgressStyleForMusicPlaying = 2, // 播放音乐
};

@interface XZCircleProgress : UIView

@property(nonatomic, assign) float progressV;
@property(nonatomic, assign) enum XZCircleProgressStyle progressStyle;
@end
