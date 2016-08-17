//
//  MBNewsModel.m
//  MoblieCQUPT_iOS
//
//  Created by GQuEen on 16/8/17.
//  Copyright © 2016年 Orange-W. All rights reserved.
//

#import "MBNewsModel.h"

@implementation MBNewsModel

- (instancetype)initWithDictionary:(NSDictionary *)dic withMBNewsShowType:(MBNewsShowType)showType {
    self = [super init];
    if (self) {
        
        _showType = showType;
        
        //type_id
        if ([dic containsObjectForKey:@"type_id"]) {
            self.type_id = dic[@"type_id"];
        }else if ([dic containsObjectForKey:@"articletype_id"]) {
            self.type_id = dic[@"articletype_id"];
        }
        
        
        //文章id
        if ([dic containsObjectForKey:@"article_id"]) {
            self.contentID = dic[@"article_id"] ?: @"";
        }else {
            self.contentID = dic[@"id"] ?: @"";
        }
        //昵称
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
        
        //发布时间
        self.date = dic[@"date"];
        //内容
        if ([dic[@"content"] isKindOfClass:[NSDictionary class]]) {
            self.content = [dic[@"content"] objectForKey:@"content"];
        }else {
            self.content = dic[@"content"];
        }
        //标题
        if ([dic[@"content"] isKindOfClass:[NSDictionary class]]) {
            self.title = [dic[@"content"] objectForKey:@"title"];
        }else {
            self.title = dic[@"title"];
        }
        
        //点赞 评论
        self.numOfLike = dic[@"like_num"] ?: @"";
        self.numOfRemark = dic[@"remark_num"] ?: @"";
        //是否我赞
        if ([dic containsObjectForKey:@"is_my_like"]) {
            self.isMyLike = dic[@"is_my_like"];
        }else if ([dic containsObjectForKey:@"is_my_Like"]) {
            self.isMyLike = dic[@"is_my_Like"];
        }
        
    }
    return self;
}

@end
