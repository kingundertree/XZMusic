//
//  XZTabBarViewController.m
//  XZMusic
//
//  Created by xiazer on 14-8-24.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "XZTabBarViewController.h"
#import "XZTabBarForHomeViewController.h"
#import "XZTabBarForMeViewController.h"
#import "XZTabBarView.h"

@interface XZTabBarViewController ()<tabBarDelegate>
@property(nonatomic, strong) NSMutableArray *tabVcArr;
@property(nonatomic, strong) XZTabBarView *tabBarView;
@end

@implementation XZTabBarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = [UIColor blackColor];
        [self initData];
        [self initTabBar];
    }
    return self;
}

- (void)viewDidLoad
{
    self.backType = BackTypeNone;
    [super viewDidLoad];
    [self setTitleViewWithString:@"XZ Music"];
    // Do any additional setup after loading the view.
}

- (void)initData{
    self.tabVcArr = [NSMutableArray array];
    self.tabBarIndex = 0;
}

#pragma mark 
#pragma initTabBar
- (void)initTabBar{
    XZTabBarForHomeViewController *homeVC = [[XZTabBarForHomeViewController alloc] init];
    homeVC.backType = BackTypeNone;
    homeVC.view.frame = CGRectMake(0, 0, screenWidth, screenHeight-50);
//    UINavigationController *navHome = [[UINavigationController alloc] initWithRootViewController:homeVC];
    
    XZTabBarForMeViewController *meVC = [[XZTabBarForMeViewController alloc] init];
    meVC.backType = BackTypeNone;
    meVC.view.frame = CGRectMake(0, 0, screenWidth, screenHeight-50);
//    UINavigationController *navMeVC = [[UINavigationController alloc] initWithRootViewController:meVC];
    
    [self.tabVcArr addObject:homeVC];
    [self.tabVcArr addObject:meVC];
    
    [self.view addSubview:homeVC.view];
    
    [self addRightButton:@"+"];
    
    self.tabBarView = [[XZTabBarView alloc] init];
    [self.tabBarView initTabBarView:@[@"",@""] tabBarTitArr:@[@"XZ",@"ME"]];
    self.tabBarView.delegate = self;
    self.tabBarView.frame = CGRectMake(0, screenHeight-50-64, screenWidth, 50);
    [self.view addSubview:self.tabBarView];
}

#pragma mark
#pragma rightButtonAction
- (void)rightButtonAction:(id)sender{
    if (self.tabBarDelegate && [self.tabBarDelegate respondsToSelector:@selector(tabBarRightButtonAction)]) {
        [self.tabBarDelegate tabBarRightButtonAction];
    }
}

#pragma mark
#pragma tabBarDelegate
- (void)tabBarClick:(NSInteger)index{
    if (self.tabBarIndex == index) {
        return;
    }else{
        XZBaseViewController *vc = (XZBaseViewController *)[self.tabVcArr objectAtIndex:self.tabBarIndex];
        [vc.view removeFromSuperview];
        
        XZBaseViewController *newVc = (XZBaseViewController *)[self.tabVcArr objectAtIndex:index];
        
        [self.view insertSubview:newVc.view belowSubview:self.tabBarView];
        
        self.tabBarIndex = index;
        
        if (self.tabBarIndex == 0) {
            [self setTitleViewWithString:@"XZ Music"];
        }else{
            [self setTitleViewWithString:@"ME"];
        }
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
