//
//  XZMusicDataCenter.m
//  XZMusic
//
//  Created by xiazer on 14/12/10.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "XZMusicDataCenter.h"

@interface XZMusicDataCenter ()
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@end

@implementation XZMusicDataCenter

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSURL *momdUrl = [[NSBundle mainBundle] URLForResource:@"ZMusicCoreData" withExtension:@"momd"];
        self.managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:momdUrl];
    }
    return self;
}


- (void)dealloc
{
    [self.managedObjectContext save:NULL];
}

@end
