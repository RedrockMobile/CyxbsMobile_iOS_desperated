//
//  SchoolNavigatorController.m
//  MoblieCQUPT_iOS
//
//  Created by 千千 on 2019/8/17.
//  Copyright © 2019 Orange-W. All rights reserved.
//

#import "SchoolNavigatorController.h"
#import "SchoolNavigatorCell.h"


@interface SchoolNavigatorController ()

@end

@implementation SchoolNavigatorController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = self.company.companyName;

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithRed:235/255.0 green:247/255.0 blue:255/255.0 alpha:1];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.company.spotsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"expressCell";
    SchoolNavigatorCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[SchoolNavigatorCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.spotModel = self.company.spotsArray[indexPath.row];
    [tableView reloadRow:indexPath.row inSection:indexPath.section withRowAnimation:UITableViewRowAnimationNone];
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.company.spotsArray[indexPath.row].cellHeight;
}

@end
