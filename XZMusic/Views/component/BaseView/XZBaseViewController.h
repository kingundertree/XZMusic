//
//  XZBaseViewController.h
//  XZMusic
//
//  Created by xiazer on 14-8-24.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    BackTypePopBack = 0,
    BackTypeDismiss,
    BackTypePopToRoot,
    BackTypeForMenu,
    BackTypeNone
} BackType;


@interface XZBaseViewController : UIViewController
@property (nonatomic, assign) BackType backType;
@property (nonatomic, assign) BOOL isLoading;

- (void)doBack:(id)sender;
- (void)addRightButton:(NSString *)title;
- (void)rightButtonAction:(id)sender;
- (void)setTitleViewWithString:(NSString *)titleStr;

@end
