//
//  LostTableViewController.m
//  MoblieCQUPT_iOS
//
//  Created by 李展 on 2017/3/8.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import "LostTableViewController.h"
#import "LostTableViewCell.h"
#import "HttpClient.h"
#import "LostItem.h"
#import "DetailLostViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "MJRefresh.h"
#define LOSTAPI @"http://hongyan.cqupt.edu.cn/laf/api/view"

@interface LostTableViewController ()
@property NSMutableArray *itemArray;
@property NSMutableString *APIString;
@end

@implementation LostTableViewController
- (instancetype)initWithTitle:(NSString *)title Theme:(NSNumber *)theme{
    self = [self init];
    if (self) {
        self.title = title;
        self.APIString = LOSTAPI.mutableCopy;
        if (theme.integerValue == LZLost) {
            [self.APIString appendString:@"/lost"];
        }
        else{
            [self.APIString appendString:@"/found"];
        }
        if(![title isEqualToString:@"全部"]){
        [self.APIString appendString:[NSString stringWithFormat:@"/%@",title.stringByURLEncode]];
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.estimatedRowHeight = 100.f;
    NSDictionary *paramters = nil;
    self.itemArray = [NSMutableArray array];
    [[HttpClient defaultClient] requestWithPath:self.APIString method:HttpRequestGet parameters:paramters prepareExecute:nil progress:^(NSProgress *progress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
    
        for (NSDictionary *dic in [responseObject objectForKey:@"data"]) {
           [self.itemArray addObject:[[LostItem alloc]initWithDic:dic]];
        }
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    [self.tableView addFooterWithCallback:^{
        NSLog(@"hah");
    }];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.itemArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"LostTableViewCell";
    LostTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    NSInteger index = indexPath.section;
    LostItem *item = self.itemArray[index];
    if (cell == nil) {
        cell = (LostTableViewCell *)[[[NSBundle mainBundle] loadNibNamed:@"LostTableViewCell" owner:nil options:nil] lastObject];
    }
    
    cell.contentLabel.text = item.pro_description;
    [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:item.wx_avatar]];
    cell.timeLabel.text = item.created_at;
    cell.categoryLabel.text = item.pro_name;
    cell.nameLabel.text = item.connect_name;
    
    
    // Configure the cell...
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 12;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LostItem *item = self.itemArray[indexPath.section];
    NSString *path = [LOSTAPI stringByAppendingString:[NSString stringWithFormat:@"/detail/%@",item.pro_id]];
    DetailLostViewController *detailLostViewController = [[DetailLostViewController alloc]init];
    [self.parentViewController.navigationController pushViewController:detailLostViewController animated:YES];
    [[HttpClient defaultClient] requestWithPath:path method:HttpRequestGet parameters:nil prepareExecute:^{
        
    } progress:^(NSProgress *progress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        LostItem *detailItem = [[LostItem alloc]initWithDic:responseObject];
        [detailLostViewController refreshWithDetailInfo:detailItem];

    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
