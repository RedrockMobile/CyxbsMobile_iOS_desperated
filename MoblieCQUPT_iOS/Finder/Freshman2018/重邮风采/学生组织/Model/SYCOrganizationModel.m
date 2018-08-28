//
//  SYCOrganizationModel.m
//  MoblieCQUPT_iOS
//
//  Created by 施昱丞 on 2018/8/11.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "SYCOrganizationModel.h"

@implementation SYCOrganizationModel

- (instancetype)initWithName:(NSString *)name imageURLs:(NSArray *)imageURLs detail:(NSString *)detail{
    self = [super init];
    if (self) {
        self.name = name;
        self.detail = detail;
        self.imagesURLs = imageURLs;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        self.name = [coder decodeObjectForKey:@"activityName"];
        self.imagesURLs = [coder decodeObjectForKey:@"imagesURLs"];
        self.detail = [coder decodeObjectForKey:@"activityDetail"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.name forKey:@"activityName"];
    [coder encodeObject:self.imagesURLs forKey:@"imagesURLs"];
    [coder encodeObject:self.detail forKey:@"activityDetail"];
}

@end
