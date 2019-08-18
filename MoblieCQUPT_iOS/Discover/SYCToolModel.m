//
//  SYCToolModel.m
//  MoblieCQUPT_iOS
//
//  Created by 施昱丞 on 2018/9/26.
//  Copyright © 2018 Orange-W. All rights reserved.
//

#import "SYCToolModel.h"

@implementation SYCToolModel

- (instancetype)initWithTitle:(NSString *)title ImageName:(NSString *)imageName ClassName:(NSString *)className{
    self = [super init];
    if (self) {
        self.title = title;
        self.imageName = imageName;
        self.className = className;
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.title forKey:@"tool.title"];
    [coder encodeObject:self.imageName forKey:@"tool.imageName"];
    [coder encodeObject:self.className forKey:@"tool.className"];
    
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self.title = [coder decodeObjectForKey:@"tool.title"];
    self.imageName = [coder decodeObjectForKey:@"tool.imageName"];
    self.className = [coder decodeObjectForKey:@"tool.className"];
    return self;
}

@end
