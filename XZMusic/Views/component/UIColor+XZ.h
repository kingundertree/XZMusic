//
//  UIColor+XZ.h
//  XZMusic
//
//  Created by xiazer on 14-8-24.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (XZ)
+ (UIColor *) colorWithHex:(uint) hex alpha:(CGFloat)alpha;
//标题大字，正文内容
+ (UIColor *)XZBlackColor;
//小标题，附属说明文字
+ (UIColor *)XZMiddleGrayColor;
//辅助提示文字
+ (UIColor *)XZLightGrayColor;
// 深色背景上文字
+ (UIColor *)XZWhiteColor;
//底Tab选中色
+ (UIColor *)XZBlueColor;
//按钮色
+ (UIColor *)XZBabyBlueColor;
//气泡
+ (UIColor *)XZRedColor;
//蓝灰色
+ (UIColor *)XZBlueGrayColor;
//蓝黑色_i,顶部与底部_ios
+ (UIColor *)XZBlueBlackColor_i;
//绿色
+ (UIColor *)XZGreenColor;
//各页面背景
+ (UIColor *)XZBgPageColor;
//选中背景色
+ (UIColor *)XZBgSelectColor;
//分割线
+ (UIColor *)XZLineColor;
@end
