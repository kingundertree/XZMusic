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
#define SINAAPPSECRET @"2b6a15ba909ceccc07cb200599f9a4c5"
#define SINAAPPRedirectURI @"http://www.xiazer.com/"


@interface XZWBLoginManager ()<WBLoginWithControllerDelegate,WeiboSDKDelegate>
@property (nonatomic, strong) WBLoginBack block;
@property (nonatomic, strong) NSString *WBToken;

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
    [WeiboSDK registerApp:SINAAPPID];
    
    self.block = block;

//    XZBaseViewController *vc = (XZBaseViewController *)[XZAppDelegate sharedAppDelegate].menuMainVC;
//    SinaWeibo WB = [[SinaWeibo alloc] initWithAppKey:SINAAPPID appSecret:SINAAPPSECRET appRedirectURI:SINAAPPRedirectURI andDelegate:vc];

    
    if ([WeiboSDK isWeiboAppInstalled]) {
        WBAuthorizeRequest *req = [WBAuthorizeRequest request];
        req.redirectURI = @"http://www.xiazer.com/";

        req.scope = @"all";
        [WeiboSDK sendRequest:req];
    }else{
        XZLoginForWBViewController *WBloginVC = [[XZLoginForWBViewController alloc] initWithAppID:SINAAPPID redirectURI:@"http://www.xiazer.com/" delegate:self];
        self.block(WBLoginResultForNone,WBloginVC);
    }
}

- (BOOL)WbHandUrl:(NSURL *)url{
    return [WeiboSDK handleOpenURL:url delegate:self];
}

- (void)WBLoginWithControllerDidFinishRequestWIthCoode:(NSString *)code{
    
}

- (void)didReceiveWeiboRequest:(WBBaseRequest *)request
{
    if ([request isKindOfClass:WBProvideMessageForWeiboRequest.class])
    {
//        ProvideMessageForWeiboViewController *controller = [[ProvideMessageForWeiboViewController alloc] init];
//        [self.viewController presentModalViewController:controller animated:YES];
    }
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    if ([response isKindOfClass:WBSendMessageToWeiboResponse.class])
    {
        NSString *title = @"发送结果";
        NSString *message = [NSString stringWithFormat:@"响应状态: %d\n响应UserInfo数据: %@\n原请求UserInfo数据: %@",(int)response.statusCode, response.userInfo, response.requestUserInfo];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
    }
    else if ([response isKindOfClass:WBAuthorizeResponse.class])
    {
        NSString *title = @"认证结果";
        NSString *message = [NSString stringWithFormat:@"响应状态: %d\nresponse.userId: %@\nresponse.accessToken: %@\n响应UserInfo数据: %@\n原请求UserInfo数据: %@",(int)response.statusCode,[(WBAuthorizeResponse *)response userID], [(WBAuthorizeResponse *)response accessToken], response.userInfo, response.requestUserInfo];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        
        self.WBToken = [(WBAuthorizeResponse *)response accessToken];
        
        [alert show];
    }
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [WeiboSDK handleOpenURL:url delegate:nil];
}

@end
