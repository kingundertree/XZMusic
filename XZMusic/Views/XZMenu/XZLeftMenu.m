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
#import "XZBaseButton+IconWithTitle.h"
#import "XZAppDelegate.h"
#import "XZTabBarViewController.h"
#import "XZSettingViewController.h"
#import "XZDownLoadViewController.h"
#import "XZLovingViewController.h"
#import "XZSearchViewController.h"

@interface XZLeftMenu ()
@property(nonatomic, strong) XZHeaderButton *headerImgButton;
@property(nonatomic, assign) NSInteger menuIndex;
@property(nonatomic, strong) UIScrollView *scrollView;
@end

@implementation XZLeftMenu

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor lightGrayColor];
        self.frame = CGRectMake(0, 0, menuViewWidth+100, ScreenHeight);
        self.menuVCArr = [NSMutableArray arrayWithObjects:@"",@"",@"",@"",@"", nil];
        self.menuIndex = 0;
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
    [self.headerImgButton addTarget:self action:@selector(doLogin:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.headerImgButton];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.headerImgButton.frame.origin.y+self.headerImgButton.frame.size.height+20, menuViewWidth, ScreenHeight - (self.headerImgButton.frame.origin.y+self.headerImgButton.frame.size.height+20))];
    self.scrollView.contentSize = CGSizeMake(menuViewWidth, ScreenHeight - (self.headerImgButton.frame.origin.y+self.headerImgButton.frame.size.height+20)+1);
    self.scrollView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:self.scrollView];
    
    NSArray *btnTitArr = @[@"XZ Music",@"最爱",@"下载中心",@"搜索",@"设置"];
    NSArray *btnIconArr = @[@"music@2x.png",@"love@2x.png",@"download@2x.png",@"search@2x.png",@"settings@2x.png"];

    for (int i = 0; i < 5; i++) {
        XZMenuButton *btn = [XZMenuButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i+1000;
        btn.frame = CGRectMake(0, ScreenHeight, menuViewWidth, 45);
        [btn addTarget:self action:@selector(menuClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn showTitlt:[btnTitArr objectAtIndex:i] textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:16] icon:[btnIconArr objectAtIndex:i]];
        [btn setBackgroundImage:[UIImage createImageWithColor:[UIColor clearColor]] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage createImageWithColor:[UIColor blueColor]] forState:UIControlStateHighlighted];
        [self.scrollView addSubview:btn];
    }
    
    [self initLoginInfo];
}

- (void)initLoginInfo
{
    XZUserInfo *loginUserInfo = [[XZMusicCoreDataCenter shareInstance] fetchLoginUserInfo];
    if (loginUserInfo) {
        [XZGlobalManager shareInstance].userWeiboId = loginUserInfo.userWeiboID;
        [self.headerImgButton setimageWithUrl:loginUserInfo.userWeiboHeaderImg];
        [self.headerImgButton setTitle:@"" forState:UIControlStateNormal];
    }
}

#pragma mark
#pragma 菜单点击事件
- (void)menuClick:(id)sender{
    XZMenuButton *btn = (XZMenuButton *)sender;
    NSInteger tagIndex = btn.tag - 1000;
    [[XZAppDelegate sharedAppDelegate].menuMainVC showmainNav];

    if (self.menuIndex == tagIndex) {
        return;
    }else{
        if (![[self.menuVCArr objectAtIndex:tagIndex] isKindOfClass:[XZBaseViewController class]]) {
            if (tagIndex == 0) {
                XZTabBarViewController *vc = [[XZTabBarViewController alloc] init];
                vc.backType = BackTypeForMenu;
                [self.menuVCArr replaceObjectAtIndex:0 withObject:vc];
            }else if (tagIndex == 1){
                XZLovingViewController *vc = [[XZLovingViewController alloc] init];
                vc.backType = BackTypeForMenu;
                [self.menuVCArr replaceObjectAtIndex:1 withObject:vc];
            }else if (tagIndex == 2){
                XZDownLoadViewController *vc = [[XZDownLoadViewController alloc] init];
                vc.backType = BackTypeForMenu;
                [self.menuVCArr replaceObjectAtIndex:2 withObject:vc];
            }else if (tagIndex == 3){
                XZSearchViewController *vc = [[XZSearchViewController alloc] init];
                vc.backType = BackTypeForMenu;
                [self.menuVCArr replaceObjectAtIndex:3 withObject:vc];
            }else if (tagIndex == 4){
                XZSettingViewController *vc = [[XZSettingViewController alloc] init];
                vc.backType = BackTypeForMenu;
                [self.menuVCArr replaceObjectAtIndex:4 withObject:vc];
            }
        }
        
        XZBaseViewController *baseVC = (XZBaseViewController *)[self.menuVCArr objectAtIndex:tagIndex];
        [[XZAppDelegate sharedAppDelegate].menuMainVC replaceMainVC:baseVC];
        [[XZAppDelegate sharedAppDelegate].menuMainVC showmainNav];
        
        self.menuIndex = btn.tag;
    }
}

#pragma mark
#pragma 显示左侧菜单
- (void)menuShow:(BOOL)isMenuShow{
    if (isMenuShow) {
        float deleyTime = 0.0;
        for (int i = 0; i < 5; i++) {
            XZMenuButton *btn = (XZMenuButton *)[self.scrollView viewWithTag:i+1000];
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
            btn.frame = CGRectMake(0, ScreenHeight, menuViewWidth, 45);
        }
    }
}

#pragma mark
#pragma 登录按钮点击
- (void)doLogin:(id)sender{
    if (self.headerImgButton.headerImageView) {
        [[XZAppDelegate sharedAppDelegate].menuMainVC WBQuite];
        [self.headerImgButton WBLooginQuite];
        
        [(XZBaseViewController *)[XZAppDelegate sharedAppDelegate].menuMainVC showTips:@"退出登录成功"];
    
        NSString *userId = [XZGlobalManager shareInstance].userWeiboId;
        [[XZMusicCoreDataCenter shareInstance] updateUserLoginInfo:userId isLogin:NO];
    }else{
        [[XZAppDelegate sharedAppDelegate].menuMainVC WBLogin];    
    }
}

#pragma mark
#pragma 更新用户头像信息
- (void)updateUserLoginInfo:(NSDictionary *)userInfoDic{
    [self.headerImgButton setTitle:@"" forState:UIControlStateNormal];
    [self.headerImgButton setimageWithUrl:userInfoDic[@"avatar_hd"]];

    [self saveUserInfo:userInfoDic];
    [(XZBaseViewController *)[XZAppDelegate sharedAppDelegate].menuMainVC showTips:@"微博登录成功"];
}

- (void)saveUserInfo:(NSDictionary *)userInfo
{
    NSString *idStr = [userInfo[@"profile_image_url"] substringWithRange:NSMakeRange(22, 10)];
    [XZGlobalManager shareInstance].userWeiboId = idStr;

    if ([[XZMusicCoreDataCenter shareInstance] isUserExit:idStr]) {
        [[XZMusicCoreDataCenter shareInstance] updateUserLoginInfo:idStr isLogin:YES];
    } else
    {        
        [[XZMusicCoreDataCenter shareInstance] saveNewUserInfo:userInfo];
    }
}

@end
