//
//  XZBaseButton+IconWithTitle.m
//  XZMusic
//
//  Created by xiazer on 14-8-29.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "XZBaseButton+IconWithTitle.h"

@implementation XZBaseButton (IconWithTitle)

- (void)showTitlt:(NSString *)title textColor:(UIColor *)textColor font:(UIFont *)font icon:(NSString *)icon{
    UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 25, 25)];
    iconView.image = [UIImage imageNamed:icon];
    [self addSubview:iconView];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, self.bounds.size.width-50, self.bounds.size.height)];
    lab.backgroundColor = [UIColor clearColor];
    lab.font = font;
    lab.text = title;
    lab.textColor = textColor;
    lab.textAlignment = NSTextAlignmentLeft;
    [self addSubview:lab];
}

@end
