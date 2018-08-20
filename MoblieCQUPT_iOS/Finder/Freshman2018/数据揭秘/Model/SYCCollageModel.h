//
//  SYCCollageModel.h
//  MoblieCQUPT_iOS
//
//  Created by 施昱丞 on 2018/8/11.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SYCCollageModel : NSObject

@property(nonatomic) NSString *name;
@property(nonatomic) NSDictionary *sexRatio;
@property(nonatomic) NSArray *subjects;

- (instancetype)initWithName:(NSString *)name andSexRatio:(NSDictionary *)sexRatio andSubjects:(NSDictionary *)subjuets;

@end
