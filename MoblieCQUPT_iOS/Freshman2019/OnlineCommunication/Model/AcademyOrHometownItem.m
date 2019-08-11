//
//  AcademyItem.m
//  CQUPT_Mobile
//
//  Created by 方昱恒 on 2019/8/2.
//  Copyright © 2019 方昱恒. All rights reserved.
//

#import "AcademyOrHometownItem.h"

@implementation AcademyOrHometownItem

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [self init]) {
        self.name = dict[@"name"];
        self.data = dict[@"data"];
    }
    return self;
}

@end
