//
//  LXAskDetailModel.h
//  MoblieCQUPT_iOS
//
//  Created by helloworld on 2018/5/30.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXAskDetailModel : NSObject

@property (copy, nonatomic) NSString *quesStr;
@property (copy, nonatomic) NSString *ansStr;
@property (copy, nonatomic) NSString *solveTimeStr;
@property (copy, nonatomic) NSString *disapperTimeStr;
@property (copy, nonatomic) NSString *quesID;

- (instancetype) initWithDic:(NSDictionary *)dic;

@end
