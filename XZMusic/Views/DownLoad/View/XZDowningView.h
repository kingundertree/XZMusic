//
//  XZDowningView.h
//  XZMusic
//
//  Created by xiazer on 14/12/17.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XZDowningViewDelegate <NSObject>
- (void)didSelectMusicInfoForDowning:(NSInteger)indexNum musicInfo:(XZMusicInfo *)musicInfo;
@end

@interface XZDowningView : UIView

@property (nonatomic, assign) id<XZDowningViewDelegate> downingViewDelegate;
- (void)initData;

@end
