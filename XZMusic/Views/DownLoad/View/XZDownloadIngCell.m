//
//  XZDownloadIngCell.m
//  XZMusic
//
//  Created by xiazer on 14/12/23.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "XZDownloadIngCell.h"

@interface XZDownloadIngCell ()
@property(nonatomic, strong) UILabel *songNameLab;
@property(nonatomic, strong) UILabel *songInfoLab;
@property(nonatomic, strong) UILabel *songTimeLab;
@property(nonatomic, strong) UILabel *downStatusLab;
@end

@implementation XZDownloadIngCell

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
        _songTimeLab = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth-90, 10, 60, 20)];
        _songTimeLab.backgroundColor = [UIColor clearColor];
        _songTimeLab.textAlignment = NSTextAlignmentRight;
        _songTimeLab.font = [UIFont xzH3Font];
        _songTimeLab.textColor = [UIColor XZMiddleGrayColor];
    }
    return _songTimeLab;
}

- (UILabel *)downStatusLab{
    if (!_downStatusLab) {
        _downStatusLab = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth-130, 40, 100, 20)];
        _downStatusLab.backgroundColor = [UIColor clearColor];
        _downStatusLab.textAlignment = NSTextAlignmentRight;
        _downStatusLab.font = [UIFont xzH3Font];
        _downStatusLab.textColor = [UIColor XZMiddleGrayColor];
    }
    return _downStatusLab;
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
    [self.contentView addSubview:self.downStatusLab];
}

- (void)configCell:(id)data{
    [super configCell:nil];
    
    if ([data isKindOfClass:[XZMusicInfo class]]) {
        XZMusicInfo *musicInfo = (XZMusicInfo *)data;
        
        self.songNameLab.text = musicInfo.musicName;
        self.songInfoLab.text = [NSString stringWithFormat:@"%@•%@",musicInfo.musicSonger,musicInfo.musicAlbum];
        self.songTimeLab.text = [self TimeformatFromSeconds:[musicInfo.musicTime intValue]];

        if (musicInfo.downProgress == -2.0) {
            // 网络错误
            self.downStatusLab.text = @"网络错误";
        } else if (musicInfo.downProgress == -1.0) {
            // 下载失败
            self.downStatusLab.text = @"下载失败";
        } else if (musicInfo.downProgress == 1.0) {
            // 下载成功
            self.downStatusLab.text = @"下载成功";
        } else if (musicInfo.downProgress >= 0 && musicInfo.downProgress < 1.0) {
            // 下载中
            self.downStatusLab.text = [NSString stringWithFormat:@"%.2f%@",musicInfo.downProgress*100,@"%"];
        }
    }
}

- (void)updateDownProgress:(id)data
{
    if ([data isKindOfClass:[XZMusicInfo class]]) {
        XZMusicInfo *musicInfo = (XZMusicInfo *)data;
        
        if (musicInfo.downProgress == -2.0) {
            // 网络错误
            self.downStatusLab.text = @"网络错误";
        } else if (musicInfo.downProgress == -1.0) {
            // 下载失败
            self.downStatusLab.text = @"下载失败";
        } else if (musicInfo.downProgress == 1.0) {
            // 下载成功
            self.downStatusLab.text = @"下载成功";
        } else if (musicInfo.downProgress >= 0 && musicInfo.downProgress < 1.0) {
            // 下载中
            self.downStatusLab.text = [NSString stringWithFormat:@"%.2f%@",musicInfo.downProgress*100,@"%"];
        }
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
