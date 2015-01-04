//
//  XZMyHeardView.m
//  XZMusic
//
//  Created by xiazer on 15/1/3.
//  Copyright (c) 2015年 xiazer. All rights reserved.
//

#import "XZMyHeardView.h"

@interface XZMyHeardView ()
@property (nonatomic, strong) UIButton *hearedMusicBtn;
@property (nonatomic, strong) NSMutableString *hearedMusicNameStr;
@property (nonatomic, strong) NSArray *hearedMusicArr;
@end

@implementation XZMyHeardView

- (void)displayUI:(void(^)(BOOL completed))Block
{
    self.completedBlock = Block;
    self.hearedMusicNameStr = [NSMutableString new];
    self.hearedMusicArr = [[XZMusicCoreDataCenter shareInstance] fetchAllMusicByPlayTimeRank];
    
    UILabel *titLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, ScreenWidth-30, 20)];
    titLab.backgroundColor = [UIColor clearColor];
    titLab.text = @"听过歌曲";
    [self addSubview:titLab];
    
    NSString *titStr = [NSString stringWithFormat:@"听过歌曲(%ld)",(long)self.hearedMusicArr.count];
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:titStr];
    [str addAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor],
                         NSFontAttributeName: [UIFont systemFontOfSize:16]
                         }
                 range:NSMakeRange(0, 4)];
    [str addAttributes:@{NSForegroundColorAttributeName: [UIColor redColor],
                         NSFontAttributeName: [UIFont systemFontOfSize:14]
                         }
                 range:NSMakeRange(4, titStr.length-4)];
    
    
    self.hearedMusicBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.hearedMusicBtn.frame = CGRectMake(15, 25, ScreenWidth-30, 80);
    self.hearedMusicBtn.backgroundColor = [UIColor whiteColor];
    self.hearedMusicBtn.layer.masksToBounds = YES;
    self.hearedMusicBtn.layer.borderWidth = 1.0;
    self.hearedMusicBtn.layer.borderColor = [UIColor blueColor].CGColor;
    [self.hearedMusicBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.hearedMusicBtn];
    
    UILabel *btnTitLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, ScreenWidth-50, 20)];
    btnTitLab.backgroundColor = [UIColor clearColor];
    btnTitLab.attributedText = str;
    [self.hearedMusicBtn addSubview:btnTitLab];
    
    UILabel *heardedMusicTitLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 30, ScreenWidth-60, 25)];
    heardedMusicTitLab.backgroundColor = [UIColor clearColor];
    [self.hearedMusicBtn addSubview:heardedMusicTitLab];
    
    if (self.hearedMusicArr.count > 0) {
        __block XZMyHeardView *this = self;
        [self.hearedMusicArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            XZMusicInfo *musicInfo = (XZMusicInfo *)[self.hearedMusicArr objectAtIndex:idx];
            if (idx == 0) {
                this.hearedMusicNameStr = [NSMutableString stringWithFormat:@"%@",musicInfo.musicName];
                if (self.hearedMusicArr.count == 1) {
                    *stop = YES;
                }
            } else {
                [this.hearedMusicNameStr appendString:[NSString stringWithFormat:@",%@",musicInfo.musicName]];
            }
        }];
        
        heardedMusicTitLab.text = this.hearedMusicNameStr;
    }
}

- (void)btnClicked:(id)sender
{
    self.completedBlock(YES);
}

@end
