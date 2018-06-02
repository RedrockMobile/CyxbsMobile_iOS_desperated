//
//  LXAskDetailModel.h
//  MoblieCQUPT_iOS
//
//  Created by helloworld on 2018/5/30.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXAskDetailModel : NSObject

/*..
 .有时间改成这种
 .@property (copy, nonatomic) NSString *title;
 .@property (copy, nonatomic) NSString *content;
 .
 .
 */
@property (copy, nonatomic) NSString *askQuesStr;
@property (copy, nonatomic) NSString *ansStr;
@property (copy, nonatomic) NSString *createdTimeStr;
@property (copy, nonatomic) NSString *disapperTimeStr;
@property (copy, nonatomic) NSString *updatedTimeStr;
@property (copy, nonatomic) NSString *helpContent;
@property (copy, nonatomic) NSString *helptitle;
@property (copy, nonatomic) NSString *quesID;

- (instancetype) initWithDic:(NSDictionary *)dic;

@end
