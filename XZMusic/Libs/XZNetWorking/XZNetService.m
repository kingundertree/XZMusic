//
//  XZNetService.m
//  XZMusic
//
//  Created by xiazer on 14/10/19.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "XZNetService.h"

@implementation XZNetService



+ (id)shareInstance{
    static dispatch_once_t pred;
    static XZNetService *sharedInstance = nil;
    dispatch_once(&pred, ^{
        sharedInstance = [[XZNetService alloc] init];
    });
    return sharedInstance;
}


@end
