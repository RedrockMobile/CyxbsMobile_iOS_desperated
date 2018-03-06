//
//  LZPersonSelectViewController.m
//  MoblieCQUPT_iOS
//
//  Created by 李展 on 2017/9/22.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import "LZPersonSelectViewController.h"
#import "LZPersonSelectTableViewCell.h"
#import "LZPersonModel.h"
@interface LZPersonSelectViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray <LZPersonModel *> *persons;
@end

@implementation LZPersonSelectViewController
- (instancetype)initWithPersons:(NSArray <LZPersonModel *> *)persons{
    self = [self init];
    if (self) {
        self.persons = persons;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableView *)tableView{
    if(_tableView == nil){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc]init];
        _tableView.tableFooterView.backgroundColor = [UIColor colorWithHexString:@"#f6f6f6"];
        _tableView.allowsSelection = NO;
    }
    return _tableView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LZPersonSelectTableViewCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"LZPersonSelectTableViewCell" owner:self options:nil] firstObject];
    LZPersonModel *model = self.persons[indexPath.row];
    cell.nameLabel.text = model.name;
    cell.majorLabel.text = model.major;
    cell.stuNumLabel.text = model.stuNum;
    cell.addBtn.tag = indexPath.row;
    [cell.addBtn addTarget:self action:@selector(addPerson:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.persons.count;
}

- (void)addPerson:(UIButton *)sender{
    NSInteger index = sender.tag;
    LZPersonModel *model = self.persons[index];
    if(self.selectPersonBlock){
        self.selectPersonBlock(model);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 667/SCREENHEIGHT*100;
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
