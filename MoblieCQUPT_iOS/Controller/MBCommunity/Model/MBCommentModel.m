//
//  MBCommentModel.m
//  MoblieCQUPT_iOS
//
//  Created by GQuEen on 16/4/25.
//  Copyright © 2016年 Orange-W. All rights reserved.
//

#import "MBCommentModel.h"

@implementation MBCommentModel


- (instancetype)initWithDictionary:(NSDictionary *)dic {

    if (self = [super init]) {
        //昵称
        if ([dic containsObjectForKey:@"nickname"]) {
            if ([dic[@"nickname"] isEqualToString:@""]) {
                self.IDLabel = @"这个人懒到没有填名字";
            }else {
                self.IDLabel = dic[@"nickname"] ?: @"啥子都没得";
            }
            
        }else if ([dic containsObjectForKey:@"nick_name"]) {
            if ([dic[@"nickname"] isEqualToString:@""]) {
                self.IDLabel = @"这个人懒到没有填名字";
            }else {
                self.IDLabel = dic[@"nickname"] ?: @"啥子都没得";
            }
        }
        //头像
        if ([dic containsObjectForKey:@"photo_src"] && ![dic[@"photo_src"] isEqualToString:@""]) {
            NSString *prefix = @"http://hongyan.cqupt.edu.cn/cyxbsMobile/Public/photo/";
            if ([dic[@"photo_src"] hasPrefix:prefix]) {
                self.headImageView = dic[@"photo_src"];
            }else {
                NSString *newURL = [prefix stringByAppendingString:dic[@"photo_src"]];
                self.headImageView = newURL;
            }
        }
        
        //发布时间
        if ([dic containsObjectForKey:@"created_time"]) {
            self.timeLabel = dic[@"created_time"] ?: @"2230-10-01 00:00:00";
        }else if ([dic containsObjectForKey:@"time"]) {
            self.timeLabel = dic[@"time"] ?: @"2230-10-01 00:00:00";
        }
        
        //内容
        if ([dic containsObjectForKey:@"content"]) {
            if ([dic[@"content"] isKindOfClass:[NSDictionary class]]) {
                self.contentLabel = [dic[@"content"] objectForKey:@"content"];
            }else {
                self.contentLabel = dic[@"content"];
            }
        }
    }
    
    return self;
}

- (NSString *)description {
    NSString *result = @"";
    result = [result stringByAppendingFormat:@"headImageView : %@\n",self.headImageView];
    result = [result stringByAppendingFormat:@"IDLabel : %@\n",self.IDLabel];
    result = [result stringByAppendingFormat:@"timeLabel : %@\n",self.timeLabel];
    result = [result stringByAppendingFormat:@"contentLabel : %@\n",self.contentLabel];
    return result;
}

@end
