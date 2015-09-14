//
//  XBSConsultButtonClicker.h
//  MoblieCQUPT_iOS
//
//  Created by RainyTunes on 8/27/15.
//  Copyright (c) 2015 Orange-W. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MainViewController.h"
@interface XBSConsultButtonClicker : NSObject
@property (nonatomic, strong) MainViewController *delegate;
@property (nonatomic, strong) NSString *stuNum;
@property (nonatomic, strong) NSString *idNum;
@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, strong) UIButton *nowButton;
- (void)clickForExamSchedule;
- (void)clickForReexamSchedule;
- (void)clickForExamGrade;
- (void)clickForEmptyRooms;
- (void)clickForEmptyClassroom;

@end
