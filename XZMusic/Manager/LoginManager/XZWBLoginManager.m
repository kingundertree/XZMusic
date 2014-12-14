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
#import "XZWBLoginInfo.h"

#define SINAAPPID @"3573053395"
#define SINAAPPSECRET @"2b6a15ba909ceccc07cb200599f9a4c5"
#define SINAAPPRedirectURI @"http://www.xiazer.com/"


@interface XZWBLoginManager ()<WBLoginWithControllerDelegate,WeiboSDKDelegate>
@property (nonatomic, strong) WBLoginBack block;
@property (nonatomic, strong) XZWBLoginInfo *wbLoginInfo;
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
    
    if ([WeiboSDK isWeiboAppInstalled]) {
        WBAuthorizeRequest *req = [WBAuthorizeRequest request];
        req.redirectURI = @"http://www.xiazer.com/";

        req.scope = @"all";
        [WeiboSDK sendRequest:req];
    }else{
        WBAuthorizeRequest *request = [WBAuthorizeRequest request];
        request.redirectURI = SINAAPPRedirectURI;
        request.scope = @"all";
        [WeiboSDK sendRequest:request];        
    }
}

- (BOOL)WbHandUrl:(NSURL *)url{
    return [WeiboSDK handleOpenURL:url delegate:self];
}

- (void)WBLoginWithControllerDidFinishRequestWIthCoode:(NSString *)code{
    
}

- (void)didReceiveWeiboRequest:(WBBaseRequest *)request
{
    if ([request isKindOfClass:WBProvideMessageForWeiboRequest.class]){
    }
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    if ([response isKindOfClass:WBSendMessageToWeiboResponse.class]){
        NSString *title = @"发送结果";
        NSString *message = [NSString stringWithFormat:@"响应状态: %d\n响应UserInfo数据: %@\n原请求UserInfo数据: %@",(int)response.statusCode, response.userInfo, response.requestUserInfo];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
    }else if ([response isKindOfClass:WBAuthorizeResponse.class]){
        if (response.statusCode == WeiboSDKResponseStatusCodeUserCancel) {
            self.block(WBLoginResultCancel,nil);
        }else if (response.statusCode == WeiboSDKResponseStatusCodeSuccess){
            self.wbLoginInfo = [[XZWBLoginInfo alloc] init];
            self.wbLoginInfo.userId = [(WBAuthorizeResponse *)response userID];
            self.wbLoginInfo.accessToken = [(WBAuthorizeResponse *)response accessToken];
            
            self.block(WBLoginResultSuccess,self.wbLoginInfo);
        }else{
            DLog(@"登录异常");
            self.block(WBLoginResultFail,nil);
        }
    }
}

@end
