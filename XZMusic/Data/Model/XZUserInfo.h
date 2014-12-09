//
//  XZUserInfo.h
//  XZMusic
//
//  Created by xiazer on 14/12/9.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface XZUserInfo : NSManagedObject

@property (nonatomic, retain) NSString * userWeiboID;
@property (nonatomic, retain) NSString * userWeiboNick;
@property (nonatomic, retain) NSString * userWeiboHeaderImg;
@property (nonatomic, retain) NSNumber * userIsLogin;

@end
