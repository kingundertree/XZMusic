//
//  XZMusicDataCenter.m
//  XZMusic
//
//  Created by xiazer on 14/12/10.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "XZMusicCoreDataCenter.h"
#import "NSDictionary+XZ.h"

@interface XZMusicCoreDataCenter ()
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@end

@implementation XZMusicCoreDataCenter

+ (XZMusicCoreDataCenter *)shareInstance{
    static XZMusicCoreDataCenter *shareInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        shareInstance = [[self alloc] init];
    });
    
    return shareInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSURL *momdUrl = [[NSBundle mainBundle] URLForResource:@"XZMusicCoreData" withExtension:@"momd"];
        self.managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:momdUrl];

        if (self.managedObjectContext) {
            [self.managedObjectContext save:NULL];
        }
        
        NSString *libraryDirectory = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *storePath = [libraryDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"XZMusicCoreData.sqlite"]];
        NSURL *storeUrl = [NSURL fileURLWithPath:storePath];
        
        __autoreleasing NSError *error = nil;
        self.persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
        NSDictionary *options = @{NSMigratePersistentStoresAutomaticallyOption:[NSNumber numberWithBool:YES],NSInferMappingModelAutomaticallyOption:[NSNumber numberWithBool:YES]};
        if ([self.persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:options error:&error]) {
            self.managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
            self.managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator;
        }
        
    }
    return self;
}

#pragma mark - userInfo method
- (BOOL)isUserExit:(NSString *)userWeiboId
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"XZUserInfo" inManagedObjectContext:self.managedObjectContext];
    fetchRequest.entity = entity;
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"userWeiboID = %@",userWeiboId];
    
    NSArray *resut = [self.managedObjectContext executeFetchRequest:fetchRequest error:NULL];
    
    if (resut.count > 0) {
        return YES;
    }
    
    return NO;
}

- (XZUserInfo *)fetchUserInfo:(NSString *)userWeiboId
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"XZUserInfo" inManagedObjectContext:self.managedObjectContext];
    fetchRequest.entity = entity;
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"userWeiboID = %@",userWeiboId];
    
    NSArray *resut = [self.managedObjectContext executeFetchRequest:fetchRequest error:NULL];
    
    if (resut.count > 0) {
        return resut.firstObject;
    }

    return nil;
}

- (XZUserInfo *)saveNewUserInfo:(NSDictionary *)userInfo
{
    XZUserInfo *insertUserInfo = [NSEntityDescription insertNewObjectForEntityForName:@"XZUserInfo" inManagedObjectContext:self.managedObjectContext];
    NSString *idStr = [userInfo[@"profile_image_url"] substringWithRange:NSMakeRange(22, 10)];
    
    insertUserInfo.userWeiboID = [NSString stringWithFormat:@"%@",idStr];
    insertUserInfo.userWeiboNick = userInfo[@"name"];
    insertUserInfo.userWeiboHeaderImg = userInfo[@"avatar_hd"];
    insertUserInfo.userIsLogin = [NSNumber numberWithBool:YES];

    __autoreleasing NSError *error;
    [self.managedObjectContext save:&error];

    return insertUserInfo;
}

- (BOOL)updateUserLoginInfo:(NSString *)userWeiboId isLogin:(BOOL)isLogin
{
    XZUserInfo *userInfo = [self fetchUserInfo:userWeiboId];
    if (userInfo) {
        userInfo.userIsLogin = [NSNumber numberWithBool:isLogin];
        
        __autoreleasing NSError *error;
        [self.managedObjectContext save:&error];
        
        return YES;
    }
    
    return NO;
}

- (XZUserInfo *)fetchLoginUserInfo
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"XZUserInfo" inManagedObjectContext:self.managedObjectContext];
    fetchRequest.entity = entity;
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"userIsLogin = %@", [NSNumber numberWithBool:YES]];
    
    NSArray *resut = [self.managedObjectContext executeFetchRequest:fetchRequest error:NULL];
    
    if (resut.count > 0) {
        return resut.firstObject;
    }
    
    return nil;
}

- (BOOL)isMusicExit:(NSString *)musicId
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"XZMusicInfo" inManagedObjectContext:self.managedObjectContext];
    fetchRequest.entity = entity;
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"musicId = %@",musicId];
    
    NSArray *resut = [self.managedObjectContext executeFetchRequest:fetchRequest error:NULL];
    
    if (resut.count > 0) {
        return YES;
    }
    
    return NO;
}

- (BOOL)isMusicDownload:(NSString *)musicId
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"XZMusicInfo" inManagedObjectContext:self.managedObjectContext];
    fetchRequest.entity = entity;
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"musicId = %@ AND musicLrcIsDown = %@",musicId,[NSNumber numberWithBool:YES]];
    
    NSArray *resut = [self.managedObjectContext executeFetchRequest:fetchRequest error:NULL];
    
    if (resut.count > 0) {
        return YES;
    }
    
    return NO;
}

- (BOOL)isMusicLrcDownload:(NSString *)musicId
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"XZMusicInfo" inManagedObjectContext:self.managedObjectContext];
    fetchRequest.entity = entity;
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"musicId = %@ AND musicLrcIsDown = %@",musicId,[NSNumber numberWithBool:YES]];
    
    NSArray *resut = [self.managedObjectContext executeFetchRequest:fetchRequest error:NULL];
    
    if (resut.count > 0) {
        return YES;
    }
    
    return NO;
}

- (XZMusicInfo *)fetchMusicInfo:(NSString *)musicId
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"XZMusicInfo" inManagedObjectContext:self.managedObjectContext];
    fetchRequest.entity = entity;
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"musicId = %@",musicId];
    
    NSArray *resut = [self.managedObjectContext executeFetchRequest:fetchRequest error:NULL];
    
    if (resut.count > 0) {
        return resut.firstObject;
    }
    
    return nil;
}

- (XZMusicInfo *)saveNewMusicInfo:(NSDictionary *)musicInfo
{
    XZMusicInfo *insertMusicInfo = [NSEntityDescription insertNewObjectForEntityForName:@"XZMusicInfo" inManagedObjectContext:self.managedObjectContext];

    if ([[musicInfo allKeys] count]>1) {
        NSDictionary * data = [musicInfo objectForKey:@"data"];
        NSArray *songList = [data objectForKey:@"songList"];
        for (NSDictionary *sub in songList) {
            insertMusicInfo.musicSongUrl = [sub objectForKey:@"songLink"];
            NSRange range = [insertMusicInfo.musicSongUrl rangeOfString:@"src"];
            if (range.location != 2147483647 && range.length != 0) {
                NSString * temp = [insertMusicInfo.musicSongUrl substringToIndex:range.location-1];
                insertMusicInfo.musicSongUrl = temp;
            }
            insertMusicInfo.musicId = [NSString stringWithFormat:@"%d",[[sub objectForKey:@"songId"] intValue]];
            
            insertMusicInfo.musicName = [sub objectForKey:@"songName"];
            insertMusicInfo.musicIsDown = [NSNumber numberWithBool:NO];
            insertMusicInfo.musicLrcIsDown = [NSNumber numberWithBool:NO];
            insertMusicInfo.musicTime = [NSNumber numberWithInt:[[sub objectForKey:@"time"] intValue]];
            insertMusicInfo.musicPlayTime = [NSNumber numberWithInt:1];
            insertMusicInfo.musicPlayedTime = [NSNumber numberWithInt:0];
            insertMusicInfo.musicIsPraised = [NSNumber numberWithBool:NO];
            insertMusicInfo.musicAlbumId = [NSString stringWithFormat:@"%d",[[sub objectForKey:@"albumId"] intValue]];
            insertMusicInfo.musicAlbum = [sub objectForKey:@"albumName"];
            insertMusicInfo.musicSonger = [sub objectForKey:@"artistName"];
            insertMusicInfo.musicDetailInfoString = [sub dataTransformToString];
            insertMusicInfo.musicLrcUrl = [sub objectForKey:@"lrcLink"];
            insertMusicInfo.musicFormat = [sub objectForKey:@"format"];
            insertMusicInfo.musicBigImgUrl = [sub objectForKey:@"songPicBig"];
            insertMusicInfo.userWeiboId = [XZGlobalManager shareInstance].userWeiboId;
        }
    }
    __autoreleasing NSError *error;
    [self.managedObjectContext save:&error];
    
    return insertMusicInfo;
}

- (BOOL)updateMusicInfo:(NSString *)musicId isMusicDown:(BOOL)isMusicDown
{
    XZMusicInfo *musicInfo = [self fetchMusicInfo:musicId];
    if (musicInfo) {
        musicInfo.musicIsDown = [NSNumber numberWithBool:isMusicDown];
        
        __autoreleasing NSError *error;
        [self.managedObjectContext save:&error];
        
        return YES;
    }
    return NO;
}
- (BOOL)updateMusicInfo:(NSString *)musicId isMusicLrcDown:(BOOL)isMusicLrcDown
{
    XZMusicInfo *musicInfo = [self fetchMusicInfo:musicId];
    if (musicInfo) {
        musicInfo.musicLrcIsDown = [NSNumber numberWithBool:isMusicLrcDown];
        
        __autoreleasing NSError *error;
        [self.managedObjectContext save:&error];
        
        return YES;
    }
    return NO;
}
- (BOOL)updateMusicInfo:(NSString *)musicId isAddPraise:(BOOL)isAddPraise
{
    XZMusicInfo *musicInfo = [self fetchMusicInfo:musicId];
    if (musicInfo) {
        musicInfo.musicIsPraised = [NSNumber numberWithBool:isAddPraise];
        
        __autoreleasing NSError *error;
        [self.managedObjectContext save:&error];
        
        return YES;
    }
    return NO;
}
- (BOOL)updateMusicInfoForPlayCount:(NSString *)musicId
{
    XZMusicInfo *musicInfo = [self fetchMusicInfo:musicId];
    if (musicInfo) {
        musicInfo.musicPlayTime = [NSNumber numberWithBool:[musicInfo.musicPlayTime integerValue]+1];
        
        __autoreleasing NSError *error;
        [self.managedObjectContext save:&error];
        
        return YES;
    }
    return NO;
}
- (BOOL)updateMusicInfoForPlayedCount:(NSString *)musicId
{
    XZMusicInfo *musicInfo = [self fetchMusicInfo:musicId];
    if (musicInfo) {
        musicInfo.musicPlayedTime = [NSNumber numberWithBool:[musicInfo.musicPlayedTime integerValue]+1];
        
        __autoreleasing NSError *error;
        [self.managedObjectContext save:&error];
        
        return YES;
    }
    return NO;
}
- (BOOL)deleteMusicInfo:(NSString *)musicId
{
    XZMusicInfo *musicInfo = [self fetchMusicInfo:musicId];
    if (musicInfo) {
        [self.managedObjectContext deleteObject:musicInfo];
        
        __autoreleasing NSError *error;
        [self.managedObjectContext save:&error];
        return YES;
    }
    return NO;
}

- (NSArray *)fetchAllMusic
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"XZMusicInfo" inManagedObjectContext:self.managedObjectContext];
    fetchRequest.entity = entity;
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"userWeiboId = %@ AND musicIsDown = %@",[XZGlobalManager shareInstance].userWeiboId,[NSNumber numberWithBool:YES]];
    
    NSArray *resut = [self.managedObjectContext executeFetchRequest:fetchRequest error:NULL];
    
    return resut;
}


- (void)dealloc
{
    [self.managedObjectContext save:NULL];
}

@end
