//
//  FoodAroundModel.h
//  MoblieCQUPT_iOS
//
//  Created by 陈大炮 on 2018/8/26.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FoodAroundModel : NSObject

@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *content;
@property (nonatomic, copy)NSMutableArray *imgArray;
@property (nonatomic, copy)NSArray *arr;
@property (nonatomic, strong)NSString *price;
@property (nonatomic, copy)NSString *rank;

- (instancetype)initWithDic:(NSDictionary*)dic;
+ (instancetype)BusAndDeleModelWithDict:(NSDictionary *)dict;

@end
