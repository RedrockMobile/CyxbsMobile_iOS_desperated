//
//  ExpressCompanyItem.h
//  MoblieCQUPT_iOS
//
//  Created by 千千 on 2019/8/17.
//  Copyright © 2019 Orange-W. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ExpressSpotItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface ExpressCompanyItem : NSObject

@property (nonatomic, copy) NSString *companyName;
@property (nonatomic, copy) NSArray<ExpressSpotItem *> *spotsArray;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)companyWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
