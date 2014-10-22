//
//  XZRequestResponse+XZNetMethod.h
//  XZMusic
//
//  Created by xiazer on 14/10/22.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "XZRequestResponse.h"

@interface XZRequestResponse (XZNetMethod)

- (void)updateWithRTNetworkResponse:(XZRequestResponse *)response;
- (XZRequestResponse *)returnNetworkResponse;

@end
