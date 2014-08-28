//
//  XZBaseButton+CornerRadius.m
//  XZMusic
//
//  Created by xiazer on 14-8-28.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "XZBaseButton+CornerRadius.h"

@implementation XZBaseButton (CornerRadius)

- (void)setRadius:(float)borderWith borderColor:(UIColor *)borderColor{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = self.frame.size.width/2;
    self.layer.borderWidth = borderWith;
    self.layer.borderColor = borderColor.CGColor;

}


- (void)showTitlt:(NSString *)title textColor:(UIColor *)textColor font:(UIFont *)font{
    UILabel *lab = [[UILabel alloc] initWithFrame:self.bounds];
    lab.backgroundColor = [UIColor clearColor];
    lab.font = font;
    lab.text = title;
    lab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:lab];
}
@end
