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
    [super viewDidLoad];
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
    homeVC.view.frame = CGRectMake(0, 0, screenWidth, screenHeight-50);
    UINavigationController *navHome = [[UINavigationController alloc] initWithRootViewController:homeVC];
    
    XZTabBarForMeViewController *meVC = [[XZTabBarForMeViewController alloc] init];
    meVC.view.frame = CGRectMake(0, 0, screenWidth, screenHeight-50);
    UINavigationController *navMeVC = [[UINavigationController alloc] initWithRootViewController:meVC];
    
    [self.tabVcArr addObject:navHome];
    [self.tabVcArr addObject:navMeVC];
    
    [self.view addSubview:navHome.view];
    
    self.tabBarView = [[XZTabBarView alloc] init];
    [self.tabBarView initTabBarView:@[@"",@""] tabBarTitArr:@[@"XZ",@"ME"]];
    self.tabBarView.delegate = self;
    self.tabBarView.frame = CGRectMake(0, screenHeight-50, screenWidth, 50);
    [self.view addSubview:self.tabBarView];
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
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
