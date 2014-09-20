//
//  XZLovingViewController.m
//  XZMusic
//
//  Created by xiazer on 14-8-31.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "XZLovingViewController.h"

@interface XZLovingViewController ()

@end

@implementation XZLovingViewController

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

    [self setTitleViewWithString:@"最爱"];

    // Do any additional setup after loading the view.
}
#pragma mark
#pragma leftButtonAction
- (void)doBack:(id)sender{
    [[XZAppDelegate sharedAppDelegate].menuMainVC mainVCLeftMenuAction];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
