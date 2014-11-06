//
//  XZMusicSingleModel.m
//  XZMusic
//
//  Created by xiazer on 14/11/5.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "XZMusicSingerModel.h"
#import "NSObject+LKDBHelper.h"

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
- (NSMutableArray *)itemWith:(NSString *)name
{
    NSMutableArray * array = [XZMusicSingerModel searchWithWhere:[NSString stringWithFormat:@"name like '%%%@%%'",name] orderBy:nil offset:0 count:0];
    NSMutableArray * temp = [NSMutableArray new];
    NSMutableArray * temp1 = [NSMutableArray new];
    for (XZMusicSingerModel * sub in array) {
        if ([sub.name length]!=0) {
            if ([sub.company length]!=0) {
                [temp addObject:sub];
            }else{
                [temp1 addObject:sub];
            }
        }
    }
    [temp addObjectsFromArray:temp1];
    return temp;
}
- (NSMutableArray *)itemTop100
{
    return [self itemWith:@"周"];
}

@end
