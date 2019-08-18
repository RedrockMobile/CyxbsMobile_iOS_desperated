//
//  Model.m
//  MoblieCQUPT_iOS
//
//  Created by 汪明天 on 2019/8/9.
//  Copyright © 2019 Orange-W. All rights reserved.
//

#import "Model.h"

@implementation Model
-(instancetype)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.necessity = dic[@"name"];
        self.detail = dic[@"detail"];
        self.property = dic[@"property"];
//        self.property = nil;
        self.isShowMore = NO;
        self.isShowMoreBtn = YES;
        
    }
    return self;
}

+(instancetype)modelWithDictionary:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}
@end
