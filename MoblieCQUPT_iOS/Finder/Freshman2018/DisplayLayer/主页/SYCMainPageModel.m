//
//  SYCMainPageModel.m
//  MoblieCQUPT_iOS
//
//  Created by 施昱丞 on 2018/8/13.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "SYCMainPageModel.h"

@implementation SYCMainPageModel

+ (instancetype)shareInstance{
    static SYCMainPageModel *shareInstance = nil;
    if (!shareInstance) {
        shareInstance = [[self alloc] init];
    }
    shareInstance.currentStep =  [[NSKeyedUnarchiver unarchiveObjectWithFile:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"currentStep.archiver"]] integerValue];
    return shareInstance;
}

- (void)setCurrentStep:(NSUInteger)currentStep{
    _currentStep = currentStep;
    [NSKeyedArchiver archiveRootObject:[NSNumber numberWithInteger:currentStep] toFile:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"currentStep.archiver"]];
}

@end
