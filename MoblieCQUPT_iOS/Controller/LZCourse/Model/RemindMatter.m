//
//  RemindMatter.m
//  Demo
//
//  Created by 李展 on 2016/11/17.
//  Copyright © 2016年 zhanlee. All rights reserved.
//

#import "RemindMatter.h"

@implementation RemindMatter
- (instancetype)initWithRemind:(NSDictionary *)remind{
    self = [self init];
    if (self) {
        self.idNum = [remind objectForKey:@"id"];
    }
    return self;
}
@end
