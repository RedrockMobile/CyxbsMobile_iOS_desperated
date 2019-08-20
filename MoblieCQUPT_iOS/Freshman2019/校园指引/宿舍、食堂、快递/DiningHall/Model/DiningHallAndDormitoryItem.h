//
//  DiningHallItem.h
//  MoblieCQUPT_iOS
//
//  Created by 方昱恒 on 2019/8/18.
//  Copyright © 2019 Orange-W. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DiningHallAndDormitoryItem : NSObject

@property (nonatomic, copy) NSString *name;         // 食堂/宿舍名称
@property (nonatomic, copy) NSString *detail;       // 食堂/宿舍介绍
@property (nonatomic, copy) NSArray<NSString *> *rollImageURL;  // 轮播图url

@property (nonatomic, assign) CGRect rollImageFrame;
@property (nonatomic, assign) CGRect titleLabelFrame;
@property (nonatomic, assign) CGRect detailLabelFrame;
@property (nonatomic, assign) CGRect backgroundFrame;

@property (nonatomic, assign) CGFloat cellHeight;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)diningHallWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
