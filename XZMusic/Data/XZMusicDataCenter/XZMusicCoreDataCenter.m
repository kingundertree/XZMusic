//
//  XZMusicDataCenter.m
//  XZMusic
//
//  Created by xiazer on 14/12/10.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "XZMusicCoreDataCenter.h"

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
    userInfo.userIsLogin = [NSNumber numberWithBool:isLogin];
    
    __autoreleasing NSError *error;
    [self.managedObjectContext save:&error];
    
    return YES;
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

- (void)dealloc
{
    [self.managedObjectContext save:NULL];
}

@end
