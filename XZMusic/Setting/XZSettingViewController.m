//
//  XZSettingViewController.m
//  XZMusic
//
//  Created by xiazer on 14-8-31.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "XZSettingViewController.h"

@interface XZSettingViewController ()

@end

@implementation XZSettingViewController

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

    [self setTitleViewWithString:@"设置"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark
#pragma leftButtonAction
- (void)doBack:(id)sender{
    [[XZAppDelegate sharedAppDelegate].menuMainVC mainVCLeftMenuAction];
}

@end
