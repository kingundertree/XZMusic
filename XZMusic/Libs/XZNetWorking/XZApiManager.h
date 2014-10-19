//
//  XZApiManager.h
//  XZMusic
//
//  Created by xiazer on 14/10/19.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XZRequestResponse.h"
#import "XZNetService.h"
#import "XZNetServiceFactory.h"

@interface XZApiManager : NSObject
+ (id)shareInstance;

- (XZRequestResponse *)callGETWithParams:(NSDictionary *)params serviceIdentifier:(NSString *)servieIdentifier methodName:(NSString *)methodName;
@end
