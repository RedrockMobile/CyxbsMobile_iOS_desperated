//
//  ExpressCompanyItem.m
//  MoblieCQUPT_iOS
//
//  Created by 千千 on 2019/8/17.
//  Copyright © 2019 Orange-W. All rights reserved.
//

#import "ExpressCompanyItem.h"

@implementation ExpressCompanyItem

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        self.companyName = dict[@"name"];
        
        NSMutableArray *tempArray = [NSMutableArray array];
        for (NSDictionary *spotsDict in dict[@"message"]) {
            ExpressSpotItem *spot = [ExpressSpotItem spotWithDict:spotsDict];
            [tempArray addObject:spot];
        }
        self.spotsArray = tempArray;
    }
    return self;
}

+ (instancetype)companyWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

@end
