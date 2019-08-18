//
//  YouWenAddModel.h
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2018/4/14.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol YouWenAddDelegate<NSObject>
- (void)missionComplete;
@end
@interface YouWenAddModel : NSObject
- (instancetype)initWithInformation:(NSDictionary *)inf andImage:(NSArray *)imgs;
- (void)postTheNewInformation;
@property (nonatomic, strong) id <YouWenAddDelegate>delegate;
@end
