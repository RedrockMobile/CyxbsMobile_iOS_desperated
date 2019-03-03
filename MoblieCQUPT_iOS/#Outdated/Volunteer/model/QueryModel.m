//
//  QueryModel.m
//  MoblieCQUPT_iOS
//
//  Created by MaggieTang on 07/10/2017.
//  Copyright © 2017 Orange-W. All rights reserved.
//

#import "QueryModel.h"

@implementation QueryModel
- (instancetype)initWithDic:(NSDictionary *)dic{
    self = [self init];
    if (self) {
        self.start_time = dic[@"start_time"];
        self.content = dic [@"content"];
        self.address = dic [@"address"];

        self.hours = dic [@"hours"];
        if ([self.hours.class isSubclassOfClass:[NSNumber class]] ) {
            self.hours = [(NSNumber *)self.hours stringValue];
        }
    }
    return self;
}
@end
