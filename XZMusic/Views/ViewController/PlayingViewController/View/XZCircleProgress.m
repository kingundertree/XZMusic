//
//  XZCircleProgress.m
//  XZCirclProgress
//
//  Created by xiazer on 14/11/19.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "XZCircleProgress.h"

@interface XZCircleProgress ()
@property(nonatomic, strong) UIColor *circleBgColor;
@property(nonatomic, strong) UIColor *circleProgressColor;
@property(nonatomic, assign) float lineWidth;
@end

@implementation XZCircleProgress

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self){
        self.backgroundColor = [UIColor clearColor];
        self.opaque = NO;
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    CGFloat lineWidth = 5.f;
    UIBezierPath *processBackgroundPath = [UIBezierPath bezierPath];
    processBackgroundPath.lineWidth = lineWidth;
    processBackgroundPath.lineCapStyle = kCGLineCapRound;
    CGPoint center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    CGFloat radius = (self.bounds.size.width - lineWidth)/2;
    CGFloat startAngle = - ((float)M_PI / 2);
    CGFloat endAngle = (2 * (float)M_PI) + startAngle;
    [processBackgroundPath addArcWithCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    [_circleBgColor set];
    [processBackgroundPath stroke];
    
    UIBezierPath *processPath = [UIBezierPath bezierPath];
    processPath.lineCapStyle = kCGLineCapRound;
    processPath.lineWidth = lineWidth;
    endAngle = (_progressV * 2 * (float)M_PI) + startAngle;
    [processPath addArcWithCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    [_circleProgressColor set];
    [processPath stroke];
}

- (void)setProgressStyle:(enum XZCircleProgressStyle)progressStyle{
    if (progressStyle == XZCircleProgressStyleForMusicDown) {
        _circleBgColor = [UIColor lightGrayColor];
        _circleProgressColor = [UIColor redColor];
        _lineWidth = 4.0;
    }else if (progressStyle == XZCircleProgressStyleForMusicPlaying){
        _circleBgColor = [UIColor blackColor];
        _circleProgressColor = [UIColor whiteColor];
        _lineWidth = 6.0;
    }
}

- (void)setProgressV:(float)progressV{
    NSLog(@"progressV--->>%f",progressV);
    _progressV = progressV;
    if (_progressV >= 1.0) {
        _progressV = 1.0;
    }
    [self setNeedsDisplay];
}

@end
