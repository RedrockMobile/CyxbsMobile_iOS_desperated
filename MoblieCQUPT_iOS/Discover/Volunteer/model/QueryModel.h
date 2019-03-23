//
//  QueryModel.h
//  MoblieCQUPT_iOS
//
//  Created by MaggieTang on 07/10/2017.
//  Copyright © 2017 Orange-W. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QueryModel : NSObject
@property (nonatomic, copy) NSString *start_time;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *hours;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, strong) NSArray *record;
- (instancetype)initWithDic:(NSDictionary *)dic;
-(void)volunteerTimes:(NSString *)uid;
-(void)volunteerBinding:(NSString *)account passwd:(NSString *)passwd uid:(NSString *)uid;
@end
