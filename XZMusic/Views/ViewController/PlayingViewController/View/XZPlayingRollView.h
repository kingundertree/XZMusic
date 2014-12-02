//
//  XZPlayingRollView.h
//  XZMusic
//
//  Created by xiazer on 14/12/2.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ENUM(NSInteger, XZPlayingRollViewActionType){
    XZPlayingRollViewActionTypeForPlaying = 1, // 播放
    XZPlayingRollViewActionTypeForPause = 2 // 暂停
};

@protocol XZPlayingRollViewDelegate <NSObject>
- (void)playingRollViewAction:(enum XZPlayingRollViewActionType)actionType;
@end

@interface XZPlayingRollView : UIView
@property (nonatomic, assign) id<XZPlayingRollViewDelegate> rollViewDelegate;
@property (nonatomic, strong) UIImageView *songBgImg;
@property (nonatomic, strong) UIButton *songPlayingBtn;
@property (nonatomic, assign) enum XZPlayingRollViewActionType rollPlayingPlayStatus;

- (void)configRooViewData:(NSString *)bigImgUrl;
@end
