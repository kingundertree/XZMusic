//
//  XZMainViewController.m
//  XZMusic
//
//  Created by xiazer on 14-8-24.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "XZMenuMainViewController.h"
#import "XZLeftMenu.h"
#import "XZTabBarViewController.h"
#import "pop.h"

@interface XZMenuMainViewController ()
@property(nonatomic, strong) XZLeftMenu *leftMenu;
@property(nonatomic, strong) XZBaseViewController *mainVC;
@property(nonatomic, assign) BOOL isAnimating;
@property(nonatomic, strong) UIView *coverView;
@property(nonatomic, assign) float startX;
@end

@implementation XZMenuMainViewController
@synthesize startX;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self initUI];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initUI{
    self.leftMenu = [[XZLeftMenu alloc] init];
    self.mainVC = [[XZTabBarViewController alloc] init];
    
    [self.view addSubview:self.leftMenu];
    [self.view addSubview:self.mainVC.view];
    
    //绑定手势
    UIPanGestureRecognizer *panGus = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGes:)];
    panGus.delegate = self;
    panGus.delaysTouchesBegan = YES;
    panGus.cancelsTouchesInView = NO;
    [self.mainVC.view addGestureRecognizer:panGus];

//    [self.mainVC addObserver:self forKeyPath:@"view.frame" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
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
        [self.mainVC.view addSubview:self.coverView];
        
        startX = panPoint.x;
        mainViewX = self.mainVC.view.frame.origin.x;
        
        if ([self statusCheck]) {
        }
    }else if (panGes.state == UIGestureRecognizerStateChanged){
        CGRect frame = self.mainVC.view.frame;
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
        self.mainVC.view.frame = frame;
    }else if (panGes.state == UIGestureRecognizerStateCancelled || panGes.state == UIGestureRecognizerStateEnded || panGes.state == UIGestureRecognizerStateFailed || panGes.state == UIGestureRecognizerStatePossible){
            float mainVCX = self.mainVC.view.frame.origin.x;
            self.isAnimating = YES;
        
            if (mainVCX >= 0 && mainVCX <= 70) {
                [self showMainVC];
            }else if (mainVCX >= 70 && mainVCX <= menuViewWidth + 20){
                [self showMenu];
            }
    }
}

#pragma mark
#pragma UITapGestureRecognizer
- (void)tapGus:(UITapGestureRecognizer *)tapGes{
    [self showMainVC];
}

#pragma mark
#pragma observe
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    float mainVCX;
    if([keyPath isEqualToString:@"view.frame"]){
        mainVCX = self.mainVC.view.frame.origin.x;
        DLog(@"mainVCXwithcover--->>%f",mainVCX);
        
        if (mainVCX >= 0 && mainVCX <= menuViewWidth) {
            self.coverView.alpha = mainVCX/menuViewWidth;
        }
    }
}

#pragma mark
#pragma method
- (BOOL)statusCheck{
    if (self.mainVC.view.frame.origin.x == 0) {
        self.status = MainViewOnMain;
    }else if (self.mainVC.view.frame.origin.x == menuViewWidth){
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
    
    [self.mainVC.view.layer pop_addAnimation:springAnimation forKey:@"changeposition1"];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.isAnimating = NO;
        [self.leftMenu menuShow:YES];
    });
}
#pragma mark
#pragma showMainVC
- (void)showMainVC{
    POPSpringAnimation *springAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPosition];
    springAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(screenWidth/2, screenHeight/2)];
    
    //弹性值
    springAnimation.springBounciness = 5.0;
    //弹性速度
    springAnimation.springSpeed = 5.0;
    
    [self.mainVC.view.layer pop_addAnimation:springAnimation forKey:@"changeposition2"];

    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.isAnimating = NO;
        [self hideCoverView];
        
        [self.leftMenu menuShow:NO];
    });
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
    self.coverView.frame = self.mainVC.view.frame;
    [self.view insertSubview:self.coverView aboveSubview:self.mainVC.view];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
