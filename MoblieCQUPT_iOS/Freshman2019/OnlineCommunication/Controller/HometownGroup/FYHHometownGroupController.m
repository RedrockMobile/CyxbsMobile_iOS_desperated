//
//  FYHHometownGroupControllerTableViewController.m
//  CQUPT_Mobile
//
//  Created by 方昱恒 on 2019/8/2.
//  Copyright © 2019 方昱恒. All rights reserved.
//

#import "FYHHometownGroupController.h"
#import "FYHGroupsTabelViweCell.h"


@interface FYHHometownGroupController ()

@end

@implementation FYHHometownGroupController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 这里有个警告，没有实现方法，这个方法在父类中有实现
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(jumpToSelectedItem:) name:@"selected a hometown" object:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.allModelArray.count;
}

- (void)requestAllModelData {
    NSString *url = HOMETOWNGROUPAPI;
    
    HttpClient *client = [HttpClient defaultClient];
    [client requestWithPath:url method:HttpRequestGet parameters:nil prepareExecute:nil progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSMutableArray *tempArray = [NSMutableArray array];
        for (NSDictionary *dict in responseObject[@"text"]) {
            AcademyOrHometownItem *academy = [[AcademyOrHometownItem alloc] initWithDict:dict];
            [tempArray addObject:academy];
        }
        self.allModelArray = tempArray;
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"model requests failed" object:nil];
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    FYHGroupsTabelViweCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[FYHGroupsTabelViweCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = self.allModelArray[indexPath.row].name;
    cell.groupNumber = self.allModelArray[indexPath.row].data;
    
    cell.backgroundColor = [UIColor colorWithRed:249/255.0 green:253/255.0 blue:255/255.0 alpha:1];
    cell.layer.borderWidth = 1;
    cell.layer.borderColor = [UIColor colorWithRed:220/255.0 green:231/255.0 blue:252/255.0 alpha:1].CGColor;
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

@end
