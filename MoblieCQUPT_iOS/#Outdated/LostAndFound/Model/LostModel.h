//
//  LostModel.h
//  MoblieCQUPT_iOS
//
//  Created by 李展 on 2017/4/3.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LostModel : NSObject
@property (nonatomic, copy) NSString *stu_num;
@property (nonatomic, copy) NSString *idNum;
@property (nonatomic, copy) NSString *property;
@property (nonatomic, copy) NSString *category;
@property (nonatomic, copy) NSString *detail;
@property (nonatomic, copy) NSString *pickTime;
@property (nonatomic, copy) NSString *place;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *qq;
- (NSDictionary *)packToParamtersDic;
@end
