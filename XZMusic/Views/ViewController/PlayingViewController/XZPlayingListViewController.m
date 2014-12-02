//
//  XZPlayingListViewController.m
//  XZMusic
//
//  Created by xiazer on 14/12/2.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "XZPlayingListViewController.h"

@interface XZPlayingListViewController ()

@end

@implementation XZPlayingListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitleViewWithString:@"Playing list"];
    // Do any additional setup after loading the view.
}

- (void)doBack:(id)sender{
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
