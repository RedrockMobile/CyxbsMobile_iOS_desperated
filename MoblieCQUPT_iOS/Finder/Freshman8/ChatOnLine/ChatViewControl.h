//
//  ViewControl.h
//  MoblieCQUPT_iOS
//
//  Created by J J on 2018/8/12.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatViewControl : UIViewController<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>

@property (retain,nonatomic)UISegmentedControl *segmentedControl;
@property (retain,nonatomic)UITextField *textField;
@property (retain,nonatomic)UIButton *button;
@property (retain,nonatomic)UITableView *tableView;
@property (retain,nonatomic)NSMutableArray *arrayData01;
@property (retain,nonatomic)NSMutableArray *arrayData02;

@end
