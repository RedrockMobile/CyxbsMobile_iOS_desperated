//
//  SYCOrganizationManager.h
//  MoblieCQUPT_iOS
//
//  Created by 施昱丞 on 2018/8/11.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SYCOrganizationManager : NSObject

@property (nonatomic, strong) NSDictionary *organizationData;

+ (instancetype)sharedInstance;

@end
