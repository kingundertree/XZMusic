//
//  XZSingerSongsCell.m
//  XZMusic
//
//  Created by xiazer on 14/11/9.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "XZSingerSongsCell.h"
#import "XZMusicSongModel.h"

@interface XZSingerSongsCell ()
@property(nonatomic, strong) UILabel *songNameLab;
@property(nonatomic, strong) UILabel *songInfoLab;
@property(nonatomic, strong) UILabel *songTimeLab;
@end

@implementation XZSingerSongsCell

- (UILabel *)songNameLab{
    if (!_songNameLab) {
        _songNameLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 10+3, ScreenWidth-45, 20)];
        _songNameLab.backgroundColor = [UIColor clearColor];
        _songNameLab.font = [UIFont xzH2Font_B];
        _songNameLab.textColor = [UIColor XZBlackColor];
    }
    return _songNameLab;
}

- (UILabel *)songInfoLab{
    if (!_songInfoLab) {
        _songInfoLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 10+20+15, ScreenWidth-80, 20)];
        _songInfoLab.backgroundColor = [UIColor clearColor];
        _songInfoLab.font = [UIFont xzH3Font];
        _songInfoLab.textColor = [UIColor XZMiddleGrayColor];
    }
    return _songInfoLab;
}

- (UILabel *)songTimeLab{
    if (!_songTimeLab) {
        _songTimeLab = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth-90, 30, 60, 20)];
        _songTimeLab.backgroundColor = [UIColor clearColor];
        _songTimeLab.textAlignment = NSTextAlignmentRight;
        _songTimeLab.font = [UIFont xzH3Font];
        _songTimeLab.textColor = [UIColor XZMiddleGrayColor];
    }
    return _songTimeLab;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}

- (void)initUI{
    [super initUI];
    
    [self.contentView addSubview:self.songNameLab];
    [self.contentView addSubview:self.songInfoLab];
    [self.contentView addSubview:self.songTimeLab];
}

- (void)configCell:(id)data{
    [super configCell:nil];
    
    if ([data isKindOfClass:[XZMusicSongModel class]]) {
        XZMusicSongModel *songModel = (XZMusicSongModel *)data;

        self.songNameLab.text = songModel.title;
        self.songInfoLab.text = [NSString stringWithFormat:@"%@•%@",songModel.author,songModel.album_title];
        self.songTimeLab.text = [self TimeformatFromSeconds:songModel.file_duration];
    }
}

-(NSString*)TimeformatFromSeconds:(int)seconds
{
    int totalm = seconds/(60);
    int h = totalm/(60);
    int m = totalm%(60);
    int s = seconds%(60);
    if (h==0) {
        return  [[NSString stringWithFormat:@"%02d:%02d", m, s] substringToIndex:5];
    }
    return [NSString stringWithFormat:@"%02d:%02d:%02d", h, m, s];
}



@end
