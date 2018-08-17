//
//  SYCMainPageModel.h
//  MoblieCQUPT_iOS
//
//  Created by 施昱丞 on 2018/8/13.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SYCMainPageModel : NSObject

@property (nonatomic) NSUInteger currentStep;
@property (nonatomic) NSMutableArray *hasAnimationed;

+ (instancetype)shareInstance;
    

@end
