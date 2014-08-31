//
//  XZBaseViewController.m
//  XZMusic
//
//  Created by xiazer on 14-8-24.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "XZBaseViewController.h"
#import "UIBarButtonItem+NavItem.h"

@interface XZBaseViewController ()

@end

@implementation XZBaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]){
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self addBackButton];
}

- (void)setTitleViewWithString:(NSString *)titleStr { 
    UILabel *lab = [UILabel getTitleView:titleStr];
    self.navigationItem.titleView = lab;
}

- (void)addBackButton{
    if (self.backType == BackTypeNone) {
        return;
    }
    UIBarButtonItem *buttonItem;
    buttonItem = [UIBarButtonItem getBarButtonItemWithImage:[UIImage imageNamed:@"anjuke_icon_back.png"] highLihtedImg:[UIImage imageNamed:@"anjuke_icon_back_press.png"] taget:self action:@selector(doBack:)];
    if (self.backType == BackTypeDismiss) {
        buttonItem = [UIBarButtonItem getBackBarButtonItemForPresent:self action:@selector(doBack:)];
    }
    
    if (SYSTEM_VERSION_LESS_THAN(@"7.0")){
        if (self.backType == BackTypeDismiss){
            [self.navigationItem setLeftBarButtonItem:buttonItem];
        } else {
            UIBarButtonItem *spacer = [UIBarButtonItem getBarSpace:5.0];
            [self.navigationItem setLeftBarButtonItems:@[spacer, buttonItem]];
            [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
        }
    } else {
        if (self.backType == BackTypeDismiss){
            UIBarButtonItem *spacer = [UIBarButtonItem getBarSpace:-10.0];
            [self.navigationItem setLeftBarButtonItems:@[spacer, buttonItem]];
            [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
        } else {
            UIBarButtonItem *spacer = [UIBarButtonItem getBarSpace:-5.0];
            [self.navigationItem setLeftBarButtonItems:@[spacer, buttonItem]];
            [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
        }
    }
}

- (void)doBack:(id)sender {
    if (self.backType == BackTypeDismiss) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else if (self.backType == BackTypePopBack) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if (self.backType == BackTypePopToRoot) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

- (void)addRightButton:(NSString *)title{
    UIBarButtonItem *buttonItem = nil;
    //主要适应按钮正选和反选文字
    buttonItem = [UIBarButtonItem getBarButtonItemWithString:title taget:self action:@selector(rightButtonAction:)];
    
    if (SYSTEM_VERSION_LESS_THAN(@"7.0")) {
        [self.navigationItem setRightBarButtonItem:buttonItem];
    } else {//fix ios7 10像素偏离
        UIBarButtonItem *spacer = [UIBarButtonItem getBarSpace:-10.0];
        [self.navigationItem setRightBarButtonItems:@[spacer, buttonItem]];
    }
}

- (void)rightButtonAction:(id)sender {
    if (self.isLoading) {
        return;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
