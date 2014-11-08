//
//  XZMusicDataCenter.m
//  XZMusic
//
//  Created by xiazer on 14/11/8.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "XZMusicDataCenter.h"

@implementation XZMusicDataCenter

+ (XZMusicDataCenter *)shareInstance{
    static XZMusicDataCenter *shareInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        shareInstance = [[self alloc] init];
    });
    
    return shareInstance;
}


- (NSMutableArray *)topMusic100{
    return [self searchMusicWithKeyword:@"周"];
}

- (NSMutableArray *)searchMusicWithKeyword:(NSString *)keyword{
    NSMutableArray * array = [XZMusicSingerModel searchWithWhere:[NSString stringWithFormat:@"name like '%%%@%%'",keyword] orderBy:nil offset:0 count:0];
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


@end
