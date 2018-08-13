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

@interface SYCCollageTableViewController ()

@property (nonatomic, strong) NSArray *collageNameArray;
@property (nonatomic, strong) NSDictionary *collageData;
@property (nonatomic, strong) SYCCollageDataManager *dataStore;

@end

@implementation SYCCollageTableViewController

@synthesize collageNameArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataStore = [SYCCollageDataManager sharedInstance];
    
    self.collageNameArray = [[NSKeyedUnarchiver unarchiveObjectWithFile:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"nameList.archiver"]] objectForKey:@"name"];
    self.collageData = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"collageData.archiver"]];

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData:) name:@"DataDownloadDone" object:nil];
    
    self.title = @"学院选择";
    self.callBackHandle();
}

- (void)reloadData:(NSNotification *)notifacation{
    self.collageNameArray = [[NSKeyedUnarchiver unarchiveObjectWithFile:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"nameList.archiver"]] objectForKey:@"name"];
    self.collageData = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"collageData.archiver"]];
    
    NSLog(@"%@", self.collageData);
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
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    
    cell.textLabel.text = collageNameArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SYCDataAnaylseViewController *dataAnalyseVC = [[SYCDataAnaylseViewController alloc] init];

    dataAnalyseVC.data = [self.collageData objectForKey:[collageNameArray objectAtIndex:[indexPath row]]];
    
        [self.navigationController pushViewController:dataAnalyseVC animated:YES];
    
}
@end
