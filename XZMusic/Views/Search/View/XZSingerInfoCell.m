//
//  XZSingerInfoCell.m
//  XZMusic
//
//  Created by xiazer on 14/11/8.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "XZSingerInfoCell.h"
#import "XZMusicSingerModel.h"
#import <QuartzCore/QuartzCore.h>

@interface XZSingerInfoCell ()
@property(nonatomic, strong) UIImageView *singerImageView;
@property(nonatomic, strong) UILabel *singerNameLab;
@property(nonatomic, strong) UILabel *singerComLab;
@end

@implementation XZSingerInfoCell

- (UIImageView *)singerImageView{
    if (!_singerImageView) {
        _singerImageView  = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 60, 60)];
        _singerImageView.layer.masksToBounds = YES;
        _singerImageView.layer.cornerRadius = 30;
    }
    return _singerImageView;
}

- (UILabel *)singerNameLab{
    if (!_singerNameLab) {
        _singerNameLab = [[UILabel alloc] initWithFrame:CGRectMake(80, 10+3, 150, 20)];
        _singerNameLab.backgroundColor = [UIColor clearColor];
        _singerNameLab.font = [UIFont xzH2Font_B];
        _singerNameLab.textColor = [UIColor XZBlackColor];
    }
    return _singerNameLab;
}

- (UILabel *)singerComLab{
    if (!_singerComLab) {
        _singerComLab = [[UILabel alloc] initWithFrame:CGRectMake(80, 10+25+10, ScreenWidth-80-20, 20)];
        _singerComLab.backgroundColor = [UIColor clearColor];
        _singerComLab.font = [UIFont xzH3Font];
        _singerComLab.textColor = [UIColor XZMiddleGrayColor];
    }
    return _singerComLab;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    
    }
    return self;
}

- (void)initUI{
    [super initUI];
    
    [self.contentView addSubview:self.singerImageView];
    [self.contentView addSubview:self.singerNameLab];
    [self.contentView addSubview:self.singerComLab];
}

- (void)configCell:(id)data{
    [super configCell:nil];
    
    if ([data isKindOfClass:[XZMusicSingerModel class]]) {
        XZMusicSingerModel *singerInfoModel = (XZMusicSingerModel *)data;
        NSURL *singerUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@",singerInfoModel.avatar_big]];
        
        [self.singerImageView setImageWithURL:singerUrl placeholderImage:[UIImage createImageWithColor:[UIColor XZLightGrayColor]]];
        self.singerNameLab.text = singerInfoModel.name;
        self.singerComLab.text = singerInfoModel.company;
    }
}


@end
