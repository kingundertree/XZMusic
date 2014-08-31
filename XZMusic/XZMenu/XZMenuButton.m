//
//  XZMenuButton.m
//  XZMusic
//
//  Created by xiazer on 14-8-24.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "XZMenuButton.h"

@implementation XZMenuButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longGues:)];
        longPressGestureRecognizer.cancelsTouchesInView = NO;
        longPressGestureRecognizer.minimumPressDuration = 0.1;
        [self addGestureRecognizer:longPressGestureRecognizer];

        
    }
    return self;
}


- (void)longGues:(UILongPressGestureRecognizer *)gesture{
    if (gesture.state == UIGestureRecognizerStateEnded || gesture.state == UIGestureRecognizerStateFailed || gesture.state == UIGestureRecognizerStateCancelled) {
        [self setHighlighted:NO];
    }else if (gesture.state == UIGestureRecognizerStateBegan){
        [self setHighlighted:YES];
    }
}

@end
