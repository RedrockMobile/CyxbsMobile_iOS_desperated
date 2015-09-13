//
//  XBSFindClassroomViewController.h
//  MoblieCQUPT_iOS
//
//  Created by RainyTunes on 9/12/15.
//  Copyright (c) 2015 Orange-W. All rights reserved.
//

#import "XBSViewController.h"

@interface XBSFindClassroomViewController : XBSViewController <UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *periodViewArray;
@property (nonatomic, strong) UIButton *buildingSelectorButton;
@property (nonatomic, strong) UIButton *dateSelectorButton;
@end
