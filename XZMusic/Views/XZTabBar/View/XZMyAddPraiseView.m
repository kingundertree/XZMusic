//
//  XZMyLovedView.m
//  XZMusic
//
//  Created by xiazer on 15/1/1.
//  Copyright (c) 2015年 xiazer. All rights reserved.
//

#import "XZMyAddPraiseView.h"
#import "XZMusicCoreDataCenter.h"
#import "XZMusicInfo.h"

@interface XZMyAddPraiseView ()
@property (nonatomic, strong) UIButton *addPraiseBrn;
@property (nonatomic, strong) NSMutableString *addPraiseMusicNameStr;
@property (nonatomic, strong) NSArray *addPraiseMusicArr;
@end

@implementation XZMyAddPraiseView

- (void)displayUI:(void(^)(BOOL completed))Block
{
    self.completedBlock = Block;
    self.addPraiseMusicNameStr = [NSMutableString new];
    self.addPraiseMusicArr = [[XZMusicCoreDataCenter shareInstance] fetchAllMusicByLoved];
    
    UILabel *titLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, ScreenWidth-30, 20)];
    titLab.backgroundColor = [UIColor clearColor];
    titLab.text = @"点赞歌曲";
    [self addSubview:titLab];

    NSString *titStr = [NSString stringWithFormat:@"点赞歌曲(%ld)",(long)self.addPraiseMusicArr.count];
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:titStr];
    [str addAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor],
                         NSFontAttributeName: [UIFont systemFontOfSize:16]
                         }
                 range:NSMakeRange(0, 4)];
    [str addAttributes:@{NSForegroundColorAttributeName: [UIColor redColor],
                         NSFontAttributeName: [UIFont systemFontOfSize:14]
                         }
                 range:NSMakeRange(4, titStr.length-4)];
    
    
    self.addPraiseBrn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.addPraiseBrn.frame = CGRectMake(15, 25, ScreenWidth-30, 80);
    self.addPraiseBrn.backgroundColor = [UIColor whiteColor];
    self.addPraiseBrn.layer.masksToBounds = YES;
    self.addPraiseBrn.layer.borderWidth = 1.0;
    self.addPraiseBrn.layer.borderColor = [UIColor blueColor].CGColor;
    [self.addPraiseBrn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.addPraiseBrn];
    

    UILabel *btnTitLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, ScreenWidth-50, 20)];
    btnTitLab.backgroundColor = [UIColor clearColor];
    btnTitLab.attributedText = str;
    [self.addPraiseBrn addSubview:btnTitLab];

    UILabel *lovedMusicTitLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 30, ScreenWidth-60, 25)];
    lovedMusicTitLab.backgroundColor = [UIColor clearColor];
    [self.addPraiseBrn addSubview:lovedMusicTitLab];
    
    if (self.addPraiseMusicArr.count > 0) {
        __block XZMyAddPraiseView *this = self;
        [self.addPraiseMusicArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            XZMusicInfo *musicInfo = (XZMusicInfo *)[self.addPraiseMusicArr objectAtIndex:idx];
            if (idx == 0) {
                this.addPraiseMusicNameStr = [NSMutableString stringWithFormat:@"%@",musicInfo.musicName];
                if (self.addPraiseMusicArr.count == 1) {
                    *stop = YES;
                }
            } else {
                [this.addPraiseMusicNameStr appendString:[NSString stringWithFormat:@",%@",musicInfo.musicName]];
            }
        }];
        
        lovedMusicTitLab.text = this.addPraiseMusicNameStr;
    }
}

- (void)btnClicked:(id)sender
{
    self.completedBlock(YES);
}

@end
