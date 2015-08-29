//
//  ButtonClicker.m
//  MoblieCQUPT_iOS
//
//  Created by RainyTunes on 8/27/15.
//  Copyright (c) 2015 Orange-W. All rights reserved.
//

#import "ButtonClicker.h"
#import "DataBundle.h"
#import "Config.h"

@implementation ButtonClicker
- (void)clickForExamSchedule
{
    DataBundle *dataBundle = [[DataBundle alloc]init];
    dataBundle.mainDelegate = self.delegate;
    dataBundle.postParams = [Config paramWithStuNum:TEST_STU_NUM IdNum:TEST_ID_NUM];
    [dataBundle httpPostForSchedule:API_EXAM_SCHEDULE];
}

- (void)clickForReexamSchedule
{
    DataBundle *dataBundle = [[DataBundle alloc]init];
    dataBundle.mainDelegate = self.delegate;
    dataBundle.postParams = [Config paramWithStuNum:TEST_STU_NUM IdNum:TEST_ID_NUM];
    [dataBundle httpPostForSchedule:API_REEXAM_SCHEDULE];
}

- (void)clickForExamGrade
{
    DataBundle *dataBundle = [[DataBundle alloc]init];
    dataBundle.mainDelegate = self.delegate;
    dataBundle.postParams = [Config paramWithStuNum:TEST_STU_NUM IdNum:TEST_ID_NUM];
    [dataBundle httpPostForGrade];
}

- (void)clickForEmptyRooms
{
    DataBundle *dataBundle = [[DataBundle alloc]init];
    dataBundle.mainDelegate = self.delegate;
    [dataBundle httpPostForEmptyRooms];
}
@end
