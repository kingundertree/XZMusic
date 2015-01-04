//
//  XZMyHeardView.h
//  XZMusic
//
//  Created by xiazer on 15/1/3.
//  Copyright (c) 2015年 xiazer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XZMyHeardView : UIView
@property (nonatomic, copy) void(^completedBlock)(BOOL completed);
- (void)displayUI:(void(^)(BOOL completed))Block;

@end
