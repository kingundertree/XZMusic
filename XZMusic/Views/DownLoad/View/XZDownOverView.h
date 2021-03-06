//
//  XZDownOverView.h
//  XZMusic
//
//  Created by xiazer on 14/12/17.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XZDownOverViewDelegate <NSObject>

- (void)downOverMusicNum:(NSInteger)num;
- (void)didSelectMusicInfo:(NSInteger)indexNum musicInfo:(XZMusicInfo *)musicInfo;
@end

@interface XZDownOverView : UIView
@property (nonatomic, assign) id<XZDownOverViewDelegate> downOverDelegate;

- (void)initData;
- (void)updateTable;

@end
