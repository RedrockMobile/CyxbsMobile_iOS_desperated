//
//  DiningHallAndDormitoryController.m
//  MoblieCQUPT_iOS
//
//  Created by 方昱恒 on 2019/8/18.
//  Copyright © 2019 Orange-W. All rights reserved.
//

#import "DiningHallAndDormitoryController.h"
#import "SchoolNavigatorCell.h"

@interface DiningHallAndDormitoryController ()

@end

@implementation DiningHallAndDormitoryController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithRed:235/255.0 green:247/255.0 blue:255/255.0 alpha:1];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"diningHallAndDormitory";
    SchoolNavigatorCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[SchoolNavigatorCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.diningHallAndDormitoryModel = self.model;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.model.cellHeight;
}

@end
