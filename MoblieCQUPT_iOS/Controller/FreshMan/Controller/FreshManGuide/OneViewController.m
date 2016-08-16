//
//  OneViewController.m
//  FreshMan
//
//  Created by dating on 16/8/12.
//  Copyright © 2016年 dating. All rights reserved.
//

#import "OneViewController.h"
#import "OneTableViewCell.h"
#define  navigationBarFrame 66
#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r, g, b) RGBA(r, g, b, 1.0f)
#define MAIN_SCREEN_W [UIScreen mainScreen].bounds.size.width
#define MAIN_SCREEN_H [UIScreen mainScreen].bounds.size.height

#include "GGCellModel.h"
#include "GQUCell.h"

@interface OneViewController ()
@property UITableView  *tableView;
@property (strong, nonatomic) NSArray *Name;
@property (strong, nonatomic) NSArray *Content;
@property (strong, nonatomic) NSMutableArray *rectArray;
@property (strong, nonatomic) NSMutableArray<GGCellModel *> *modelArray;

@property  NSInteger LabelHight;
@end

@implementation OneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self Data];
    [self tableview];
    
    // Do any additional setup after loading the view.
}
-(void)Data{
    
    NSError *error = nil;
//    NSString *txtpath1 = [[NSBundle mainBundle] pathForResource:@"入学须知" ofType:@"txt"];
    NSString *txtpath2 = [[NSBundle mainBundle] pathForResource:@"安全须知" ofType:@"txt"];
//    NSString *txtpath3 = [[NSBundle mainBundle] pathForResource:@"奖学金设置" ofType:@"txt"];
//    NSString *txtpath4 = [[NSBundle mainBundle] pathForResource:@"学生手册节选" ofType:@"txt"];
//    NSString *RuXue = [NSString stringWithContentsOfFile:txtpath1 encoding:NSUTF8StringEncoding error:&error];
    NSString *AnQuan = [NSString stringWithContentsOfFile:txtpath2 encoding:NSUTF8StringEncoding error:&error];
//    NSString *JiangXueJin = [NSString stringWithContentsOfFile:txtpath3 encoding:NSUTF8StringEncoding error:&error];
//    NSString *XueSheng = [NSString stringWithContentsOfFile:txtpath4 encoding:NSUTF8StringEncoding error:&error];
    
    
    self.Content = [[NSArray alloc]init];
    self.Name = [[NSArray alloc]init];
    self.rectArray = [NSMutableArray array];
//    NSString *Name1 = @"入学须知";
    NSString *Name2 = @"安全须知";
//    NSString *Name3 = @"奖学金设置";
//    NSString *Name4 = @"学生手册节选";
    self.Name = @[Name2];
    self.Content = @[AnQuan];
    
    _modelArray = [NSMutableArray<GGCellModel *> array];
    for (int i = 0; i < 1; i++) {
        GGCellModel *model = [[GGCellModel alloc]initWithContentData:self.Content[i]];
        [_modelArray addObject:model];
    }
    
    
}
-(void)tableview{
    self.tableView = [[UITableView alloc]init];
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.tableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.frame = CGRectMake(0, 0, screenSize.width, screenSize.height-104);
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.modelArray[indexPath.row].cellHeigh;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GQUCell *cell = [GQUCell cellWithTableView:tableView];
        cell.headTitle = self.Name[indexPath.row];
    cell.model = self.modelArray[indexPath.row];
    cell.cellType = self.modelArray[indexPath.row].cellType;
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GQUCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell clickCell];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
