//
//  XZMyLovedView.h
//  XZMusic
//
//  Created by xiazer on 15/1/1.
//  Copyright (c) 2015年 xiazer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XZMyAddPraiseView : UIView

@property (nonatomic, copy) void(^completedBlock)(BOOL completed);
- (void)displayUI:(void(^)(BOOL completed))Block;

@end
