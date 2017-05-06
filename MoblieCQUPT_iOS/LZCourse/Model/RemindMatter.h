//
//  RemindMatter.h
//  Demo
//
//  Created by 李展 on 2016/11/17.
//  Copyright © 2016年 zhanlee. All rights reserved.
//

#import "BaseMatter.h"
@interface RemindMatter : BaseMatter
@property NSNumber *idNum;
@property NSNumber *day;
@property NSNumber *classNum;
@property NSArray *week;
@property NSString *content;
@property NSString *title;
- (instancetype)initWithRemind:(NSDictionary *)remind;
@end
