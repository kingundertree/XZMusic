//
//  XZRequestResponse.h
//  XZMusic
//
//  Created by xiazer on 14/10/19.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ENUM(NSInteger, XZNetWorkingResponseStatus){
    XZNetWorkingResponseStatusSuccess,
    XZNetWorkingResponseStatusFailed,
    XZNetWorkingResponseStatusError
};

typedef unsigned int XZRequestID;
typedef unsigned int XZServiceType;

@interface XZRequestResponse : NSObject

@property(nonatomic, assign) XZRequestID requestID;
@property(nonatomic, assign) enum XZNetWorkingResponseStatus status;
@property(nonatomic, strong) NSDictionary *content;

@end
