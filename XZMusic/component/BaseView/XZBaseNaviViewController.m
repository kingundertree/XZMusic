//
//  XZBaseNaviViewController.m
//  XZMusic
//
//  Created by xiazer on 14-8-29.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "XZBaseNaviViewController.h"

@interface XZBaseNaviViewController ()

@end

@implementation XZBaseNaviViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.navigationBar.translucent = NO;

        [[UINavigationBar appearance] setBackgroundImage:[UIImage createImageWithColor:[UIColor colorWithHex:0x252D3B alpha:1.0]] forBarMetrics:UIBarMetricsDefault];
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleBlackOpaque;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
