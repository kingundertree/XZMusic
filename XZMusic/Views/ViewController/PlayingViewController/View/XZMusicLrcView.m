//
//  XZMusicLrcView.m
//  XZMusic
//
//  Created by xiazer on 14/11/19.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "XZMusicLrcView.h"

@interface XZMusicLrcView () <UIScrollViewDelegate>
@property(nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic, strong) NSMutableArray *lrcLineConArr;
@property(nonatomic, strong) NSMutableArray *lrcLineKeyArr;
@property(nonatomic, strong) NSMutableArray *lrcLinelabArr;
@end

@implementation XZMusicLrcView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self){
        self.backgroundColor = [UIColor clearColor];
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    self.lrcLineConArr = [[NSMutableArray alloc] init];
    self.lrcLineKeyArr = [[NSMutableArray alloc] init];
    self.lrcLinelabArr = [[NSMutableArray alloc] init];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.backgroundColor = [UIColor XZMiddleGrayColor];
    self.scrollView.delegate = self;
    [self addSubview:self.scrollView];
}

- (void)initLrcViewWithPath:(NSString *)lrcPath{
    if (self.lrcLineConArr.count != 0) {
        [self.lrcLineConArr removeAllObjects];
    }
    if (self.lrcLineKeyArr.count != 0) {
        [self.lrcLineKeyArr removeAllObjects];
    }
    if (self.lrcLinelabArr.count != 0) {
        [self.lrcLinelabArr removeAllObjects];
    }
    
    NSString *string =[NSString stringWithContentsOfFile:lrcPath encoding:NSUTF8StringEncoding error:nil];
    NSArray *array = [string componentsSeparatedByString:@"\n"];
    
    for (int i = 0; i < array.count; i++) {
        NSString *lineStr = [array objectAtIndex:i];
        NSArray *lineStrSepArr = [lineStr componentsSeparatedByString:@"]"];

        if (lineStrSepArr.count >=2) {
            NSString *firstStr = [lineStrSepArr firstObject];
            NSString *lastStr = [lineStrSepArr lastObject];
            if (lastStr.length > 0) {
                [self.lrcLineConArr addObject:lastStr];
                NSRange range = NSMakeRange (1, 5);
                [self.lrcLineKeyArr addObject:[firstStr substringWithRange:range]];
            }else {
                NSRange range = [firstStr rangeOfString:@"."];
                if (range.length > 0) {
                    [self.lrcLineConArr addObject:@""];
                    [self.lrcLineKeyArr addObject:@"headerDes"];
                }else {
                    NSArray *firstConArr = [firstStr componentsSeparatedByString:@":"];
                    [self.lrcLineConArr addObject:[firstConArr lastObject]];
                    [self.lrcLineKeyArr addObject:@"headerDes"];
                }
            }
        }else {
            [self.lrcLineConArr addObject:@""];
            [self.lrcLineKeyArr addObject:@"headerDes"];
        }
    }
    
    [self displayLrcLine];
    DLog(@"keyAndCon--->>%@/%@",self.lrcLineConArr,self.lrcLineKeyArr);
}

- (void)displayLrcLine{
    for (UIView *view in self.scrollView.subviews) {
        [view removeFromSuperview];
    }
    
    for (int i = 0; i < self.lrcLineConArr.count; i++) {
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height/2 - 25/2 + 25*i, self.frame.size.width, 25)];
        lab.backgroundColor = [UIColor clearColor];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.font = [UIFont xzH4Font];
        lab.text = [self.lrcLineConArr objectAtIndex:i];
        lab.textColor = [UIColor whiteColor];
        [self.scrollView addSubview:lab];
        
        [self.lrcLinelabArr addObject:lab];
    }
    
    UILabel *lab = [self.lrcLinelabArr objectAtIndex:0];
    lab.textColor = [UIColor XZRedColor];
    self.scrollView.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height - 25 + 25*self.lrcLineConArr.count);
}

- (void)moveLrcWithTime:(int)time{
    NSString *timeStr = [self timeformatFromSeconds:time];
    
    NSInteger currentNum = 0;
    for (int j = 0; j < self.lrcLineKeyArr.count; j++) {
        if ([timeStr isEqualToString:[self.lrcLineKeyArr objectAtIndex:j]]) {
            DLog(@"timeStr--->>%@/%@",timeStr,[self.lrcLineKeyArr objectAtIndex:j]);

            currentNum = j;
            break;
        }else {
            currentNum = -1;
        }
    }
    
    if (currentNum >= 0) {
        for (int i = 0; i < self.lrcLinelabArr.count; i++) {
            UILabel *lab = [self.lrcLinelabArr objectAtIndex:i];
            lab.textColor = [UIColor whiteColor];
        }

        UILabel *lab = [self.lrcLinelabArr objectAtIndex:currentNum];
        lab.textColor = [UIColor redColor];
        
        CGPoint point = CGPointMake(0, 25*currentNum);
        [self.scrollView setContentOffset:point animated:YES];
    }
}

-(NSString*)timeformatFromSeconds:(int)seconds {
    int totalm = seconds/(60);
    int h = totalm/(60);
    int m = totalm%(60);
    int s = seconds%(60);
    if (h==0) {
        return  [NSString stringWithFormat:@"%02d:%02d", m, s];
    }
    return [NSString stringWithFormat:@"%02d:%02d:%02d", h, m, s];
}



@end
