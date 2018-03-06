//
//  QuerLoginModel.h
//  Query
//
//  Created by hzl on 2017/3/1.
//  Copyright © 2017年 c. All rights reserved.
//

#import <Foundation/Foundation.h>

@class QuerCircleView;

@interface QuerLoginModel : NSObject

@property (nonatomic, strong) void(^saveBlock)(NSDictionary *);

- (void)RequestWithBuildingNum:(NSString *)buildingNum RoomNum:(NSString *)roomNum;

@end
