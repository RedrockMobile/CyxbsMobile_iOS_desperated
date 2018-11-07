//
//  SYCOrganizationTableViewController.m
//  MoblieCQUPT_iOS
//
//  Created by 施昱丞 on 2018/8/16.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "SYCOrganizationTableViewController.h"
#import "SYCOrganizationTableViewCell.h"
#import "SYCDetailTableViewCell.h"
#import "SYCOrganizationManager.h"


@interface SYCOrganizationTableViewController ()

@property (nonatomic)Boolean isShowDetail;


@end

@implementation SYCOrganizationTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, HEADERHEIGHT, SCREENWIDTH, self.tableView.frame.size.height + HEADERHEIGHT)];
    
    [self.tableView registerClass:[SYCOrganizationTableViewCell class] forCellReuseIdentifier:@"reuseIdentifier"];
    
    self.tableView.backgroundColor = [UIColor colorWithRed:246.0/255.0 green:246.0/255.0 blue:246.0/255.0 alpha:1.0];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    self.isShowDetail = NO;
    [self.tableView setContentInset:UIEdgeInsetsMake(-SCREENHEIGHT * 0.01, 0, 0, 0)];
    

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
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    SYCOrganizationModel *detailText = [SYCOrganizationManager sharedInstance].organizationData[self.index];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH * 0.9025, 0)];
    label.text = detailText.detail;
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:16 weight:UIFontWeightBold];
    [label sizeToFit];
    
    if (self.isShowDetail == YES) {
        return label.size.height * 1.2 + SCREENWIDTH * 0.50625 + 350;
    }else{
        return SCREENHEIGHT * 0.7;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.isShowDetail == YES) {
        SYCDetailTableViewCell *cell = [[SYCDetailTableViewCell alloc] init];
        cell.organization = self.organization;
        return cell;
    }else{
        SYCOrganizationTableViewCell *cell = [[SYCOrganizationTableViewCell alloc] init];
        cell.organization = self.organization;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.isShowDetail = !self.isShowDetail;
    
    [tableView reloadData];
    [UIView transitionWithView:tableView duration:0.5f options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        [tableView reloadData];
    } completion:nil];
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
