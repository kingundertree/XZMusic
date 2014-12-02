//
//  XZMusicPlayingTimeProgress.m
//  XZMusic
//
//  Created by xiazer on 14/12/1.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "XZMusicPlayingTimeProgress.h"

@implementation XZMusicPlayingTimeProgress

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
    self.playingTime = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 60, 30)];
    self.playingTime.backgroundColor = [UIColor clearColor];
    self.playingTime.textAlignment = NSTextAlignmentCenter;
    self.playingTime.font = [UIFont systemFontOfSize:12];
    self.playingTime.text = @"00:00";
    [self addSubview:self.playingTime];

    self.totalTime = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth-60, 10, 60, 30)];
    self.totalTime.backgroundColor = [UIColor clearColor];
    self.totalTime.textAlignment = NSTextAlignmentCenter;
    self.totalTime.font = [UIFont systemFontOfSize:12];
    [self addSubview:self.totalTime];
    
    self.timeSlider = [[UISlider alloc] initWithFrame:CGRectMake(60, 10, ScreenWidth-120, 30)];
    self.timeSlider.value = 0.5;
    [self addSubview:self.timeSlider];
}

- (void)initTimeProgressData:(int)time{
    self.timeSlider.maximumValue = time;
    self.timeSlider.minimumValue = 0.0;
    self.totalTime.text = [self getplayTime:time];
}

- (void)updatePlayingTime:(int)time{
    self.playingTime.text = [self getplayTime:time];
}

- (void)updateProgress:(int)playTime{
    [self.timeSlider setValue:playTime animated:YES];
}

- (NSString *)getplayTime:(int)time{
    int num1 = time/60;
    int num2 = time-60*num1;
    
    NSString *str1 = num1 >= 10 ? [NSString stringWithFormat:@"%d",num1] : [NSString stringWithFormat:@"0%d",num1];
    NSString *str2 = num2 >= 10 ? [NSString stringWithFormat:@"%d",num2] : [NSString stringWithFormat:@"0%d",num2];

    
    return [NSString stringWithFormat:@"%@:%@",str1,str2];
}

@end
