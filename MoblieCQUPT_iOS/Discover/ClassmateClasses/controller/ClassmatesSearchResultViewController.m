//
//  ClassmatesSearchResultViewController.m
//  MoblieCQUPT_iOS
//
//  Created by 方昱恒 on 2019/9/27.
//  Copyright © 2019 Orange-W. All rights reserved.
//

#import "ClassmatesSearchResultViewController.h"
#import "ClassmatesSearchResultCell.h"
#import "ClassmateItem.h"
#import "WYCClassmateScheduleViewController.h"

@interface ClassmatesSearchResultViewController ()

@property (nonatomic, strong) ClassmatesList *classmatesList;

@end

@implementation ClassmatesSearchResultViewController

- (instancetype)initWithClassmatesList:(ClassmatesList *)classmatesList {
    if (self = [super init]) {
        self.classmatesList = classmatesList;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"选择同学";
    self.view.backgroundColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1];
    self.tableView.rowHeight = 80;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.classmatesList.classmatesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"classmateCellID";
    
    ClassmatesSearchResultCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[ClassmatesSearchResultCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.nameLabel.text = self.classmatesList.classmatesArray[indexPath.row].name;
        cell.detaileLabel.text = [NSString stringWithFormat:@"%@  %@", self.self.classmatesList.classmatesArray[indexPath.row].major, self.classmatesList.classmatesArray[indexPath.row].stuNum];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ClassmateItem *item = self.classmatesList.classmatesArray[indexPath.row];
    NSString *classmateNum = item.stuNum;
    WYCClassmateScheduleViewController *vc = [[WYCClassmateScheduleViewController alloc]initWithClassmateNum:classmateNum];
    [self.navigationController pushViewController:vc animated:YES];
    
    
}
@end
