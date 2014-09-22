//
//  XZLeftMenu.h
//  XZMusic
//
//  Created by xiazer on 14-8-24.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XZLeftMenu : UIView
@property(nonatomic, strong) NSMutableArray *menuVCArr;


- (void)menuShow:(BOOL)isMenuShow;
- (void)updateUserLoginInfo:(NSDictionary *)userInfoDic;
@end
