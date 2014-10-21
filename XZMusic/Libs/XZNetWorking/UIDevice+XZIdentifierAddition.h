//
//  UIDevice+XZIdentifierAddition.h
//  XZMusic
//
//  Created by xiazer on 14/10/21.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (XZIdentifierAddition)

- (NSString *)XZNet_uuid;
- (NSString *)XZNet_udid;
- (NSString *)XZNet_macaddress;
- (NSString *)XZNet_macaddressMD5;
- (NSString *)XZNet_machineType;
- (NSString *)XZNet_ostype;//显示“ios6，ios5”，只显示大版本号
- (NSString *)XZNet_createUUID;


@end
