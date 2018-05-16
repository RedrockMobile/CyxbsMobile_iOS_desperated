//
//  YouWenAnswerDetailModel.h
//  MoblieCQUPT_iOS
//
//  Created by helloworld on 2018/3/20.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YouWenAnswerDetailModel : NSObject

@property (copy, nonatomic)  NSString *avatarUrl;
@property (copy, nonatomic)  NSString *nickname;
@property (copy, nonatomic)  NSString *content;
@property (strong, nonatomic)  NSMutableArray *photoUrlArr;
@property (copy, nonatomic)  NSString *timeStr;
@property (copy, nonatomic)  NSString *commentNum;
@property (copy, nonatomic)  NSString *upvoteNum;
@property (copy, nonatomic)  NSString *gender;
@property (copy, nonatomic) NSString *answer_id;
@property int is_adopted;
- (instancetype) initWithDic:(NSDictionary *)dic;

@end
