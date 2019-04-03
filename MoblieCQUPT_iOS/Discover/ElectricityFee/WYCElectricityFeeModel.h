//
//  WYCElectricityFeeModel.h
//  MoblieCQUPT_iOS
//
//  Created by 王一成 on 2019/4/2.
//  Copyright © 2019年 Orange-W. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WYCElectricityFeeModel : NSObject
@property (nonatomic, copy)NSString *elec_spend;
@property (nonatomic, copy)NSString *elec_cost;
@property (nonatomic, copy)NSString *elec_start;
@property (nonatomic, copy)NSString *elec_end;
@property (nonatomic, copy)NSString *elec_free;
@property (nonatomic, copy)NSString *elec_month;
@property (nonatomic, copy)NSString *record_time;
@property (nonatomic, copy)NSString *lastmoney;
@property (nonatomic, copy)NSString *averag;
@property (nonatomic, strong)NSArray *dataArray;

- (void)getFeeData:(NSString *)buildingNum RoomNum:(NSString *)roomNum;
@end

NS_ASSUME_NONNULL_END
