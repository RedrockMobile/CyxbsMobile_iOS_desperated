//
//  SYCCollageModel.m
//  MoblieCQUPT_iOS
//
//  Created by 施昱丞 on 2018/8/11.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "SYCCollageModel.h"

@interface SYCCollageModel()


@end

@implementation SYCCollageModel

- (instancetype)initWithName:(NSString *)name andSexRatio:(NSDictionary *)sexRatio andSubjects:(NSArray *)subjuets{
    self = [super init];
    if (self) {
        self.name = name;
        self.sexRatio = sexRatio;
        self.subjects = subjuets;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        self.name = [coder decodeObjectForKey:@"name"];
        self.sexRatio = [coder decodeObjectForKey:@"sexRatio"];
        self.subjects = [coder decodeObjectForKey:@"subjects"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.name forKey:@"name"];
    [coder encodeObject:self.sexRatio forKey:@"sexRatio"];
    [coder encodeObject:self.subjects forKey:@"subjects"];
}

@end
