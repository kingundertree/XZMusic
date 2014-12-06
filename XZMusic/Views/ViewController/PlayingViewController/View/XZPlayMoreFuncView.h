//
//  XZPlayMoreFuncView.h
//  XZMusic
//
//  Created by xiazer on 14/12/2.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ENUM(NSInteger, XZPlayMoreFuncViewActionType){
    XZPlayMoreFuncViewActionTypeForPre = 1, // 前一首
    XZPlayMoreFuncViewActionTypeForNext = 2, // 后一首
    XZPlayMoreFuncViewActionTypeForDown = 3, // 下载
    XZPlayMoreFuncViewActionTypeForAddPraise = 4, // 点赞
    XZPlayMoreFuncViewActionTypeForCanclePraise = 5 // 取消赞
};


@protocol XZPlayMoreFuncViewDelegate <NSObject>
- (void)funcViewAction:(enum XZPlayMoreFuncViewActionType)actionType;
@end

@interface XZPlayMoreFuncView : UIView
@property (nonatomic, assign) id<XZPlayMoreFuncViewDelegate> funcViewDelegate;

- (void)showCircleProgress:(float)progress;
@end
