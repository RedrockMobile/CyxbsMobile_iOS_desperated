//
//  DLNecessityModel.m
//  MoblieCQUPT_iOS
//
//  Created by 丁磊 on 2018/8/13.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "DLNecessityModel.h"

@interface DLNecessityModel ()

@end

@implementation DLNecessityModel

- (instancetype)initWithDic:(NSDictionary*)dic
{
    self = [super init];
    if (self) {
        self.necessity = dic[@"name"];
        self.detail = dic[@"detail"];
        self.isShowMore = NO;
        self.isShowMoreBtn = YES;
    }
    return self;
}

+ (instancetype)DLNecessityModelWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDic:dict];
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.necessity forKey:@"name"];
    [coder encodeObject:self.detail forKey:@"detail"];
    [coder encodeBool:self.isShowMore forKey:@"isShowMore"];
    [coder encodeBool:self.isShowMoreBtn forKey:@"isShowMoreBtn"];
    [coder encodeBool:self.isReady forKey:@"isReady"];
    [coder encodeBool:self.isSelected forKey:@"isSelected"];
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        self.necessity = [coder decodeObjectForKey:@"name"];
        self.detail = [coder decodeObjectForKey:@"detail"];
        self.isShowMore = [coder decodeBoolForKey:@"isShowMore"];
        self.isShowMoreBtn = [coder decodeBoolForKey:@"isShowMoreBtn"];
        self.isReady = [coder decodeBoolForKey:@"isReady"];
        self.isSelected = [coder decodeBoolForKey:@"isSelected"];
    }
    return self;
}

@end
