//
//  DLNecessityModel.m
//  MoblieCQUPT_iOS
//
//  Created by 丁磊 on 2018/8/13.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "DLNecessityModel.h"

@implementation DLNecessityModel

- (instancetype)initWithDic:(NSDictionary*)dic
{
    self = [super init];
    if (self) {
        self.necessity = dic[@"name"];
        self.detail = dic[@"content"];
        self.property = dic[@"property"];
        self.isShowMore = NO;
    }
    return self;
}

+ (instancetype)DLNecessityModelWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDic:dict];
}

@end
