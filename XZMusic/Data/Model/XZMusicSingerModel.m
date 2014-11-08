//
//  XZMusicSingleModel.m
//  XZMusic
//
//  Created by xiazer on 14/11/5.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "XZMusicSingerModel.h"

@implementation XZMusicSingerModel

//表名
+(NSString *)getTableName
{
    return @"FMSongerInfor";
}
//表版本
+(int)getTableVersion
{
    return 1;
}
+(NSString *)getPrimaryKey
{
    return @"ting_uid";
}

@end
