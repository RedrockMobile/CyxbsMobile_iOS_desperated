//
//  StartStepsController.m
//  MoblieCQUPT_iOS
//
//  Created by 方昱恒 on 2019/8/10.
//  Copyright © 2019 Orange-W. All rights reserved.
//

#import "StartStepsController.h"
#import "StepsModel.h"
#import "StartStepsTableView.h"
#import "StartStepsCell.h"

@interface StartStepsController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, copy) NSArray<StepsModel *> *modelArray;
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) MBProgressHUD *hud;

@end

@implementation StartStepsController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:239/255.0 green:247/255.0 blue:255/255.0 alpha:1];
    self.title = @"入学流程";
    
    [self getModelArray];
    
    StartStepsTableView *tableView = [[StartStepsTableView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_W, MAIN_SCREEN_H - TOTAL_TOP_HEIGHT) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor colorWithRed:239/255.0 green:247/255.0 blue:255/255.0 alpha:1];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"努力加载中";
    self.hud = hud;
}

- (void)getModelArray {
    [StepsModel getModelData:^(NSArray * _Nonnull modelDataArray) {
        NSMutableArray *tempArray = [NSMutableArray array];
        for (NSDictionary *dict in modelDataArray) {
            StepsModel *model = [[StepsModel alloc] initWithDictionary:dict];
            [tempArray addObject:model];
        }
        [tempArray removeObjectAtIndex:0];
        self.modelArray = tempArray;
        [self.tableView reloadData];
        UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, MAIN_SCREEN_W - 30, 46)];
        headerLabel.text = [NSString stringWithFormat:@"    报到时间：%@", modelDataArray[0][@"message"]];
        headerLabel.font = [UIFont systemFontOfSize:16];
        headerLabel.textColor = [UIColor colorWithRed:106/255.0 green:106/255.0 blue:106/255.0 alpha:1];
        [self.tableView setTableHeaderView:headerLabel];
        
        [self.hud hide:YES];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.modelArray.count;
}


static NSString *cellID = @"startSteps";
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    StartStepsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    StartStepsCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
       cell = [[NSBundle mainBundle] loadNibNamed:@"StartStepsCell" owner:self options:nil].firstObject;
    }
    cell.model = self.modelArray[indexPath.row];
    cell.extendButton.tag = indexPath.row;
    [cell.extendButton addTarget:self action:@selector(extendButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    StartStepsCell *cell = ((StartStepsCell *)[tableView cellForRowAtIndexPath:indexPath]);
    if (cell.isExtended) {
        return cell.extendedHeight;
    } else {
        return 68;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView beginUpdates];
    StartStepsCell *cell = ((StartStepsCell *)[self.tableView cellForRowAtIndexPath:indexPath]);
    if (cell.extendedHeight == 0) {
        if (indexPath.row == 0) {
            cell.extendedHeight = 313.8;
        } else if (indexPath.row == 1) {
            cell.extendedHeight = 179.5;
        } else if (indexPath.row == 2) {
            cell.extendedHeight = 577.2;
        } else if (indexPath.row == 3) {
            cell.extendedHeight = 163.0;
        } else if (indexPath.row == 4) {
            cell.extendedHeight = 196.0;
        }
    }
    NSLog(@"%f", cell.extendedHeight);
    // 展开时点击
    if (cell.isExtended) {
        cell.isExtended = NO;
        [cell performSelector:@selector(fold) withObject:nil afterDelay:0];
    }
    // 折叠时点击
    else {
        cell.isExtended = YES;
        [cell performSelector:@selector(extend) withObject:nil afterDelay:0.25];
    }
    [self.tableView endUpdates];
}

- (void)extendButtonClicked:(UIButton *)button {
    [self.tableView beginUpdates];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:button.tag inSection:0];
    StartStepsCell *cell = ((StartStepsCell *)[self.tableView cellForRowAtIndexPath:indexPath]);
    if (cell.extendedHeight == 0) {
        if (indexPath.row == 0) {
            cell.extendedHeight = 313.8;
        } else if (indexPath.row == 1) {
            cell.extendedHeight = 179.5;
        } else if (indexPath.row == 2) {
            cell.extendedHeight = 577.2;
        } else if (indexPath.row == 3) {
            cell.extendedHeight = 163.0;
        } else if (indexPath.row == 4) {
            cell.extendedHeight = 196.0;
        }
    }
    // 展开时点击
    if (cell.isExtended) {
        cell.isExtended = NO;
        [cell performSelector:@selector(fold) withObject:nil afterDelay:0];
    }
    // 折叠时点击
    else {
        cell.isExtended = YES;
        [cell performSelector:@selector(extend) withObject:nil afterDelay:0.25];
    }
    [self.tableView endUpdates];
}

@end
