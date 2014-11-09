//
//  XZMusicPlayViewController.m
//  XZMusic
//
//  Created by xiazer on 14-8-29.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "XZMusicPlayViewController.h"

@interface XZMusicPlayViewController ()

@end

@implementation XZMusicPlayViewController

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
    [self setTitleViewWithString:[NSString stringWithFormat:@"%@-playing",self.songModel.author]];
    
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
