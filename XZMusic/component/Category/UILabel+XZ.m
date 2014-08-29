//
//  UILabel+XZ.m
//  XZMusic
//
//  Created by xiazer on 14-8-29.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "UILabel+XZ.h"

@implementation UILabel (XZ)

+ (UILabel *)getTitleView:(NSString *)titleStr{
    UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 180, 44)];
    lb.backgroundColor = [UIColor clearColor];
    lb.font = [UIFont systemFontOfSize:16];
    lb.text = titleStr;
    lb.textAlignment = NSTextAlignmentCenter;
    lb.textColor = [UIColor whiteColor];
    
    return lb;
}

@end
