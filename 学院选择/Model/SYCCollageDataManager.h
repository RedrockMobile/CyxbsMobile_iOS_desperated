//
//  SYCCollageDataManager.h
//  MoblieCQUPT_iOS
//
//  Created by 施昱丞 on 2018/8/11.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SYCCollageDataManager : NSObject

@property (nonatomic, strong)NSDictionary *nameList;
@property (nonatomic, strong)NSMutableDictionary *collageData;

@property Boolean error;

+ (instancetype)sharedInstance;

@end
