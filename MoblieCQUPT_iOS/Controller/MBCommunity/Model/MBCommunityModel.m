//
//  MBCommunityModel.m
//  MoblieCQUPT_iOS
//
//  Created by GQuEen on 16/4/6.
//  Copyright © 2016年 Orange-W. All rights reserved.
//

#import "MBCommunityModel.h"

@implementation MBCommunityModel

- (instancetype)initWithDictionary:(NSDictionary *)dic withMBCommunityModelType:(MBCommunityModelType)modelType{
    if (self = [super init]) {
        
        //type_id
        if ([dic containsObjectForKey:@"type_id"]) {
            self.typeID = dic[@"type_id"];
        }else if ([dic containsObjectForKey:@"articletype_id"]) {
            self.typeID = dic[@"articletype_id"];
        }
        
        //stuNum 学号
        if ([dic containsObjectForKey:@"stunum"]) {
            self.stuNum = dic[@"stunum"];
        }
        
        
        //文章id
        if ([dic containsObjectForKey:@"article_id"]) {
            self.articleID = dic[@"article_id"] ?: @"";
        }else {
            self.articleID = dic[@"id"] ?: @"";
        }
        //昵称
        if (modelType == MBCommunityModelTypeListNews || (![dic[@"type_id"] isEqualToString:@"5"] && ![dic[@"type_id"] isEqualToString:@"6"] )) {
            NSString *key;
            if ([dic containsObjectForKey:@"articletype_id"]) {
                key = @"articletype_id";
            }else if ([dic containsObjectForKey:@"type_id"]) {
               key = @"type_id";
            }
            if ([dic[key] isEqualToString:@"1"]) {
                self.IDLabel = @"重邮新闻";
            }else if ([dic[key] isEqualToString:@"2"]) {
                self.IDLabel = @"教务在线";
            }else if ([dic[key] isEqualToString:@"3"]) {
                self.IDLabel = @"学生咨询";
            }else if ([dic[key] isEqualToString:@"4"]) {
                self.IDLabel = @"校务公告";
            }
            
        }else {
            if ([dic containsObjectForKey:@"nickname"]) {
                if ([dic[@"nickname"] isEqualToString:@""]) {
                    self.IDLabel = @"这个人懒到没有填名字";
                }else {
                    self.IDLabel = dic[@"nickname"] ?: @"啥子都没得";
                }
                
            }else if ([dic containsObjectForKey:@"nick_name"]) {
                if ([dic[@"nick_name"] isEqualToString:@""]) {
                    self.IDLabel = @"这个人懒到没有填名字";
                }else {
                    self.IDLabel = dic[@"nick_name"] ?: @"啥子都没得";
                }
            }
        }
        
        //头像
        if ([dic containsObjectForKey:@"photo_src"] && ![dic[@"photo_src"] isEqualToString:@""]) {
            NSString *prefix = @"http://hongyan.cqupt.edu.cn/cyxbsMobile/Public/photo/";
            NSString *prefix1 = @"http://hongyan.cqupt.edu.cn/cyxbsMobile/Public/";
            if ([dic[@"photo_src"] hasPrefix:prefix] || [dic[@"photo_src"] hasPrefix:prefix1]) {
                self.headImageView = dic[@"photo_src"];
            }else {
                NSString *newURL = [prefix stringByAppendingString:dic[@"photo_src"]];
                self.headImageView = newURL;
            }
        }else if ([dic containsObjectForKey:@"user_head"] && ![dic[@"user_head"] isEqualToString:@""]) {
            NSString *prefix = @"http://hongyan.cqupt.edu.cn/cyxbsMobile/Public/photo/";
            NSString *prefix1 = @"http://hongyan.cqupt.edu.cn/cyxbsMobile/Public/";
            if ([dic[@"user_head"] hasPrefix:prefix] || [dic[@"user_head"] hasPrefix:prefix1]) {
                self.headImageView = dic[@"user_head"];
            }else {
                NSString *newURL = [prefix stringByAppendingString:dic[@"user_head"]];
                self.headImageView = newURL;
            }
        }
        
        //发布时间
        if (modelType == MBCommunityModelTypeListNews) {
            self.timeLabel = dic[@"date"];
        }else {
            if ([dic containsObjectForKey:@"created_time"]) {
                self.timeLabel = dic[@"created_time"] ?: @"2230-10-01 00:00:00";
            }else if ([dic containsObjectForKey:@"time"]) {
                self.timeLabel = dic[@"time"] ?: @"2230-10-01 00:00:00";
            }
        }
        
        
        //内容
        if (modelType == MBCommunityModelTypeListNews || (![dic[@"type_id"] isEqualToString:@"5"] && ![dic[@"type_id"] isEqualToString:@"6"] )) {
            if ([dic[@"content"] isKindOfClass:[NSDictionary class]]) {
                self.contentLabel = [dic[@"content"] objectForKey:@"title"];
            }else {
                self.contentLabel = dic[@"title"];
            }
        }else {
            if ([dic containsObjectForKey:@"content"]) {
                if ([dic[@"content"] isKindOfClass:[NSDictionary class]]) {
                    self.contentLabel = [dic[@"content"] objectForKey:@"content"];
                }else {
                    self.contentLabel = dic[@"content"];
                }
            }
        }
        
        //点赞数与评论数
        self.numOfSupport = dic[@"like_num"] ?: @"";
        self.numOfComment = dic[@"remark_num"] ?: @"";
        
        //我是否点赞
        if ([dic containsObjectForKey:@"is_my_like"]) {
            self.isMyLike = dic[@"is_my_like"];
        }else if ([dic containsObjectForKey:@"is_my_Like"]) {
            self.isMyLike = dic[@"is_my_Like"];
        }
        
        //内容图片
        
        _thumbnailPictureArray = [NSMutableArray array];
        _pictureArray = [NSMutableArray array];
        
        if ([dic containsObjectForKey:@"img"] && ![dic[@"img"][@"img_small_src"] isEqualToString:@""]) {
            NSString *prefix = @"http://hongyan.cqupt.edu.cn/cyxbsMobile/Public/photo/thumbnail/";
            NSArray *pic = [dic[@"img"][@"img_small_src"] componentsSeparatedByString:@","];
            [pic enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (idx >= 9) {
                    return;
                }
                if (![pic[idx] isEqualToString:@""]) {
                    if ([pic[idx] hasPrefix:prefix]) {
                        [self.thumbnailPictureArray addObject:pic[idx]];
                    }else {
                        NSString *newURL = [prefix stringByAppendingString:pic[idx]];
                        [self.thumbnailPictureArray addObject:newURL];
                    }
                }
            }];
        }else if ([dic containsObjectForKey:@"article_thumbnail_src"] && ![dic[@"article_thumbnail_src"] isEqualToString:@""]) {
            NSString *prefix = @"http://hongyan.cqupt.edu.cn/cyxbsMobile/Public/photo/thumbnail/";
            NSArray *pic = [dic[@"article_thumbnail_src"] componentsSeparatedByString:@","];
            [pic enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (idx >= 9) {
                    return;
                }
                if (![pic[idx] isEqualToString:@""]) {
                    if ([pic[idx] hasPrefix:prefix]) {
                        [self.thumbnailPictureArray addObject:pic[idx]];
                    }else {
                        NSString *newURL = [prefix stringByAppendingString:pic[idx]];
                        [self.thumbnailPictureArray addObject:newURL];
                    }
                }
            }];
        }
        if ([dic containsObjectForKey:@"img"] && ![dic[@"img"][@"img_src"] isEqualToString:@""]) {
            NSString *prefix = @"http://hongyan.cqupt.edu.cn/cyxbsMobile/Public/photo/";
            NSArray *pic = [dic[@"img"][@"img_src"] componentsSeparatedByString:@","];
            [pic enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (idx >= 9) {
                    return;
                }
                if (![pic[idx] isEqualToString:@""]) {
                    if ([pic[idx] hasPrefix:prefix]) {
                        [self.pictureArray addObject:pic[idx]];
                    }else {
                        NSString *newURL = [prefix stringByAppendingString:pic[idx]];
                        [self.pictureArray addObject:newURL];
                    }
                }
            }];
        }else if ([dic containsObjectForKey:@"article_photo_src"] && ![dic[@"article_photo_src"] isEqualToString:@""]) {
            NSString *prefix = @"http://hongyan.cqupt.edu.cn/cyxbsMobile/Public/photo/";
            NSArray *pic = [dic[@"article_photo_src"] componentsSeparatedByString:@","];
            [pic enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (idx >= 9) {
                    return;
                }
                if (![pic[idx] isEqualToString:@""]) {
                    if ([pic[idx] hasPrefix:prefix]) {
                        [self.pictureArray addObject:pic[idx]];
                    }else {
                        NSString *newURL = [prefix stringByAppendingString:pic[idx]];
                        [self.pictureArray addObject:newURL];
                    }
                }
            }];
        }
        
    }
    return self;
}

- (NSString *)description {
    NSString *result = @"";
    result = [result stringByAppendingFormat:@"typeID : %@\n",self.typeID];
    result = [result stringByAppendingFormat:@"articleID : %@\n",self.articleID];
    result = [result stringByAppendingFormat:@"stuNum : %@\n",self.stuNum];
    result = [result stringByAppendingFormat:@"headImageView : %@\n",self.headImageView];
    result = [result stringByAppendingFormat:@"IDLabel : %@\n",self.IDLabel];
    result = [result stringByAppendingFormat:@"timeLabel : %@\n",self.timeLabel];
    result = [result stringByAppendingFormat:@"contentLabel : %@\n",self.contentLabel];
    result = [result stringByAppendingFormat:@"pictureArray : %@\n",self.pictureArray];
    result = [result stringByAppendingFormat:@"comprssPictureArray : %@\n",self.thumbnailPictureArray];
    result = [result stringByAppendingFormat:@"numOfSupport : %@\n",self.numOfSupport];
    result = [result stringByAppendingFormat:@"numOfComment : %@\n",self.numOfComment];
    result = [result stringByAppendingFormat:@"isMyLike : %@\n",self.isMyLike];
    return result;
}

@end
