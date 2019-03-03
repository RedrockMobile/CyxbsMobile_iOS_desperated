//
//  LZPersonModel.h
//  MoblieCQUPT_iOS
//
//  Created by 李展 on 2017/9/22.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LessonMatter;
@class MyInfoModel;

@interface LZPersonModel : NSObject
@property (nonatomic, copy) NSString *stuNum;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *gender;
@property (nonatomic, copy) NSString *classnum;
@property (nonatomic, copy) NSString *major;
@property (nonatomic, copy) NSString *depart;
@property (nonatomic, copy) NSString *grade;

@property (nonatomic, copy) NSArray <LessonMatter *> *lessons;

- (instancetype)initWithData:(NSDictionary *)data;
- (instancetype)initWithMyInfo:(MyInfoModel *)myInfo;

@end
