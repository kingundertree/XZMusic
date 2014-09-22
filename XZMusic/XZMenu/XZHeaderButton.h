//
//  XZHeaderButton.h
//  XZMusic
//
//  Created by xiazer on 14-8-28.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "XZBaseButton.h"

@interface XZHeaderButton : XZBaseButton
@property(nonatomic, strong) UIImageView *imageView;

- (void)setimageWithUrl:(NSString *)url;

@end
