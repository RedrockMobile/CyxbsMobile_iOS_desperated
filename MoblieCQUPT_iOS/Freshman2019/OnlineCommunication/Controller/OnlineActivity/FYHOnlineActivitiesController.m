//
//  FYHOnlineActivitiesController.m
//  CQUPT_Mobile
//
//  Created by 方昱恒 on 2019/8/3.
//  Copyright © 2019 方昱恒. All rights reserved.
//

#import "FYHOnlineActivitiesController.h"
#import "OnlineActivitiesCell.h"
#import "ActivityItem.h"
#import "WelcomeView.h"
//#import <AFNetworking.h>

@interface FYHOnlineActivitiesController ()

@property (nonatomic, copy) NSArray<ActivityItem *> *acticityList;

@end

@implementation FYHOnlineActivitiesController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:240/255.0 green:247/255.0 blue:254/255.0 alpha:1];
    
    [self requestList];
    
    self.tableView.rowHeight = MAIN_SCREEN_W * 0.82 + 15;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 30, 0);
}

// 获取模型信息
- (void)requestList {
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    NSString *url = ONLINEACTIVITYAPI;
    
    HttpClient *client = [HttpClient defaultClient];
    [client requestWithPath:url method:HttpRequestGet parameters:nil prepareExecute:nil progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSMutableArray *tempArray = [NSMutableArray array];
        for (NSDictionary *dict in responseObject[@"text"]) {
            ActivityItem *item = [[ActivityItem alloc] initWithDict:dict];
            [tempArray addObject:item];
        }
        self.acticityList = tempArray;
        
        [self.tableView reloadData];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"academy requests succeeded" object:nil];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"activity get failed" object:nil];
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.acticityList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"activity";
    OnlineActivitiesCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[OnlineActivitiesCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.backgroundColor = [UIColor colorWithRed:240/255.0 green:247/255.0 blue:254/255.0 alpha:1];;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.titleLabel.text = self.acticityList[indexPath.row].name;
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSURL *image_url = [NSURL URLWithString:self.acticityList[indexPath.row].photo];
        NSData *image_data = [NSData dataWithContentsOfURL:image_url];
        UIImage *image = [UIImage imageWithData:image_data];
        dispatch_sync(dispatch_get_main_queue(), ^{
            cell.contentImageView.image = image;
        });
    });
    
    cell.joinButton.tag = indexPath.row;
    [cell.joinButton addTarget:self action:@selector(joinButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

- (void)joinButtonClicked:(UIButton *)button {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"join activity" object:nil userInfo:@{@"model": self.acticityList[button.tag]}];
}



@end
