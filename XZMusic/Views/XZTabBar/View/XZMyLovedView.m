//
//  XZMyLovedView.m
//  XZMusic
//
//  Created by xiazer on 15/1/3.
//  Copyright (c) 2015年 xiazer. All rights reserved.
//

#import "XZMyLovedView.h"
#import "XZMusicCoreDataCenter.h"
#import "XZMusicInfo.h"

@interface XZMyLovedView ()
@property (nonatomic, strong) UIButton *lovedMusicBtn;
@property (nonatomic, strong) NSMutableString *lovedMusicNameStr;
@property (nonatomic, strong) NSArray *lovedMusicArr;
@end


@implementation XZMyLovedView

- (void)displayUI:(void(^)(BOOL completed))Block
{
    self.completedBlock = Block;
    self.lovedMusicNameStr = [NSMutableString new];
    self.lovedMusicArr = [[XZMusicCoreDataCenter shareInstance] fetchAllMusicByPlayedTimeRank];
    
    UILabel *titLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, ScreenWidth-30, 20)];
    titLab.backgroundColor = [UIColor clearColor];
    titLab.text = @"最爱歌曲";
    [self addSubview:titLab];
    
    NSString *titStr = [NSString stringWithFormat:@"最爱歌曲(%ld)",(long)self.lovedMusicArr.count];
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:titStr];
    [str addAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor],
                         NSFontAttributeName: [UIFont systemFontOfSize:16]
                         }
                 range:NSMakeRange(0, 4)];
    [str addAttributes:@{NSForegroundColorAttributeName: [UIColor redColor],
                         NSFontAttributeName: [UIFont systemFontOfSize:14]
                         }
                 range:NSMakeRange(4, titStr.length-4)];
    
    
    self.lovedMusicBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.lovedMusicBtn.frame = CGRectMake(15, 25, ScreenWidth-30, 80);
    self.lovedMusicBtn.backgroundColor = [UIColor whiteColor];
    self.lovedMusicBtn.layer.masksToBounds = YES;
    self.lovedMusicBtn.layer.borderWidth = 1.0;
    self.lovedMusicBtn.layer.borderColor = [UIColor blueColor].CGColor;
    [self.lovedMusicBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.lovedMusicBtn];
    
    UILabel *btnTitLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, ScreenWidth-50, 20)];
    btnTitLab.backgroundColor = [UIColor clearColor];
    btnTitLab.attributedText = str;
    [self.lovedMusicBtn addSubview:btnTitLab];
    
    UILabel *lovedMusicTitLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 30, ScreenWidth-60, 25)];
    lovedMusicTitLab.backgroundColor = [UIColor clearColor];
    [self.lovedMusicBtn addSubview:lovedMusicTitLab];
    
    if (self.lovedMusicArr.count > 0) {
        __block XZMyLovedView *this = self;
        [self.lovedMusicArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            XZMusicInfo *musicInfo = (XZMusicInfo *)[self.lovedMusicArr objectAtIndex:idx];
            if (idx == 0) {
                this.lovedMusicNameStr = [NSMutableString stringWithFormat:@"%@",musicInfo.musicName];
                if (self.lovedMusicArr.count == 1) {
                    *stop = YES;
                }
            } else {
                [this.lovedMusicNameStr appendString:[NSString stringWithFormat:@",%@",musicInfo.musicName]];
            }
        }];
        
        lovedMusicTitLab.text = this.lovedMusicNameStr;
    }
}

- (void)btnClicked:(id)sender
{
    self.completedBlock(YES);
}


@end
