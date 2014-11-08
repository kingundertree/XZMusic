//
//  XZSingerSongsInfoConvertOb.m
//  XZMusic
//
//  Created by xiazer on 14/11/8.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "XZSingerSongsInfoConvertOb.h"

@implementation XZSingerSongsInfoConvertOb

+ (NSMutableArray *)converSongsListToArr:(NSArray *)songs{
    if (songs && songs.count > 0) {
        NSMutableArray *songsArr = [NSMutableArray array];
        for (NSDictionary * dict in songs) {
            XZMusicSongModel *model = [XZMusicSongModel new];
            
            model.artist_id = [[dict objectForKey:@"artist_id"] intValue];
            model.all_artist_ting_uid = [[dict objectForKey:@"all_artist_ting_uid"] intValue];
            model.all_artist_id = [[dict objectForKey:@"all_artist_id"] intValue];
            model.language = [dict objectForKey:@"language"];
            model.publishtime = [dict objectForKey:@"publishtime"];
            model.album_no = [[dict objectForKey:@"album_no"] intValue];
            model.pic_big = [dict objectForKey:@"pic_big"];
            model.pic_small = [dict objectForKey:@"pic_small"];
            model.country = [dict objectForKey:@"country"];
            model.area = [[dict objectForKey:@"area"] intValue];
            model.lrclink = [dict objectForKey:@"lrclink"];
            model.hot = [[dict objectForKey:@"hot"] intValue];
            model.file_duration = [[dict objectForKey:@"file_duration"] intValue];
            model.del_status = [[dict objectForKey:@"del_status"] intValue];
            model.resource_type = [[dict objectForKey:@"resource_type"] intValue];
            model.copy_type = [[dict objectForKey:@"copy_type"] intValue];
            model.relate_status = [[dict objectForKey:@"relate_status"] intValue];
            model.all_rate = [[dict objectForKey:@"all_rate"] intValue];
            model.has_mv_mobile = [[dict objectForKey:@"has_mv_mobile"] intValue];
            model.toneid = [[dict objectForKey:@"toneid"] longLongValue];
            model.song_id = [[dict objectForKey:@"song_id"] longLongValue];
            model.title = [dict objectForKey:@"title"];
            model.ting_uid = [[dict objectForKey:@"ting_uid"] longLongValue];
            model.author = [dict objectForKey:@"author"];
            model.album_id = [[dict objectForKey:@"album_id"] longLongValue];
            model.album_title = [dict objectForKey:@"album_title"];
            model.is_first_publish = [[dict objectForKey:@"is_first_publish"] intValue];
            model.havehigh = [[dict objectForKey:@"havehigh"] intValue];
            model.charge = [[dict objectForKey:@"charge"] intValue];
            model.has_mv = [[dict objectForKey:@"has_mv"] intValue];
            model.learn = [[dict objectForKey:@"learn"] intValue];
            model.piao_id = [[dict objectForKey:@"piao_id"] intValue];
            model.listen_total = [[dict objectForKey:@"listen_total"] longLongValue];
            
            [songsArr addObject:model];
        }
        return songsArr;
    }else{
        return nil;
    }
}

@end
