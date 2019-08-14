//
//  ActivityItem.m
//  CQUPT_Mobile
//
//  Created by 方昱恒 on 2019/8/6.
//  Copyright © 2019 方昱恒. All rights reserved.
//

#import "ActivityItem.h"

@implementation ActivityItem

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        self.name = dict[@"name"];
        self.photo = dict[@"photo"];
        self.message = dict[@"message"];
        self.QRCode = dict[@"QR"];
    }
    return self;
}

@end
