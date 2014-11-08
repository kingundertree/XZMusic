//
//  XZSingerSongListViewController.m
//  XZMusic
//
//  Created by xiazer on 14/11/8.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "XZSingerSongListViewController.h"

@interface XZSingerSongListViewController ()

@end

@implementation XZSingerSongListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)setSingerInfoModel:(XZMusicSingerModel *)singerInfoModel{
    [self setTitleViewWithString:singerInfoModel.name];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
