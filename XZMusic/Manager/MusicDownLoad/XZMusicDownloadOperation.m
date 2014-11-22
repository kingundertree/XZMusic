//
//  XZMusicDownOperation.m
//  XZMusic
//
//  Created by xiazer on 14/11/19.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "XZMusicDownOperation.h"

@interface XZMusicDownloadOperation ()
@property (nonatomic, strong) NSMutableArray *identifyArr;
@property (nonatomic, strong) NSMutableArray *operationBlockArr;
@property (nonatomic, strong) NSOperationQueue *downLoadQueue;
@property (nonatomic, strong) NSMutableDictionary *opeationDic;
@end

@implementation XZMusicDownloadOperation

+ (XZMusicDownloadOperation *)shareInstance {
    static XZMusicDownloadOperation *shareInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        shareInstance = [[self alloc] init];
        
    });
    
    return shareInstance;
}

- (id)init{
    self = [super init];
    if (self) {
        [self initData];
    }
    return self;
}

- (void)initData {
    self.identifyArr = [NSMutableArray array];
    self.operationBlockArr = [NSMutableArray array];
    self.downLoadQueue = [[NSOperationQueue alloc] init];
    self.opeationDic = [[NSMutableDictionary alloc] init];
}

- (void)downloadMusicWithMusicId:(NSString *)musicId identify:(NSString *)identify downloadType:(enum XZMusicDownloadtype)downloadType downloadBlock:(void(^)(XZMusicDownloadResponse *response))downloadBlock{
    
}

@end
