//
//  YouWenDetailModel.h
//  MoblieCQUPT_iOS
//
//  Created by helloworld on 2018/3/9.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YouWenQuestionDetailModel : NSObject

@property (nonatomic, copy) NSString *isSelf;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *descriptionStr;
@property (nonatomic, copy) NSString *nickName;
@property (nonatomic, copy) NSString *disappearTime;
@property (nonatomic, copy) NSString *reward;
@property (nonatomic, strong) NSMutableArray *picArr;
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *gender;
@property (nonatomic, copy) NSString *questionID;


- (instancetype)initWithDic:(NSDictionary *)dic;

@end
