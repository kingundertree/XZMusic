//
//  XZBaseViewController+TipsView.m
//  XZMusic
//
//  Created by xiazer on 14-9-25.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "XZBaseViewController+TipsView.h"
#import "MBProgressHUD.h"

@implementation XZBaseViewController (TipsView)

- (void)showLoading{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"加载中...";
}

- (void)hideLoading{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

- (void)showTips:(NSString *)tips{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = tips;
    hud.hidden = NO;
    hud.yOffset = -40;
    
    [hud hide:YES afterDelay:1.5];
}

- (void)hideHudTips{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}


@end
