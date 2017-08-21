//
//  LostModel.h
//  MoblieCQUPT_iOS
//
//  Created by 李展 on 2017/4/3.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LostModel : NSObject
@property NSString *stu_num;
@property NSString *idNum;
@property NSString *property;
@property NSString *category;
@property NSString *detail;
@property NSString *pickTime;
@property NSString *place;
@property NSString *phone;
@property NSString *qq;
- (NSDictionary *)packToParamtersDic;
@end
