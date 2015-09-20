//
//  XBSFindClassroomViewController2.h
//  MoblieCQUPT_iOS
//
//  Created by RainyTunes on 9/14/15.
//  Copyright (c) 2015 Orange-W. All rights reserved.
//

#import "XBSViewController.h"
#import "XBSFindClassroomModel.h"

@interface XBSFindClassroomViewController : XBSViewController <UITableViewDataSource,UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic, strong) NSMutableArray *periodViewArray;
@property (nonatomic, strong) UIButton *buildingSelectorButton;
@property (nonatomic, strong) UIButton *dateSelectorButton;
@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong) XBSFindClassroomModel *model;
@property (weak, nonatomic) IBOutlet UIPickerView *buildingPickerView;
@property (weak, nonatomic) IBOutlet UIToolbar *doneToolBar;
- (void)selectCancelled;

@end
