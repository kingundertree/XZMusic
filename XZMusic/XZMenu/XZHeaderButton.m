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
    if (self.headerImageView) {
        [self.headerImageView removeFromSuperview];
        self.headerImageView = nil;
    }
    self.headerImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    [self.headerImageView setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil];
    [self addSubview:self.headerImageView];
}

- (void)WBLooginQuite{
    if (self.headerImageView) {
        [self.headerImageView removeFromSuperview];
        self.headerImageView = nil;
    }
}

@end
