//
//  XZMusicDownloadOperation.m
//  XZMusic
//
//  Created by xiazer on 14/11/22.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "XZMusicDownloadOperation.h"

#define XZMusicFile  @"/music"

@interface XZMusicDownloadOperation ()
@property(nonatomic, strong) AFHTTPRequestOperation *requestOperation;
@property(nonatomic, strong) NSString *cacheFile;
@property(nonatomic, copy) void(^downloadBlock)(XZMusicDownloadResponse *response);
@property(nonatomic, strong) XZMusicDownloadResponse *dowloadResponse;

@end

@implementation XZMusicDownloadOperation

- (AFHTTPRequestOperation *)downloadMusic:(NSString *)musicId musicUrlStr:(NSString *)musicUrlStr identify:(NSString *)identify isMusic:(BOOL)isMusic downloadBlock:(void(^)(XZMusicDownloadResponse *response))downloadBlock{
    self.downloadBlock = downloadBlock;
    self.dowloadResponse = [[XZMusicDownloadResponse alloc] init];
    self.dowloadResponse.downloadStatus = XZMusicDownloadIng;
    self.dowloadResponse.downloadIdentify = identify;
    
    long long cacheLength;

    self.cacheFile = [[self class] getMusicFile:musicId isMusic:isMusic];
    cacheLength = [[self class] cacheFileWithCacheFile:self.cacheFile];

    //获取请求
    NSURL *musicUrl = [NSURL URLWithString:musicUrlStr];
    NSMutableURLRequest *request = [[self class] requestWithUrl:musicUrl Range:cacheLength];

    self.requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [self.requestOperation setOutputStream:[NSOutputStream outputStreamToFileAtPath:self.cacheFile append:NO]];
    
    //处理流
    [self readCacheToOutStreamWithPath:self.cacheFile];

    [self.requestOperation addObserver:self forKeyPath:@"isPaused" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];

    //重组进度block
    [self.requestOperation setDownloadProgressBlock:[self getNewProgressBlockWithCacheLength:cacheLength]];

    [self.requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"downloadsuccess");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"downloadfail,error--->>%@",error.userInfo);
    }];
    
//    [self.requestOperation start];
    
    return self.requestOperation;
}

#pragma mark - 重组进度块
-(void(^)(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead))getNewProgressBlockWithCacheLength:(long long)cachLength
{
    __weak XZMusicDownloadOperation *this = self;
    void(^newProgressBlock)(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) = ^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead)
    {
        NSData* data = [NSData dataWithContentsOfFile:self.cacheFile];
        [self.requestOperation setValue:data forKey:@"responseData"];
        
        float progress = totalBytesRead / (float)totalBytesExpectedToRead;
        
        this.dowloadResponse.progress = progress;
        this.dowloadResponse.downloadStatus = XZMusicDownloadIng;
        
        this.downloadBlock(self.dowloadResponse);
    };
    
    return newProgressBlock;
}

#pragma mark - 监听暂停
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    NSLog(@"keypath = %@ changeDic = %@",keyPath,change);
    //暂停状态
    if ([keyPath isEqualToString:@"isPaused"] && [[change objectForKey:@"new"] intValue] == 1) {
        
        long long cacheLength = [[self class] cacheFileWithCacheFile:self.cacheFile];
        //暂停读取data 从文件中获取到NSNumber
        cacheLength = [[self.requestOperation.outputStream propertyForKey:NSStreamFileCurrentOffsetKey] unsignedLongLongValue];
        NSLog(@"cacheLength = %lld",cacheLength);
        [self.requestOperation setValue:@"0" forKey:@"totalBytesRead"];
        //重组进度block
        [self.requestOperation setDownloadProgressBlock:[self getNewProgressBlockWithCacheLength:cacheLength]];
    }
}

#pragma mark - 获取本地文件路径
+ (NSString *)getMusicFile:(NSString *)musicId isMusic:(BOOL)isMusic{
    NSString *fileStr;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSArray *myPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *myDocPath = [myPaths objectAtIndex:0];
    
    if (![fileManager fileExistsAtPath:[myDocPath stringByAppendingString:@"/music"]]) {
        [fileManager createDirectoryAtPath:[myDocPath stringByAppendingString:@"/music"] withIntermediateDirectories:NO attributes:nil error:nil];
    }
    
    if (isMusic) {
        if (![fileManager fileExistsAtPath:[myDocPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@",XZMusicFile,musicId]]]) {
            [fileManager createDirectoryAtPath:[myDocPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@",XZMusicFile,musicId]] withIntermediateDirectories:NO attributes:nil error:nil];
        }
        
        fileStr = [myDocPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@/music",XZMusicFile,musicId]];
    }else{
        if (![fileManager fileExistsAtPath:[myDocPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@",XZMusicFile,musicId]]]) {
            [fileManager createDirectoryAtPath:[myDocPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@",XZMusicFile,musicId]] withIntermediateDirectories:NO attributes:nil error:nil];
        }
        fileStr = [myDocPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@/lrc",XZMusicFile,musicId]];
    }
    
    DLog(@"fileStr--->>%@",fileStr);
    return fileStr;
}

#pragma mark - 获取本地缓存的字节
+ (long long)cacheFileWithCacheFile:(NSString *)cacheFile{
    NSFileHandle *fh = [NSFileHandle fileHandleForReadingAtPath:cacheFile];
    
    NSData *contentData = [fh readDataToEndOfFile];
    return contentData ? contentData.length : 0;
    
}

#pragma mark - 获取请求
+(NSMutableURLRequest*)requestWithUrl:(id)url Range:(long long)length {
    NSURL *requestUrl = [url isKindOfClass:[NSURL class]] ? url : [NSURL URLWithString:url];
    
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:requestUrl
                                                           cachePolicy:NSURLRequestReloadIgnoringCacheData
                                                       timeoutInterval:5*60];
    
    if (length) {
        [request setValue:[NSString stringWithFormat:@"bytes=%lld-",length] forHTTPHeaderField:@"Range"];
    }
    
    NSLog(@"request.head = %@",request.allHTTPHeaderFields);
    
    return request;
    
}

#pragma mark - 读取本地缓存入流
-(void)readCacheToOutStreamWithPath:(NSString*)path{
    NSFileHandle *fh = [NSFileHandle fileHandleForReadingAtPath:path];
    NSData *currentData = [fh readDataToEndOfFile];
    
    if (currentData.length) {
        //打开流，写入data ， 未打卡查看 streamCode = NSStreamStatusNotOpen
        [self.requestOperation.outputStream open];
        
        NSInteger       bytesWritten;
        NSInteger       bytesWrittenSoFar;
        
        NSInteger  dataLength = [currentData length];
        const uint8_t * dataBytes  = [currentData bytes];
        
        bytesWrittenSoFar = 0;
        do {
            bytesWritten = [self.requestOperation.outputStream write:&dataBytes[bytesWrittenSoFar] maxLength:dataLength - bytesWrittenSoFar];
            assert(bytesWritten != 0);
            if (bytesWritten == -1) {
                break;
            } else {
                bytesWrittenSoFar += bytesWritten;
            }
        } while (bytesWrittenSoFar != dataLength);
    }
}

@end
