//
//  UIColor+XZ.m
//  XZMusic
//
//  Created by xiazer on 14-8-24.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "UIColor+XZ.h"

@implementation UIColor (XZ)

+ (UIColor *) colorWithHex:(uint) hex alpha:(CGFloat)alpha
{
	int red, green, blue;
	
	blue = hex & 0x0000FF;
	green = ((hex & 0x00FF00) >> 8);
	red = ((hex & 0xFF0000) >> 16);
	
	return [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:alpha];
}


//标题大字，正文内容
+ (UIColor *)XZBlackColor{
    return [UIColor colorWithHex:0x3D4245 alpha:1.0];
}
//小标题，附属说明文字
+ (UIColor *)XZMiddleGrayColor{
    return [UIColor colorWithHex:0x5F646E alpha:1.0];
}
//辅助提示文字
+ (UIColor *)XZLightGrayColor{
    return [UIColor colorWithHex:0x999999 alpha:1.0];
}
// 深色背景上文字
+ (UIColor *)XZWhiteColor{
    return [UIColor colorWithHex:0xFFFFFF alpha:1.0];
}
//底Tab选中色
+ (UIColor *)XZBlueColor{
    return [UIColor colorWithHex:0x1A8FF2 alpha:1.0];
}
//按钮色
+ (UIColor *)XZBabyBlueColor{
    return [UIColor colorWithHex:0x4FA4EC alpha:1.0];
}
//气泡
+ (UIColor *)XZRedColor{
    return [UIColor colorWithHex:0xF43530 alpha:1.0];
}
//蓝灰色
+ (UIColor *)XZBlueGrayColor{
    return [UIColor colorWithHex:0x8A98AA alpha:1.0];
}
//蓝黑色_i,顶部与底部_ios
+ (UIColor *)XZBlueBlackColor_i{
    return [UIColor colorWithHex:0x252D3B alpha:1.0];
}
//绿色
+ (UIColor *)XZGreenColor{
    return [UIColor colorWithHex:0x008C00 alpha:1.0];
}
//各页面背景
+ (UIColor *)XZBgPageColor{
    return [UIColor colorWithHex:0xEFEFF4 alpha:1.0];
}
//选中背景色
+ (UIColor *)XZBgSelectColor{
    return [UIColor colorWithHex:0xD9D9D9 alpha:1.0];
}
//分割线
+ (UIColor *)XZLineColor{
    return [UIColor colorWithHex:0xC7C7CC alpha:1.0];
}

@end
