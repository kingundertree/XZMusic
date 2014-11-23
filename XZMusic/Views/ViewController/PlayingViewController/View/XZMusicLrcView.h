//
//  XZMusicLrcView.h
//  XZMusic
//
//  Created by xiazer on 14/11/19.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XZMusicLrcView : UIView

- (void)initLrcViewWithPath:(NSString *)lrcPath;
- (void)moveLrcWithTime:(int)time;
@end
