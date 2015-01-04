//
//  XZSingerSongsCell.h
//  XZMusic
//
//  Created by xiazer on 14/11/9.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "XZBaseTableViewCell.h"

typedef NS_ENUM(NSInteger, CellType){
    CellTypeForNormal = 1,
    CellTypeForDowning = 2,
    CellTypeForLoving = 3,
    CellTypeForHeared = 4
};

@interface XZSongCell : XZBaseTableViewCell
@property (nonatomic, assign) CellType cellType;
@end
