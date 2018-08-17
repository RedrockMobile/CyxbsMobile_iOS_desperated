//
//  FoodModel.h
//  迎新
//
//  Created by 陈大炮 on 2018/8/15.
//  Copyright © 2018年 陈大炮. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FoodModel : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *pictureURL;
@property (nonatomic, copy) NSString *illstrate;

- (instancetype)initWithDic:(NSDictionary *)dic;
@end
