//
//  XZLoginForWBViewController.h
//  XZMusic
//
//  Created by xiazer on 14-9-16.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "XZBaseViewController.h"

@protocol WBLoginWithControllerDelegate <NSObject>
- (void)WBLoginWithControllerDidFinishRequestWIthCoode:(NSString *)code;
@end

@interface XZLoginForWBViewController : XZBaseViewController

- (id)initWithAppID:(NSString *)appID redirectURI:(NSString *)uri delegate:(id<WBLoginWithControllerDelegate>) delegate;

@end
