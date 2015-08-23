//
//  DataBundle.m
//  ConsultingTest
//
//  Created by RainyTunes on 8/22/15.
//  Copyright (c) 2015 RainyTunes. All rights reserved.
//

#import "DataBundle.h"
#import "We.h"
#import "TableViewController.h"
#import "MainViewController.h"
#import "ViewController.h"

@implementation DataBundle

+ (NSMutableDictionary *)paramWithStuNum:(NSString *)stuNum IdNum:(NSString *)idNum {
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setValue:stuNum forKey:@"stuNum"];
    [param setValue:stuNum forKey:@"stu"];
    [param setValue:idNum forKey:@"idNum"];
    return param;
}

+ (NSMutableDictionary *)paramWithWeekdayNum:(NSString *)weekdayNum
                                  SectionNum:(NSString *)sectionNum
                                    BuildNum:(NSString *)buildNum
                                        Week:(NSString *)week {
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setValue:weekdayNum forKey:@"weekdayNum"];
    [param setValue:sectionNum forKey:@"sectionNum"];
    [param setValue:buildNum forKey:@"buildNum"];
    [param setValue:week forKey:@"week"];
    return param;
}

- (instancetype)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        _manager  = [AFHTTPRequestOperationManager manager];
        _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        _dicWithParam = dic;
    }
    return self;
}

- (void)httpPost:(NSString *)typeStr
{
    [_manager POST:typeStr parameters:_dicWithParam success:^(AFHTTPRequestOperation *operation, id responseObject) {
        _json = [[self fetchDataWithSafe:responseObject] mutableCopy];
        if(_json)
        {
            [self toShowResult:typeStr];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [_mainDelegate showAlert:@"您的网络是不是跪了，如果不是那就是我跪了qwq"];
    }];
}

- (void)toShowResult:(NSString *)type{
    [_json setObject:type forKey:@"type"];
    TableViewController *viewController = [[TableViewController alloc]init];
    //[_delegate.navigationController pushViewController:viewController animated:YES];
    viewController.delegate = self;
    [_mainDelegate presentViewController:viewController animated:YES completion:nil];
}

- (NSDictionary *)fetchDataWithSafe:(id)responseObject
{
    NSDictionary *json = [We getDictionaryWithHexData:responseObject];
    NSInteger status = [json[@"status"] integerValue];
    if ([json[@"info"] isEqualToString:@"student id error"]) {
        status = 999;
    }
    if (status == 200) {
        return json;
    }else{
        [_mainDelegate showAlert:[self errInfo:status]];
        return nil;
    }
}

- (NSString *)errInfo:(NSInteger)status
{
    NSMutableString *results = [[NSMutableString alloc]init];
    switch (status) {
        case 0:
            [results appendString:@"您没有补考哟"];
            break;
        case 201:
            [results appendString:@"您输入的学号或密码好像有误呀"];
            break;
        case 300:
            [results appendString:@"教务在线好像还未公布本次考试结果哎"];
            break;
        case 999:
            [results appendString:@"您输入的学号好像不存在啊"];
            break;
        case 998:
            [results appendString:@"您所查询的内容好像查不到呐"];
            break;
        case -1:
            [results appendString:@"内部错误，请及时报告网校人员"];
            break;
        case -10:
            [results appendString:@"教务在线返回的数据不合常理，请及时报告网校人员"];
            break;
        case -20:
            [results appendString:@"传入的参数不合法，请及时报告网校人员"];
            break;
        default:
            [results appendString:@"好像发生了未知错误啦"];
            break;
    }
    return results;
}
@end
