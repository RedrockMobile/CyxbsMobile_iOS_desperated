//
//  draftsModel.m
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2018/6/8.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "draftsModel.h"

@implementation draftsModel
- (instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        self.cellID = dic[@"id"];
        self.type = dic[@"type"];
        self.create_time = [NSString stringWithFormat:@"时间：%@", dic[@"created_at"]];
        self.target_ID = dic[@"target_ID"];
        self.title_content = dic[@"title_content"];
        if ([_type isEqualToString:@"question"]) {
            NSDictionary *titleData = [self dictionaryWithJsonString:[self dencode:dic[@"content"]]];
            self.content = titleData[@"title"];
            self.titleType = titleData[@"kind"];
            self.titledescription = titleData[@"description"];
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

- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                    options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}
@end
