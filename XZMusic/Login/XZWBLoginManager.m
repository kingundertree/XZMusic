//
//  XZWBLoginManager.m
//  XZMusic
//
//  Created by xiazer on 14-9-16.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "XZWBLoginManager.h"
#import "WeiboSDK.h"
#import "XZLoginForWBViewController.h"

#define SINAAPPID @"3573053395"


@interface XZWBLoginManager ()
@property (nonatomic, strong) WBLoginBack block;
@end

@implementation XZWBLoginManager

+ (id)sharedInstance{
    static dispatch_once_t pred;
    static XZWBLoginManager *sharedInstance = nil;
    dispatch_once(&pred, ^{
        sharedInstance = [[XZWBLoginManager alloc] init];
    });
    return sharedInstance;
}

- (void)WBLoginWithFinishBlock:(WBLoginBack)block{

    self.block = block;
    
    if ([WeiboSDK isWeiboAppInstalled]) {
        WBAuthorizeRequest *req = [WBAuthorizeRequest request];
        req.redirectURI = @"http://www.xiazer.com";
        req.scope = @"all";
        [WeiboSDK sendRequest:req];
    }else{
        XZLoginForWBViewController *WBloginVC = [[XZLoginForWBViewController alloc] initWithAppID:SINAAPPID redirectURI:@"http://www.xiazer.com" delegate:self];
        self.block(WBLoginResultForNone,WBloginVC);
    }
}

@end
