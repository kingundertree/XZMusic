//
//  XZLeftMenu.m
//  XZMusic
//
//  Created by xiazer on 14-8-24.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "XZLeftMenu.h"
#import <QuartzCore/QuartzCore.h>
#import "XZMenuButton.h"
#import "XZHeaderButton.h"
#import "XZBaseButton+CornerRadius.h"

@interface XZLeftMenu ()
@property(nonatomic, strong) NSMutableArray *menuVCArr;
@property(nonatomic, strong) XZHeaderButton *headerImgButton;

@end

@implementation XZLeftMenu

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor lightGrayColor];
        self.frame = CGRectMake(0, 0, menuViewWidth+100, screenHeight);
    }
    return self;
}

#pragma mark
#pragma method

- (void)initData{
    self.menuVCArr = [NSMutableArray array];
}

- (void)layoutSubviews{
    self.headerImgButton = [XZHeaderButton buttonWithType:UIButtonTypeCustom];
    self.headerImgButton.frame = CGRectMake(20, 40, 100, 100);
    self.headerImgButton.backgroundColor = [UIColor whiteColor];
    [self.headerImgButton setRadius:1.0 borderColor:[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.5]];
    [self.headerImgButton showTitlt:@"login" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:30]];
    [self addSubview:self.headerImgButton];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.headerImgButton.frame.origin.y+self.headerImgButton.frame.size.height+20, menuViewWidth, screenHeight - (self.headerImgButton.frame.origin.y+self.headerImgButton.frame.size.height+20))];
    scrollView.contentSize = CGSizeMake(menuViewWidth, screenHeight - (self.headerImgButton.frame.origin.y+self.headerImgButton.frame.size.height+20)+1);
    scrollView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:scrollView];
    
    NSArray *btnTitArr = @[@"我的1",@"我的2",@"我的3",@"我的4",@"我的5"];
    for (int i = 0; i < 5; i++) {
        XZMenuButton *btn = [XZMenuButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i+1000;
        btn.frame = CGRectMake(0, screenHeight, menuViewWidth, 45);
        [btn addTarget:self action:@selector(menuClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:[btnTitArr objectAtIndex:i] forState:UIControlStateNormal];
        [scrollView addSubview:btn];
    }
}

- (void)menuClick:(id)sender{
}

- (void)menuShow:(BOOL)isMenuShow{
    if (isMenuShow) {
        float deleyTime = 0.0;
        for (int i = 0; i < 5; i++) {
            XZMenuButton *btn = (XZMenuButton *)[self viewWithTag:i+1000];
            deleyTime = i*0.2;
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(deleyTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [UIView animateWithDuration:0.4 animations:^{
                    btn.frame = CGRectMake(0, 45*i, menuViewWidth, 45);
                } completion:^(BOOL finished) {
                    DLog(@"menu%d over",i);
                }];
            });
        }
    }else{
        for (int i = 0; i < 5; i++) {
            XZMenuButton *btn = (XZMenuButton *)[self viewWithTag:i+1000];
            btn.frame = CGRectMake(0, screenHeight, menuViewWidth, 45);
        }
    }
}

@end
