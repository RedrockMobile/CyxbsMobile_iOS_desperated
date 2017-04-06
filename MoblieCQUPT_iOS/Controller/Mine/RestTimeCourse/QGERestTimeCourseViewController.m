//
//  QGERestTimeCourseViewController.m
//  MoblieCQUPT_iOS
//
//  Created by GQuEen on 15/12/8.
//  Copyright © 2015年 Orange-W. All rights reserved.
//

#import "QGERestTimeCourseViewController.h"
#import "QGERestDetailViewController.h"

#define GETNAME_API @"http://202.202.43.125/cyxbsMobile/index.php/home/searchPeople?"


@interface QGERestTimeCourseViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UITextField *stuNumField;
//@property (strong, nonatomic) UIButton *addBtn;
@property (strong, nonatomic) UIButton *editBtn;
@property (strong, nonatomic) UILabel *addedLabel;
@property (strong, nonatomic) UIView *table;
@property (assign, nonatomic) BOOL isEdting;
@property (strong, nonatomic) NSMutableArray *stuNumArray;
@property (strong, nonatomic) NSMutableArray *stuInfoArray;
@end

@implementation QGERestTimeCourseViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    _isEdting = NO;
    self.view.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1];
    [self initView];
    _stuNumArray = [NSMutableArray array];
    _stuInfoArray = [NSMutableArray array];
//    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    
    // Do any additional setup after loading the view from its nib.
}


- (UITableView *)tableView {
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 40, _table.frame.size.width, 300) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor whiteColor    ];
    _tableView.sectionFooterHeight = 0;
    _tableView.sectionHeaderHeight = 0;
    _tableView.scrollEnabled = YES;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView setAutoresizesSubviews:NO];
    _tableView.showsVerticalScrollIndicator = NO;
    return _tableView;
}

- (void)initView {
    UIView *fieldView = [[UIView alloc]initWithFrame:CGRectMake(15, 84, MAIN_SCREEN_W-30, 40)];
    fieldView.backgroundColor = [UIColor whiteColor];
    fieldView.clipsToBounds = YES;
    fieldView.layer.borderWidth = 0.5;
    fieldView.layer.cornerRadius = 3.0;
    fieldView.layer.borderColor = [UIColor colorWithRed:197/255.0 green:197/255.0 blue:197/255.0 alpha:1].CGColor;
    [self.view addSubview:fieldView];
    
//    _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    _addBtn.frame = CGRectMake(fieldView.frame.size.width-60, 0, 60, 40);
//    _addBtn.backgroundColor = [UIColor colorWithRed:197/255.0 green:197/255.0 blue:197/255.0 alpha:1];
//    [_addBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//    _addBtn.enabled = NO;
//    [_addBtn setTitle:@"添加" forState:UIControlStateNormal];
//    _addBtn.titleLabel.font = [UIFont systemFontOfSize:14];
//    [_addBtn addTarget:self action:@selector(addStuNum) forControlEvents:UIControlEventTouchUpInside];
//    [fieldView addSubview:_addBtn];
    
    _stuNumField = [[UITextField alloc]initWithFrame:CGRectMake(10, 0, fieldView.frame.size.width-10, 40)];
    _stuNumField.placeholder = @"输入学号可以继续添加";
    _stuNumField.tintColor = MAIN_COLOR;
    _stuNumField.font = [UIFont systemFontOfSize:16];
    _stuNumField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _stuNumField.delegate = self;
    _stuNumField.keyboardType = UIKeyboardTypeDefault;
    _stuNumField.returnKeyType = UIReturnKeySearch;
    _stuNumField.layer.borderColor = MAIN_COLOR.CGColor;
    [fieldView addSubview:_stuNumField];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.stuNumField];
    
    _table = [[UIView alloc]initWithFrame:CGRectMake(15, 144, MAIN_SCREEN_W-30, 340)];
    _table.backgroundColor = [UIColor whiteColor];
    _table.clipsToBounds = YES;
    _table.layer.borderColor = [UIColor colorWithRed:197/255.0 green:197/255.0 blue:197/255.0 alpha:1].CGColor;
    _table.layer.borderWidth = 0.5;
    _table.layer.cornerRadius = 2.0;
    [self.view addSubview:_table];
    
    UIView *labelView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _table.frame.size.width, 40)];
    labelView.backgroundColor = [UIColor whiteColor];
    labelView.clipsToBounds = YES;
    labelView.layer.borderWidth = 0.5;
    labelView.layer.borderColor = [UIColor colorWithRed:197/255.0 green:197/255.0 blue:197/255.0 alpha:1].CGColor;
    [_table addSubview:labelView];
    
    
    _editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _editBtn.frame = CGRectMake(labelView.frame.size.width-60, 0, 60, 40);
    [_editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [_editBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _editBtn.layer.borderColor = [UIColor colorWithRed:197/255.0 green:197/255.0 blue:197/255.0 alpha:1].CGColor;
    _editBtn.backgroundColor = [UIColor whiteColor];
    _editBtn.layer.borderWidth = 0.5;
    _editBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_editBtn addTarget:self action:@selector(editTableViewCell) forControlEvents:UIControlEventTouchUpInside];
    [labelView addSubview:_editBtn];
    
    _addedLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, labelView.frame.size.width-10-_editBtn.frame.size.width, 40)];
    _addedLabel.textColor = MAIN_COLOR;
    _addedLabel.text = @"已添加0人";
    _addedLabel.font = [UIFont systemFontOfSize:16];
    [labelView addSubview:_addedLabel];
    
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame = CGRectMake(15, _table.frame.origin.y+_table.frame.size.height+20, MAIN_SCREEN_W-30, 50);
    [searchBtn setTitle:@"查询" forState:UIControlStateNormal];
    [searchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    searchBtn.backgroundColor = MAIN_COLOR;
    searchBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    searchBtn.layer.cornerRadius = 2.0;
    [searchBtn addTarget:self action:@selector(clickSearch) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchBtn];
}

- (void)textChange {
    NSLog(@"11");
    
    
//    if (_stuNumField.text.length == 10) {
//        _addBtn.enabled = YES;
//        _addBtn.backgroundColor = MAIN_COLOR;
//        [_addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    }else {
//        _addBtn.enabled = NO;
//        _addBtn.backgroundColor = [UIColor colorWithRed:197/255.0 green:197/255.0 blue:197/255.0 alpha:1];
//        [_addBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//    }
}

- (void)editTableViewCell {
    if (_isEdting) {
        [_tableView setEditing:NO animated:YES];
        _isEdting = NO;
        [_editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    }else {
        [_tableView setEditing:YES animated:YES];
        _isEdting = YES;
        [_editBtn setTitle:@"完成" forState:UIControlStateNormal];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self addStuNum];
    return YES;
}

- (void)addStuNum {
//    _addBtn.enabled = NO;
//    _addBtn.backgroundColor = [UIColor colorWithRed:197/255.0 green:197/255.0 blue:197/255.0 alpha:1];
//    [_addBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    NSDictionary *parameter = @{@"stunum":_stuNumField.text};
    [NetWork NetRequestGETWithRequestURL:GETNAME_API WithParameter:parameter WithReturnValeuBlock:^(id returnValue) {
        [self textChange];
        if ([returnValue[@"info"] isEqualToString:@"failed"]) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"输入的学号有问题,请重新输入" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
            _stuNumField.text = @"";
        }else if([returnValue[@"info"] isEqualToString:@"success"]){
            BOOL isHaveSameName = NO;
            
            //如果名单列表处于编辑状态 点击添加按钮 取消名单的编辑状态
            if(_isEdting) {
                [_tableView setEditing:NO animated:YES];
                _isEdting = NO;
                [_editBtn setTitle:@"编辑" forState:UIControlStateNormal];
            }
            
            if (_stuInfoArray.count > 0) {
                for (int i=0; i<_stuInfoArray.count; i++) {
                    if ([returnValue[@"data"][@"name"] isEqualToString:_stuInfoArray[i][@"name"]]) {
                        isHaveSameName = YES;
                    }
                }
                if (isHaveSameName) {
                    UIAlertView *alert1 = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"输入的学号已经添加过了！O(∩_∩)O" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                    [alert1 show];
                }else {
                    [_stuNumArray addObject:_stuNumField.text];
                    [_stuInfoArray addObject:returnValue[@"data"]];
                    [_tableView reloadData];
                    _addedLabel.text = [NSString stringWithFormat:@"已添加%ld人",(unsigned long)_stuInfoArray.count];
                }
            }else {
                [_stuNumArray addObject:_stuNumField.text];
                [_stuInfoArray addObject:returnValue[@"data"]];
                [_table addSubview:self.tableView];
                _addedLabel.text = [NSString stringWithFormat:@"已添加%ld人",(unsigned long)_stuInfoArray.count];
            }
        }
        _stuNumField.text = @"";
    } WithFailureBlock:^{
        NSLog(@"请求失败");
    }];
}

- (void)clickSearch {
    QGERestDetailViewController *q = [[QGERestDetailViewController alloc]init];
    q.allStuNumArray = _stuNumArray;
    q.allStuNameArray = _stuInfoArray;
    NSLog(@"%@",_stuNumArray);
    [self.navigationController pushViewController:q animated:YES];
    [self viewDidLoad];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _stuNumArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentify = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentify];
    }
    cell.textLabel.text = _stuInfoArray[indexPath.row][@"name"];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_stuInfoArray removeObjectAtIndex:[indexPath row]];
        [_stuNumArray removeObjectAtIndex:[indexPath row]];
        [_tableView  deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationFade];
    }
    [_tableView reloadData];
    _addedLabel.text = [NSString stringWithFormat:@"已添加%ld人",(unsigned long)_stuInfoArray.count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_stuNumField resignFirstResponder];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
