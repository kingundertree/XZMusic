//
//  XZTabBarView.m
//  XZMusic
//
//  Created by xiazer on 14-8-24.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "XZTabBarView.h"
#import "XZLineView.h"

@interface XZTabBarView ()
@property(nonatomic, strong) XZLineView *lineView;
@property(nonatomic, assign) float menuWidth;

@end

@implementation XZTabBarView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)initTabBarView:(NSArray *)tabBarIconArr tabBarTitArr:(NSArray *)tabBarTitArr{
    self.frame = CGRectMake(0, 0, screenWidth, 50);
    self.backgroundColor = [UIColor blackColor];
    self.menuWidth = (float)screenWidth/tabBarIconArr.count;
    
    self.lineView = [[XZLineView alloc] initWithFrame:CGRectMake(0, 45, self.menuWidth, 5)];
    self.lineView.lineColor = [UIColor whiteColor];
    self.lineView.borderWidth = 5.0;
    [self addSubview:self.lineView];
    
    for (int i = 0; i < tabBarTitArr.count; i++) {
        XZBaseButton *btn = [XZBaseButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i*self.menuWidth, 0, self.menuWidth, 45);
        btn.backgroundColor = [UIColor clearColor];
        btn.tag = i;
        [btn addTarget:self action:@selector(tabBarClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        UIImageView *btnIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 25, 20)];
        btnIcon.image = [UIImage imageNamed:[tabBarIconArr objectAtIndex:i]];
        btnIcon.center = CGPointMake(btn.center.x, btn.center.y-10);
        [btn addSubview:btnIcon];
        
        UILabel *btnLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, btn.frame.size.width, 25)];
        btnLab.text = [tabBarTitArr objectAtIndex:i];
        btnLab.font = [UIFont systemFontOfSize:20];
        btnLab.textColor = [UIColor whiteColor];
        btnLab.textAlignment = NSTextAlignmentCenter;
        [btn addSubview:btnLab];
    }
}

- (void)tabBarClick:(id)sender{
    XZBaseButton *btn = (XZBaseButton *)sender;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(tabBarClick:)]) {
        [self.delegate tabBarClick:btn.tag];
    }

    [self tabBarLineSlide:btn.tag];
}

- (void)tabBarLineSlide:(NSInteger)index{
    [UIView animateWithDuration:0.3 animations:^{
        self.lineView.frame = CGRectMake(index*self.menuWidth, 45, self.menuWidth, 5);
    } completion:^(BOOL finished) {
        DLog(@"slider over");
    }];
}

- (void)selectedTabBar:(NSInteger)index{
    [UIView animateWithDuration:0.2 animations:^{
        CGRect fram = self.lineView.frame;
        fram.origin.x = self.menuWidth*index;
    } completion:^(BOOL finished) {
        DLog("tabBar 切换成功");
    }];
}

@end
