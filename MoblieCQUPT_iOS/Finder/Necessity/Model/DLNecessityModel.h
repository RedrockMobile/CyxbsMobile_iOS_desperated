//
//  DLNecessityModel.h
//  MoblieCQUPT_iOS
//
//  Created by 丁磊 on 2018/8/13.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DLNecessityModel : NSObject


@property (nonatomic, copy)NSString *necessity;
@property (nonatomic, copy)NSString *detail;
@property (nonatomic, copy)NSString *property;
@property (nonatomic, assign)BOOL isShowMore;
@property (nonatomic, assign)BOOL isReady;
@property (nonatomic, assign)BOOL isSelected;

- (instancetype)initWithDic:(NSDictionary*)dic;
+ (instancetype)DLNecessityModelWithDict:(NSDictionary *)dict;


@end
