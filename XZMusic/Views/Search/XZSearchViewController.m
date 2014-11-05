//
//  XZSearchViewController.m
//  XZMusic
//
//  Created by xiazer on 14-8-31.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "XZSearchViewController.h"
#import "XZMusicSingerModel.h"

@interface XZSearchViewController ()

@end

@implementation XZSearchViewController

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

    [self setTitleViewWithString:@"搜索"];
    // Do any additional setup after loading the view.
    
    [self getSingerData];
}
#pragma mark
#pragma leftButtonAction
- (void)doBack:(id)sender{
    [[XZAppDelegate sharedAppDelegate].menuMainVC mainVCLeftMenuAction];
}

-(void)getSingerData
{
    XZMusicSingerModel *model = [XZMusicSingerModel new];
    NSArray *array = [NSArray arrayWithArray:[model itemTop100]];
    DLog(@"歌手列表--->>%lu/%@",(unsigned long)array.count,array)
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
