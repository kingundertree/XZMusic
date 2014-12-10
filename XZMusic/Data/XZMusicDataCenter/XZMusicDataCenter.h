//
//  XZMusicDataCenter.h
//  XZMusic
//
//  Created by xiazer on 14/12/10.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class XZMusicDataCenter;
@protocol XZMusicDataCenterDelegate <NSObject>

@end

@interface XZMusicDataCenter : NSObject
@property (nonatomic, assign) id<XZMusicDataCenterDelegate> dataCenterDelegate;

- (instancetype)init;
@end
