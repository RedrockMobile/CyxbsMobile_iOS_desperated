//
//  YouWenDataModel.m
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2018/2/24.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "YouWenDataModel.h"
#define URL @"https://wx.idsbllp.cn/springtest/cyxbsMobile/index.php/QA/Question/getQuestionList"
#import "NSString+Emoji.h"

@interface YouWenDataModel()
@property (strong, nonatomic) NSMutableDictionary *YWPostDic;
@property (strong, nonatomic) NSString *modelStyle;
@end
@implementation YouWenDataModel
/*
    分页页码.0,1为第一页,不填默认为第一页
    每页问题数,可以不填,不填为6个
    填写大的类型,学习/情感/其他
 */
- (instancetype)initWithStyle:(NSString *)style{
    if (self = [super init]) {
        _YWPostDic = @{
                       @"page":@"0",
                       @"size":@"6",
                       @"kind":style
                       }.mutableCopy;
        _modelStyle = [[NSString alloc] initWithString:style];
    }
    return self;
}
- (void)newPage:(NSString *)page{
    _YWPostDic[@"page"] = page;
    [self networking];
}
- (void)newYWDate{
    _YWPostDic[@"page"] = @"0";
    [self networking];
}
- (void)networking{
    HttpClient *client = [HttpClient defaultClient];
    [client requestWithPath:URL method:HttpRequestPost parameters:_YWPostDic prepareExecute:nil progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        _YWdataArray = [self changeAllArray: responseObject[@"data"]];
        NSNotification *notification;
        if (_YWdataArray.count) {
            notification =[NSNotification notificationWithName:[NSString stringWithFormat: @"%@DataLoading", _modelStyle] object:nil userInfo:@{@"state":@"YES"}];
        }
        else {
            notification =[NSNotification notificationWithName:[NSString stringWithFormat: @"%@DataLoading", _modelStyle] object:nil userInfo:@{@"state":@"NO"}];
        }
        [[NSNotificationCenter defaultCenter] postNotification:notification ];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSNotification *notification =[NSNotification notificationWithName:[NSString stringWithFormat: @"%@DataLoading", _modelStyle] object:nil userInfo:@{@"state":@"FAIL"}];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
    }];
}

- (NSArray *)changeAllArray:(NSArray *)array{
    NSMutableArray *endArray = [NSMutableArray array];
    for (int i = 0; i < array.count; i ++ ) {
        NSDictionary *dd = array[i];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:dd];
        dic[@"title"] = [dic[@"title"] stringByReplacingEmojiCheatCodesWithUnicode];
        dic[@"description"] = [dic[@"description"] stringByReplacingEmojiCheatCodesWithUnicode];
        [endArray addObject:dic];
    }
    return endArray.copy;
}
@end
