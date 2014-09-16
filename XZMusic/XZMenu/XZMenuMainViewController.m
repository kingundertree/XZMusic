//
//  XZMainViewController.m
//  XZMusic
//
//  Created by xiazer on 14-8-24.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "XZMenuMainViewController.h"
#import "XZLeftMenu.h"
#import "pop.h"
#import "XZBaseNaviViewController.h"
#import "PushBackNavigationController.h"
#import "XZMusicPlayViewController.h"
#import "XZWBLoginManager.h"

@interface XZMenuMainViewController ()
@property(nonatomic, strong) XZLeftMenu *leftMenu;
@property(nonatomic, strong) XZBaseNaviViewController *mainNav;
@property(nonatomic, assign) BOOL isAnimating;
@property(nonatomic, strong) UIView *coverView;
@property(nonatomic, assign) float startX;
@property(nonatomic, strong) XZTabBarViewController *tabBarVC;
@end

@implementation XZMenuMainViewController
@synthesize startX;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.backType = BackTypeNone;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    self.isOnFirstView = YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initUI];
    // Do any additional setup after loading the view.
}

- (void)initUI{
    self.leftMenu = [[XZLeftMenu alloc] init];
    self.tabBarVC = [[XZTabBarViewController alloc] init];
    self.tabBarVC.tabBarDelegate = self;
    self.mainNav = [[PushBackNavigationController alloc] initWithRootViewController:self.tabBarVC];
    
    [self.view addSubview:self.leftMenu];
    [self.view addSubview:self.mainNav.view];
    
    //绑定手势
    UIPanGestureRecognizer *panGus = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGes:)];
    panGus.delegate = self;
    panGus.delaysTouchesBegan = YES;
    panGus.cancelsTouchesInView = NO;
    [self.mainNav.view addGestureRecognizer:panGus];

//    [self.mainNav addObserver:self forKeyPath:@"view.frame" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
}

#pragma mark
#pragma tabBarRightButtonAction
- (void)tabBarRightButtonAction{
    self.isOnFirstView = NO;
    XZMusicPlayViewController *musicPlayVC = [[XZMusicPlayViewController alloc] init];
    musicPlayVC.backType = BackTypePopBack;
    [self.mainNav pushViewController:musicPlayVC animated:YES];
}

#pragma -mark UIGurstureDelegate
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if (self.isAnimating ||
        !self.isOnFirstView) {
        return NO;
    }
    return YES;
}

#pragma mark
#pragma UIGestureRecognizerDelegate
- (void)panGes:(UIPanGestureRecognizer *)panGes{
    if (self.isAnimating) {
        return;
    }
    
    UIWindow *screenWindow = [UIApplication sharedApplication].keyWindow;
    CGPoint panPoint = [panGes locationInView:screenWindow];
    
    float mainViewX;
    
    if (panGes.state == UIGestureRecognizerStateBegan) {//
        [self.mainNav.view addSubview:self.coverView];
        
        startX = panPoint.x;
        mainViewX = self.mainNav.view.frame.origin.x;
        
        if ([self statusCheck]) {
        }
    }else if (panGes.state == UIGestureRecognizerStateChanged){
        CGRect frame = self.mainNav.view.frame;
        if (self.status == MainViewOnMain){
            if (panPoint.x - startX <= 0){
                frame.origin.x = 0;
            }else if (panPoint.x - startX <= menuViewWidth + 20) {
                frame.origin.x = panPoint.x - startX;
            }else if (panPoint.x - startX >= menuViewWidth + 20){
                frame.origin.x = menuViewWidth + 20;
            }
        }else if (self.status == MainViewOnRightStatic){
            if (panPoint.x - startX <= 20 && panPoint.x - startX >= -menuViewWidth) {
                frame.origin.x = menuViewWidth + panPoint.x - startX;
            }else if (panPoint.x - startX >= 20){
                frame.origin.x = menuViewWidth + 20;
            }else if (panPoint.x - startX <= -menuViewWidth){
                frame.origin.x = 0;
            }
        }
        self.mainNav.view.frame = frame;
    }else if (panGes.state == UIGestureRecognizerStateCancelled || panGes.state == UIGestureRecognizerStateEnded || panGes.state == UIGestureRecognizerStateFailed || panGes.state == UIGestureRecognizerStatePossible){
            float mainNavX = self.mainNav.view.frame.origin.x;
            self.isAnimating = YES;
        
            if (mainNavX >= 0 && mainNavX <= 70) {
                [self showmainNav];
            }else if (mainNavX >= 70 && mainNavX <= menuViewWidth + 20){
                [self showMenu];
            }
    }
}

#pragma mark
#pragma UITapGestureRecognizer
- (void)tapGus:(UITapGestureRecognizer *)tapGes{
    [self showmainNav];
}

#pragma mark
#pragma observe
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    float mainNavX;
    if([keyPath isEqualToString:@"view.frame"]){
        mainNavX = self.mainNav.view.frame.origin.x;
        DLog(@"mainNavXwithcover--->>%f",mainNavX);
        
        if (mainNavX >= 0 && mainNavX <= menuViewWidth) {
            self.coverView.alpha = mainNavX/menuViewWidth;
        }
    }
}

#pragma mark
#pragma method
- (BOOL)statusCheck{
    if (self.mainNav.view.frame.origin.x == 0) {
        self.status = MainViewOnMain;
    }else if (self.mainNav.view.frame.origin.x == menuViewWidth){
        self.status = MainViewOnRightStatic;
    }else{
        self.status = MainViewOnEles;
    }
    
    return YES;
}

#pragma mark
#pragma showMenu
- (void)showMenu{
    POPSpringAnimation *springAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPosition];
    springAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(menuViewWidth+screenWidth/2, screenHeight/2)];
    
    //弹性值
    springAnimation.springBounciness = 20.0;
    //弹性速度
    springAnimation.springSpeed = 20.0;
    
    [self.mainNav.view.layer pop_addAnimation:springAnimation forKey:@"changeposition1"];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.isAnimating = NO;
        [self.leftMenu menuShow:YES];
    });
}
#pragma mark
#pragma showmainNav
- (void)showmainNav{
    POPSpringAnimation *springAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPosition];
    springAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(screenWidth/2, screenHeight/2)];
    
    //弹性值
    springAnimation.springBounciness = 5.0;
    //弹性速度
    springAnimation.springSpeed = 5.0;
    
    [self.mainNav.view.layer pop_addAnimation:springAnimation forKey:@"changeposition2"];

    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.isAnimating = NO;
        [self hideCoverView];
        
        [self.leftMenu menuShow:NO];
    });
}
#pragma mark
#pragma replaceMainVC
- (void)replaceMainVC:(XZBaseViewController *)replaceVC{
    CGRect frame = self.mainNav.view.frame;
    [self.mainNav.view removeFromSuperview];
    
    self.mainNav = nil;
    self.mainNav = [[PushBackNavigationController alloc] initWithRootViewController:replaceVC];
    self.mainNav.view.frame = frame;
    [self.view addSubview:self.mainNav.view];

    //绑定手势
    UIPanGestureRecognizer *panGus = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGes:)];
    panGus.delegate = self;
    panGus.delaysTouchesBegan = YES;
    panGus.cancelsTouchesInView = NO;
    [self.mainNav.view addGestureRecognizer:panGus];
}

#pragma mark
#pragma hideCoverView or addCoverView
- (void)hideCoverView{
    if (self.coverView == nil) {
        return;
    }
    [self.coverView removeFromSuperview];
}
- (void)addCoverView{
    self.coverView.frame = self.mainNav.view.frame;
    [self.view insertSubview:self.coverView aboveSubview:self.mainNav.view];
}

#pragma mark
#pragma coverView
- (UIView *)coverView{
    if (_coverView == nil) {
        _coverView = [[UIView alloc] initWithFrame:self.view.bounds];
        _coverView.backgroundColor = [UIColor clearColor];
        
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGus:)];
        tapGes.delegate                = self;
        tapGes.numberOfTouchesRequired = 1;
        tapGes.numberOfTapsRequired    = 1;
        [_coverView addGestureRecognizer:tapGes];
        
        //绑定手势
        UIPanGestureRecognizer *panGus = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGes:)];
        panGus.delegate = self;
        panGus.delaysTouchesBegan = YES;
        panGus.cancelsTouchesInView = NO;
        [_coverView addGestureRecognizer:panGus];
    }
    return _coverView;
}

- (void)WBLogin{
    [[XZWBLoginManager sharedInstance] WBLoginWithFinishBlock:^(WBLoginResult result, id callBackValue) {
        if ([callBackValue isKindOfClass:[XZBaseViewController class]]) {
            XZBaseViewController *vc = (XZBaseViewController *)callBackValue;
            vc.backType = BackTypeDismiss;
            
            XZBaseNaviViewController *nav = [[XZBaseNaviViewController alloc] initWithRootViewController:vc];
            [self.mainNav presentViewController:nav animated:YES completion:^{
            }];
        }else{
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
