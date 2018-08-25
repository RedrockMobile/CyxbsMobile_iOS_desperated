//
//  SYCCollageTableViewController.m
//  CQUPTDataAnalyse
//
//  Created by 施昱丞 on 2018/8/10.
//  Copyright © 2018年 shiyucheng. All rights reserved.
//

#import "SYCCollageTableViewController.h"
#import "SYCCollageModel.h"
#import "SYCCollageDataManager.h"
#import "SYCSexRatioViewController.h"
#import "SYCDataAnaylseViewController.h"
#import "SYCCollageTableViewCell.h"

@interface SYCCollageTableViewController ()

@property (nonatomic, strong) NSArray *collageNameArray;
@property (nonatomic, strong) NSDictionary *collageData;

@end

@implementation SYCCollageTableViewController

@synthesize collageNameArray;

- (void)viewDidLoad {
    [super viewDidLoad];

    [SYCCollageDataManager sharedInstance];
    self.collageNameArray = [[NSKeyedUnarchiver unarchiveObjectWithFile:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"nameList.archiver"]] objectForKey:@"name"];
    self.collageData = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"collageData.archiver"]];
    
    
    [self.tableView registerClass:[SYCCollageTableViewCell class] forCellReuseIdentifier:@"SYCCollageTableViewCell"];
    self.title = @"学院选择";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData:) name:@"DataDownloadDone" object:nil];
    self.tabBarController.tabBar.hidden = YES;
    self.view.backgroundColor = [UIColor colorWithRed:246.0/255.0 green:246.0/255.0 blue:246.0/255.0 alpha:1.0];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView setContentInset:UIEdgeInsetsMake(SCREENHEIGHT * 0.008, 0, 0, 0)];
}

- (void)reloadData:(NSNotification *)notifacation{
    self.collageNameArray = [[NSKeyedUnarchiver unarchiveObjectWithFile:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"nameList.archiver"]] objectForKey:@"name"];
    self.collageData = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"collageData.archiver"]];
    
    [self.tableView reloadData];
}

  
- (instancetype)init
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [collageNameArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SYCCollageTableViewCell *cell = [[SYCCollageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SYCCollageTableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.collageName = collageNameArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SYCDataAnaylseViewController *dataAnalyseVC = [[SYCDataAnaylseViewController alloc] init];
    dataAnalyseVC.data = [self.collageData objectForKey:[collageNameArray objectAtIndex:[indexPath row]]];
    
    [self.navigationController pushViewController:dataAnalyseVC animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SCREENHEIGHT * 0.08;
}

@end
