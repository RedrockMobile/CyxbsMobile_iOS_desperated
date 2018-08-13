//
//  SYCOrganizationModel.m
//  MoblieCQUPT_iOS
//
//  Created by 施昱丞 on 2018/8/11.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "SYCOrganizationModel.h"

@implementation SYCOrganizationModel

- (instancetype)initWithName:(NSString *)name AndImage:(UIImage *)image AndDetail:(NSString *)detail{
    self = [super init];
    if (self) {
        self.name = name;
        self.image = image;
        self.detail = detail;
    }
    return self;
}

@end
