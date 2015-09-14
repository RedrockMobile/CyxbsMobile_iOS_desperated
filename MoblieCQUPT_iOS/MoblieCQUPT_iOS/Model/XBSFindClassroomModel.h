//
//  XBSFindClassroomModel.h
//  MoblieCQUPT_iOS
//
//  Created by RainyTunes on 9/14/15.
//  Copyright (c) 2015 Orange-W. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MainViewController.h"


@interface XBSFindClassroomModel : NSObject
@property (nonatomic, strong) MainViewController *mainDelegate;
@property (nonatomic, strong) NSMutableArray *availableClassroomArray;
@property (nonatomic, strong) NSArray *resultClassroomArray;
@property (nonatomic, assign) NSInteger hasCompleted;
- (void)httpPostForEmptyClassroom;
- (void)refreshEmptyClassroomTableData;
@end
