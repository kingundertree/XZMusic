//
//  XZMusicDownOperation.m
//  XZMusic
//
//  Created by xiazer on 14/11/19.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "XZMusicDownloadCenter.h"
#import "XZMusicDownloadDispatch.h"
#import "XZMusicDownloadOperation.h"


@interface XZMusicDownloadCenter ()
@property (nonatomic, strong) NSMutableArray *identifyArr;
@property (nonatomic, strong) NSMutableArray *operationBlockArr;
@property (nonatomic, strong) NSOperationQueue *downLoadQueue;
@property (nonatomic, strong) NSMutableDictionary *dispatchDic;
@end


@implementation XZMusicDownloadCenter

+ (XZMusicDownloadCenter *)shareInstance {
    static XZMusicDownloadCenter *shareInstance = nil;
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
    self.downLoadQueue.maxConcurrentOperationCount = 2;
    self.dispatchDic = [[NSMutableDictionary alloc] init];
}

- (void)cancleAllRequest {
    [self.downLoadQueue cancelAllOperations];
    [self.dispatchDic removeAllObjects];
}

- (NSUInteger)currentCountOfOperations {
    return [self.downLoadQueue operationCount];
}

- (void)cancleOperationWithIdentify:(NSString *)identify {
    NSOperation *cancleOperation = self.dispatchDic[identify];
    if (!cancleOperation) {
        return;
    }
    if (![cancleOperation isExecuting]) {
        [cancleOperation cancel];
    }
}

- (void)downloadMusicWithMusicId:(NSString *)musicId musicUrlStr:(NSString *)musicUrlStr identify:(NSString *)identify downloadType:(enum XZMusicDownloadtype)downloadType downloadBlock:(void(^)(XZMusicDownloadResponse *response))downloadBlock{
    
    XZMusicDownloadDispatch *element = [[XZMusicDownloadDispatch alloc] init];
    element.downloadBlock = downloadBlock;
    element.identifyStr = identify;
    
    [self.dispatchDic addEntriesFromDictionary:@{identify:element}];
    
    //获取缓存的长度
    BOOL isMusic = (downloadType == XZMusicDownloadtypeForMusic) ? YES : NO;

    XZMusicDownloadOperation *downloadOperation = [[XZMusicDownloadOperation alloc] init];
    __weak XZMusicDownloadCenter *this = self;
    
    AFHTTPRequestOperation *operation = [downloadOperation downloadMusic:musicId musicUrlStr:musicUrlStr identify:identify isMusic:isMusic downloadBlock:^(XZMusicDownloadResponse *response) {
        [this downloadMusic:response];
    }];
    
    [self.downLoadQueue addOperation:operation];
}


- (void)downloadMusic:(XZMusicDownloadResponse *)response{
    if (response.downloadStatus == XZMusicDownloadFail) {
        DLog(@"下载失败");
        [self.dispatchDic removeObjectForKey:response.downloadIdentify];
    }else if (response.downloadStatus == XZMusicDownloadNetError) {
        [self.dispatchDic removeObjectForKey:response.downloadIdentify];
    }else if (response.downloadStatus == XZMusicDownloadIng) {
         XZMusicDownloadDispatch *element = (XZMusicDownloadDispatch *)self.dispatchDic[response.downloadIdentify];
        
        void(^downloadBlock)(XZMusicDownloadResponse *response) = element.downloadBlock;
        downloadBlock(response);        
    }else if (response.downloadStatus == XZMusicDownloadSuccess) {
        XZMusicDownloadDispatch *element = (XZMusicDownloadDispatch *)self.dispatchDic[response.downloadIdentify];
        
        void(^downloadBlock)(XZMusicDownloadResponse *response) = element.downloadBlock;
        downloadBlock(response);
    }
}

@end
