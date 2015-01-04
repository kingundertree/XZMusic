//
//  XZMyLocalView.m
//  XZMusic
//
//  Created by xiazer on 15/1/1.
//  Copyright (c) 2015年 xiazer. All rights reserved.
//

#import "XZMyLocalView.h"

@interface XZMyLocalView ()
@property (nonatomic, strong) UIButton *localMusicBrn;
@property (nonatomic, strong) NSMutableString *localMusicNameStr;
@property (nonatomic, strong) NSArray *localMusicArr;
@end

@implementation XZMyLocalView

- (void)displayUI:(void(^)(BOOL completed))Block
{
    self.completedBlock = Block;
    self.localMusicNameStr = [NSMutableString new];
    self.localMusicArr = [[XZMusicCoreDataCenter shareInstance] fetchAllDownedMusic];
    
    UILabel *titLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, ScreenWidth-30, 20)];
    titLab.backgroundColor = [UIColor clearColor];
    titLab.text = @"已下载歌曲";
    [self addSubview:titLab];
    
    NSString *titStr = [NSString stringWithFormat:@"已下载歌曲(%ld)",(long)self.localMusicArr.count];
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:titStr];
    [str addAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor],
                         NSFontAttributeName: [UIFont systemFontOfSize:16]
                         }
                 range:NSMakeRange(0, 5)];
    [str addAttributes:@{NSForegroundColorAttributeName: [UIColor redColor],
                         NSFontAttributeName: [UIFont systemFontOfSize:14]
                         }
                 range:NSMakeRange(5, titStr.length-5)];
    
    
    self.localMusicBrn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.localMusicBrn.frame = CGRectMake(15, 25, ScreenWidth-30, 80);
    self.localMusicBrn.backgroundColor = [UIColor whiteColor];
    self.localMusicBrn.layer.masksToBounds = YES;
    self.localMusicBrn.layer.borderWidth = 1.0;
    self.localMusicBrn.layer.borderColor = [UIColor blueColor].CGColor;
    [self.localMusicBrn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.localMusicBrn];
    
    UILabel *btnTitLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, ScreenWidth-50, 20)];
    btnTitLab.backgroundColor = [UIColor clearColor];
    btnTitLab.attributedText = str;
    [self.localMusicBrn addSubview:btnTitLab];
    
    UILabel *localMusicTitLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 30, ScreenWidth-60, 25)];
    localMusicTitLab.backgroundColor = [UIColor clearColor];
    [self.localMusicBrn addSubview:localMusicTitLab];
    
    if (self.localMusicArr.count > 0) {
        __block XZMyLocalView *this = self;
        [self.localMusicArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            XZMusicInfo *musicInfo = (XZMusicInfo *)[self.localMusicArr objectAtIndex:idx];
            if (idx == 0) {
                this.localMusicNameStr = [NSMutableString stringWithFormat:@"%@",musicInfo.musicName];
                if (self.localMusicArr.count == 1) {
                    *stop = YES;
                }
            } else {
                [this.localMusicNameStr appendString:[NSString stringWithFormat:@",%@",musicInfo.musicName]];
            }
        }];
        
        localMusicTitLab.text = this.localMusicNameStr;
    }
}

- (void)btnClicked:(id)sender
{
    self.completedBlock(YES);
}

@end
