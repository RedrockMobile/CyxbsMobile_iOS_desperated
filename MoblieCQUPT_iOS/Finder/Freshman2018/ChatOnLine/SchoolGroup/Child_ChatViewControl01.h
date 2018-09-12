//
//  Child_ChatViewControl.h
//  MoblieCQUPT_iOS
//
//  Created by J J on 2018/8/20.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Child_ChatViewControl01 : BaseViewController<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>

@property (retain,nonatomic)UITextField *textField;
@property (retain,nonatomic)UIButton *button;
@property (retain,nonatomic)UITableView *tableView;
//保存学院名称
@property (retain,nonatomic)NSMutableArray *arrayData01;
//保存号码
@property (retain,nonatomic)NSMutableArray *arrayData02;

@end
