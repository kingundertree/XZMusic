//
//  XZTabBarView.h
//  XZMusic
//
//  Created by xiazer on 14-8-24.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol tabBarDelegate <NSObject>
- (void)tabBarClick:(NSInteger)index;
@end

@interface XZTabBarView : UIView
@property(nonatomic, assign) id<tabBarDelegate> delegate;

- (void)initTabBarView:(NSArray *)tabBarIconArr tabBarTitArr:(NSArray *)tabBarTitArr;
- (void)selectedTabBar:(NSInteger)index;
@end
