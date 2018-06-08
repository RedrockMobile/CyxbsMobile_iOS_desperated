//
//  draftsModel.m
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2018/6/8.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "draftsModel.h"
#define URL @"https://wx.idsbllp.cn/springtest/cyxbsMobile/index.php/QA/User/getDraftList"
@implementation draftsModel
- (instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        self.cellID = dic[@"id"];
        self.type = dic[@"type"];
        self.create_time = dic[@"created_at"];
        self.target_ID = dic[@"target_ID"];
        self.title_content = dic[@"title_content"];
        if ([_type isEqualToString:@"question"]) {
            self.content = [self dencode:dic[@"content"]];
        }
        else{
            self.content = dic[@"content"];
        }
        
    }
    
    return self;
}

- (NSString *)dencode:(NSString *)base64String
{
    NSData *data = [[NSData alloc]initWithBase64EncodedString:base64String options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    NSString *string = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
    return string;
}

@end
