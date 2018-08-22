//
//  Child_ChatViewControl02ViewController.h
//  MoblieCQUPT_iOS
//
//  Created by J J on 2018/8/20.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "BaseViewController.h"

@interface Child_ChatViewControl02 : BaseViewController<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>

@property (retain,nonatomic)UITextField *textField;
@property (retain,nonatomic)UIButton *button;
@property (retain,nonatomic)UITableView *tableView;
//保存学院名称
@property (retain,nonatomic)NSMutableArray *arrayData01;
//保存号码
@property (retain,nonatomic)NSMutableArray *arrayData02;
@end
