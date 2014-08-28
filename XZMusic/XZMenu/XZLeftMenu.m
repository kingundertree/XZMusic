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

@interface XZLeftMenu ()
@property(nonatomic, strong) NSMutableArray *menuVCArr;
@property(nonatomic, strong) UIImageView *headerImgView;

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
    self.headerImgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 40, 100, 100)];
    self.headerImgView.layer.masksToBounds = YES;
    self.headerImgView.layer.cornerRadius = 50;
    self.headerImgView.layer.borderWidth = 1.0;
    self.headerImgView.layer.borderColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.3].CGColor;
    self.headerImgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.headerImgView];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.headerImgView.frame.origin.y+self.headerImgView.frame.size.height+20, menuViewWidth, screenHeight - (self.headerImgView.frame.origin.y+self.headerImgView.frame.size.height+20))];
    scrollView.contentSize = CGSizeMake(menuViewWidth, screenHeight - (self.headerImgView.frame.origin.y+self.headerImgView.frame.size.height+20)+1);
    scrollView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:scrollView];
    
    
    NSArray *btnTitArr = @[@"我的1",@"我的2",@"我的3",@"我的4",@"我的5"];
    
    for (int i = 0; i < 5; i++) {
        XZMenuButton *btn = [XZMenuButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 45*i, menuViewWidth, 45);
        [btn addTarget:self action:@selector(menuClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:[btnTitArr objectAtIndex:i] forState:UIControlStateNormal];
        [scrollView addSubview:btn];
    }
}

- (void)menuClick:(id)sender{
    
}

- (void)menuShow:(BOOL)isMenuShow{
    if (isMenuShow) {
        
    }else{
        
    }
}

@end
