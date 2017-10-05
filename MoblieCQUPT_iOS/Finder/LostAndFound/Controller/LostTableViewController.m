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
#import <MJRefresh/MJRefresh.h>
#import <MBProgressHUD/MBProgressHUD.h>

@interface LostTableViewController ()
@property (nonatomic, strong) NSMutableArray *itemArray;
@property (nonatomic, strong) NSMutableString *APIString;
@property (nonatomic, strong) NSMutableString *nextPageString;
@property (nonatomic, assign) NSInteger theme;
typedef NS_ENUM(NSInteger,LZPlace){
    header = 0,
    footer = 1
    
};
@end

@implementation LostTableViewController
- (instancetype)initWithTitle:(NSString *)title Theme:(NSInteger )theme{
    self = [self init];
    if (self) {
        self.title = title;
        
        self.theme = theme;
        self.APIString = [LOSTAPI stringByAppendingString:@"/view"].mutableCopy ;
        if (theme == LZLost) {
            [self.APIString appendString:@"/lost"];
        }
        else{
            [self.APIString appendString:@"/found"];
        }
        if([title isEqualToString:@"全部"]){
            [self.APIString appendString:@"/all"];
        }
        else{
            [self.APIString appendString:[NSString stringWithFormat:@"/%@",title.stringByURLEncode]];

        }
    }
    return self;
}

- (void)networkLoadData:(NSInteger)place{
    NSString *path;
    if (place==header) {
        path = self.APIString;
    }
    else{
        path = self.nextPageString;
    }
    if (path==nil) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
        return;
    }
    [[HttpClient defaultClient] requestWithPath:path method:HttpRequestGet parameters:nil prepareExecute:nil progress:^(NSProgress *progress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {

        if (place == header) {
            self.itemArray = [NSMutableArray array];
            [self.tableView.mj_header endRefreshing];
            self.tableView.mj_footer.hidden = NO;
        }
        for (NSDictionary *dic in [responseObject objectForKey:@"data"]) {
            [self.itemArray addObject:[[LostItem alloc]initWithDic:dic]];
        }
        self.nextPageString = [responseObject objectForKey:@"next_page_url"];
        if (self.nextPageString == nil) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        else{
            [self.tableView.mj_footer endRefreshing];
        }
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"您的网络不给力!";
        [hud hide:YES afterDelay:1];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.estimatedRowHeight = 100.f;
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.tableView.mj_footer.hidden = YES;
        [self networkLoadData:header];
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self networkLoadData:footer];
    }];
    [self.tableView.mj_header beginRefreshing];
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
    if (self.theme == LZFound) {
        [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://hongyan.cqupt.edu.cn%@",item.wx_avatar]]];
    }
    else{
        [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:item.wx_avatar]];
    }
    cell.timeLabel.text = item.created_at;
    cell.categoryLabel.text = item.pro_name;
    cell.nameLabel.text = item.connect_name;
    
    
    // Configure the cell...
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
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
