//
//  AnswerCommentModel.h
//  MoblieCQUPT_iOS
//
//  Created by helloworld on 2018/4/5.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AnswerCommentModel : NSObject

@property (nonatomic, strong) NSString *avatarUrlStr;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *gender;

- (instancetype)initWithDic:(NSDictionary *)dic;
@end
