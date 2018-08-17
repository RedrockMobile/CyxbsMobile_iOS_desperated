//
//  BusModel.h
//  MoblieCQUPT_iOS
//
//  Created by 丁磊 on 2018/8/14.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BusModel : NSObject


@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *content;
@property (nonatomic, copy)NSMutableArray *imgArray;
@property (nonatomic, copy)NSArray *arr;

- (instancetype)initWithDic:(NSDictionary*)dic;
+ (instancetype)BusAndDeleModelWithDict:(NSDictionary *)dict;


@end
