//
//  XZHeaderButton.m
//  XZMusic
//
//  Created by xiazer on 14-8-28.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "XZHeaderButton.h"
#import "UIImageView+AFnetworking.h"

@interface XZHeaderButton ()
@end

@implementation XZHeaderButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setimageWithUrl:(NSString *)url{
    if (self.imageView) {
        [self.imageView removeFromSuperview];
        self.imageView = nil;
    }
    self.imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    [self.imageView setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil];
    [self addSubview:self.imageView];
}

@end
