//
//  IssueTableViewController.m
//  MoblieCQUPT_iOS
//
//  Created by 李展 on 2017/3/13.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import "IssueTableViewController.h"
#import "IconTableViewCell.h"
#import <Masonry.h>
#import "LostAndFoundButton.h"
@interface IssueTableViewController ()
@property NSMutableArray *imageArray;
@property LostAndFoundButton *lostBtn;
@property LostAndFoundButton *foundBtn;
@end

@implementation IssueTableViewController


- (void)viewDidLayoutSubviews{
    self.foundBtn.layer.cornerRadius = self.foundBtn.frame.size.width/2;

    self.lostBtn.layer.cornerRadius = self.lostBtn.frame.size.width/2;
    self.foundBtn.layer.masksToBounds = YES;
    self.lostBtn.layer.masksToBounds = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageArray = [NSMutableArray array];
    NSArray *imageNameArray = @[@"lost_image_infocategory",@"lost_image_itemcategory",@"lost_image_describe",@"lost_image_time",@"lost_image_place",@"lost_image_tel",@"lost_image_QQ"];
    for (int i = 0; i<imageNameArray.count; i++) {
        [self.imageArray addObject:[UIImage imageNamed:imageNameArray[i]]];
    }
    [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 16, 0, 16)];
    
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 8;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *array = @[@"信息分类",@"物品分类",@"描        述",@"时        间",@"地        点",@"电        话",@"Q         Q"];
    NSInteger index = indexPath.row;
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (index<7) {
        IconTableViewCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"IconTableViewCell" owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.iconImageView.image = self.imageArray[index];
        cell.titleLabel.text = array[index];
        if (index == 0) {
            [cell.contentLabel removeFromSuperview];
            self.lostBtn = [[LostAndFoundButton alloc]initWithFrame:CGRectMake(10, 10, 40, 40)];
            [self.lostBtn setTitle:@"寻物" forState:UIControlStateNormal];
             self.foundBtn = [[LostAndFoundButton alloc]initWithFrame:CGRectMake(20, 20, 40, 40)];
            [self.foundBtn setTitle:@"招领" forState:UIControlStateNormal];
            [cell addSubview:self.lostBtn];
            [cell addSubview:self.foundBtn];
            [self.foundBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(cell).offset(-16);
                make.top.equalTo(cell).offset(8);
                make.bottom.equalTo(cell).offset(-8);
                make.width.equalTo(self.foundBtn.mas_height);
            }];
            [self.lostBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.equalTo(self.foundBtn);
                make.centerY.equalTo(self.foundBtn.mas_centerY);
                make.right.equalTo(self.foundBtn.mas_left).with.offset(-10);
            }];
        }
        if(index == 1 || index == 3){
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        return cell;
    }
    else{
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 10, 10)];
        btn.layer.cornerRadius = 5;
        btn.layer.masksToBounds = YES;
        [btn addTarget:self action:@selector(issueInfo) forControlEvents:UIControlEventTouchUpInside];
        [btn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"#41a3ff"]] forState:UIControlStateNormal];
        [btn setTitle:@"发布信息" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [cell addSubview:btn];
        UIEdgeInsets padding = UIEdgeInsetsMake(16, 16, 16, 16);
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell).with.insets(padding);
        }];
        
    }
    return cell;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.view.height/8;
}

- (void)issueInfo{
    
}

- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger index = indexPath.row;
    if (index==1){
        
    }
    if (index==3) {
        
    }
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
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
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
