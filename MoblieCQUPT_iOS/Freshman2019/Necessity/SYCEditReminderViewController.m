//
//  SYCEditReminderViewController.m
//  MoblieCQUPT_iOS
//
//  Created by 施昱丞 on 2019/8/23.
//  Copyright © 2019 Orange-W. All rights reserved.
//

#import "SYCEditReminderViewController.h"
#import "SYCAddReminderViewController.h"
#import "View/FMNecessityTableViewCell.h"
#import "BaseNavigationController.h"
#import <Masonry.h>

@interface SYCEditReminderViewController () <UITableViewDelegate, UITableViewDataSource, SYCAddReminderViewControllerDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *addBtn;
@property (nonatomic) NSMutableArray *deleteArray;
@property BOOL isEdit;
@property BOOL isAdded;
@end

@implementation SYCEditReminderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"编辑";
    self.isEdit = NO;
    self.view.backgroundColor = RGBColor(239, 247, 255, 1);
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(didClickCancelBtn)];
    self.navigationItem.leftBarButtonItem = left;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, TOTAL_TOP_HEIGHT + 10, SCREEN_WIDTH, SCREEN_HEIGHT - TOTAL_TOP_HEIGHT) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"删除" style:UIBarButtonItemStylePlain target:self action:@selector(didClickDeleteBtn)];
    self.navigationItem.rightBarButtonItem = right;
    
    _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _addBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_addBtn setTitleColor:RGBColor(169, 169, 169, 1) forState:UIControlStateNormal];
    [_addBtn setTitle:@"还未添加内容，点击我添加备忘录内容" forState:UIControlStateNormal];
    [_addBtn addTarget:self action:@selector(addReminder) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_addBtn];
    [_addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).with.offset(37 + TOTAL_TOP_HEIGHT);
        make.width.mas_equalTo(SCREEN_WIDTH * 0.68);
        make.height.mas_equalTo(15);
    }];
    _deleteArray = [@[] mutableCopy];
    
    if (_reminders.count > 0) {
        _addBtn.layer.hidden = YES;
    }else{
        _tableView.layer.hidden = YES;
    }
}

- (void)refresh{
    if (_reminders.count > 0) {
        _addBtn.layer.hidden = YES;
        _tableView.layer.hidden = NO;
    }else{
        _tableView.layer.hidden = YES;
        _addBtn.layer.hidden = NO;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.reminders.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FMNecessityTableViewCell *cell = [FMNecessityTableViewCell cellWithTableView:tableView andIndexpath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.DLNModel = self.reminders[indexPath.row];
    cell.label.textColor = [UIColor blackColor];
    
    [cell.btn1 removeFromSuperview];
    [cell.btn2 removeFromSuperview];
    [cell.contentView addSubview:cell.btn3];
    [cell.btn3 addTarget:self action:@selector(didClickSelectBtn: event:) forControlEvents:UIControlEventTouchUpInside];
    
    
    if(!cell.DLNModel.isSelected){
        [cell.btn3 setImage:[UIImage imageNamed:@"蓝框"] forState:UIControlStateNormal];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    DLNecessityModel *model = self.reminders[indexPath.row];
    return [FMNecessityTableViewCell cellDefautHeight:model];
}

//删除页面点击圆框按钮
- (void)didClickSelectBtn:(UIButton *)btn event:(UIEvent *)event{
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint point = [touch locationInView:_tableView];
    NSIndexPath *index = [_tableView indexPathForRowAtPoint:point];
    DLNecessityModel *model = self.reminders[index.row];
    if(!model.isSelected){
        [btn setImage:[UIImage imageNamed:@"蓝框选中"] forState:UIControlStateNormal];
        [self.deleteArray addObject:self.reminders[index.row]];
        model.isSelected = YES;
        [self.reminders replaceObjectAtIndex:index.row withObject:model];
    }else{
        [btn setImage:[UIImage imageNamed:@"蓝框"] forState:UIControlStateNormal];
        model.isSelected = NO;
        [self.reminders replaceObjectAtIndex:index.row withObject:model];
        [self.deleteArray removeObject:self.reminders[index.row]];
    }
    
    if (self.deleteArray.count != 0) {
        [self.navigationItem.rightBarButtonItem setTitle:[NSString stringWithFormat:@"删除(%lu)", (unsigned long)self.deleteArray.count]];
    }else{
        [self.navigationItem.rightBarButtonItem setTitle:[NSString stringWithFormat:@"删除"]];
    }
}


//点击navigationBar的编辑按钮
- (void)didClickDeleteBtn{
    if (_deleteArray.count > 0) {
        [self.reminders removeObjectsInArray:self.deleteArray];
        [self.delagete reloadDataWithReminder:_reminders];
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"你没有选择任何项哦(○o○)" delegate:self cancelButtonTitle:@"退出" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (void)didClickCancelBtn{
    if (_isAdded) {
        [self.delagete reloadDataWithReminder:_reminders];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)addReminder{
    SYCAddReminderViewController *vc = [[SYCAddReminderViewController alloc] init];
    vc.delegate = self;
    [self presentViewController:[[BaseNavigationController alloc] initWithRootViewController:vc] animated:YES completion:nil];
}

- (void)reloadWithData:(NSMutableArray *)dataArray title:(NSMutableArray *)titleArray{
    self.reminders = dataArray[0];
    self.isAdded = YES;
    [self.tableView reloadData];
    [self refresh];
}

@end
