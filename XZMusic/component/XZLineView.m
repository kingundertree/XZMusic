//
//  XZLineView.m
//  XZMusic
//
//  Created by xiazer on 14-8-24.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "XZLineView.h"

@implementation XZLineView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.borderWidth = 1.0;
        self.horizontalLine = YES;
        self.lineColor = [UIColor colorWithRed:.783922 green:.780392 blue:.8 alpha:1];
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGFloat halfLineWidth = self.borderWidth / 2.0f;
    
    if (self.horizontalLine) {
        CGFloat lineTop = CGRectGetMaxY(rect) - halfLineWidth;
        CGFloat lineWidth = rect.size.width;
        CGContextSetStrokeColorWithColor(ctx, [self.lineColor CGColor]);
        CGContextSetLineWidth(ctx, self.borderWidth);
        CGContextBeginPath(ctx);
        CGContextMoveToPoint(ctx, rect.origin.x, lineTop);
        CGContextAddLineToPoint(ctx, lineWidth, lineTop);
        CGContextStrokePath(ctx);
        
        CGContextSetStrokeColorWithColor(ctx, [self.lineColor CGColor]);
        CGContextSetLineWidth(ctx, self.borderWidth);
        CGContextBeginPath(ctx);
        CGContextMoveToPoint(ctx, rect.origin.x, CGRectGetMaxY(rect));
        CGContextAddLineToPoint(ctx, lineWidth, CGRectGetMaxY(rect));
        CGContextStrokePath(ctx);
    }else{
        CGFloat lineTop = CGRectGetMaxX(rect) - halfLineWidth;
        CGFloat lineHeight = rect.size.height;
        CGContextSetStrokeColorWithColor(ctx, [self.lineColor CGColor]);
        CGContextSetLineWidth(ctx, self.borderWidth);
        CGContextBeginPath(ctx);
        CGContextMoveToPoint(ctx, lineTop, rect.origin.y);
        CGContextAddLineToPoint(ctx, lineTop, lineHeight);
        CGContextStrokePath(ctx);
        
        CGContextSetStrokeColorWithColor(ctx, [self.lineColor CGColor]);
        CGContextSetLineWidth(ctx, self.borderWidth);
        CGContextBeginPath(ctx);
        CGContextMoveToPoint(ctx, CGRectGetMaxX(rect), rect.origin.y);
        CGContextAddLineToPoint(ctx, CGRectGetMaxX(rect), lineHeight);
        CGContextStrokePath(ctx);
    }
}

@end
