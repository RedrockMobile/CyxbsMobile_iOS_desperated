//
//  draftsModel.h
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2018/6/8.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface draftsModel : NSObject
/*
    如果type为question时，content是一个base64编码的json字符串，有问题的题目，内容，类型。
 */
@property (strong, nonatomic) NSString *cellID;
@property (strong, nonatomic) NSString *content;
@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) NSString *create_time;
@property (strong, nonatomic) NSString *target_ID;
@property (strong, nonatomic) NSString *title_content;
@property (strong, nonatomic) NSString *titleType;
@property (strong, nonatomic) NSString *titledescription;
- (instancetype)initWithDic:(NSDictionary *)dic;
@end
