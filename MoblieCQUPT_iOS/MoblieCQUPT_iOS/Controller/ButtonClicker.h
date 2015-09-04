//
//  ButtonClicker.h
//  MoblieCQUPT_iOS
//
//  Created by RainyTunes on 8/27/15.
//  Copyright (c) 2015 Orange-W. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MainViewController.h"
@interface ButtonClicker : NSObject
@property (nonatomic, strong) UIViewController *delegate;
@property (nonatomic, strong) NSString *stuNum;
@property (nonatomic, strong) NSString *idNum;
- (void)clickForExamSchedule;
- (void)clickForReexamSchedule;
- (void)clickForExamGrade;
- (void)clickForEmptyRooms;

@end
