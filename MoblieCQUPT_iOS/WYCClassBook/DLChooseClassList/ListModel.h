//
//  ListModel.h
//  选课名单
//
//  Created by 丁磊 on 2018/9/19.
//  Copyright © 2018年 丁磊. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ListModel : NSObject
@property(nonatomic, copy)NSString *stuName;
@property(nonatomic, copy)NSString *major;
@property(nonatomic, copy)NSString *school;
@property(nonatomic, copy)NSString *classId;
@property(nonatomic, copy)NSString *stuSex;
@property(nonatomic, copy)NSString *stuNum;
@property(nonatomic, copy)NSString *year;
@property(nonatomic, assign)BOOL isShowMore;

- (instancetype)initWithDic:(NSDictionary*)dic;
+ (instancetype)ListModelWithDict:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
