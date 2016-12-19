//
//  DetailRemindViewController.m
//  Demo
//
//  Created by 李展 on 2016/12/2.
//  Copyright © 2016年 zhanlee. All rights reserved.
//

#import "DetailRemindViewController.h"
#import "DetailRemindTableViewCell.h"
#import "PrefixHeader.pch"
#import "TimeHandle.h"
#import "UIColor+Hex.h"
#import "HttpClient.h"
#import "AddRemindViewController.h"
#import <Masonry.h>
#import "RemindNotification.h"

@interface DetailRemindViewController ()<UITableViewDelegate,UITableViewDataSource>
@property NSMutableArray <RemindMatter *>* reminds;
@property UITableView *tableView;
@property BOOL isEditing;
@property NSString *remindPath;
@property NSString *failurePath;
@property NSMutableArray *imageViewArray;
@property UIButton *editButton;

@end

@implementation DetailRemindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    self.remindPath = [path stringByAppendingPathComponent:@"remind.plist"];
    self.failurePath = [path stringByAppendingPathComponent:@"failure.plist"];
    
    self.imageViewArray = [NSMutableArray array];
    self.isEditing = NO;
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, STATUSBARHEIGHT+NVGBARHEIGHT, SCREENWIDTH, SCREENHEIGHT-STATUSBARHEIGHT-NVGBARHEIGHT) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = NO;
    self.tableView.allowsSelectionDuringEditing = YES;
    self.tableView.backgroundColor = [UIColor colorWithHex:@"#f5f5f5"];
    [self.view addSubview:self.tableView];
    if(self.reminds.count == 0){
        [self showNoRemindView];
    }
}
- (void)viewWillAppear:(BOOL)animated{
    self.editButton.selected = NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)edit:(UIButton *)sender{
    if (sender != nil) {
        self.editButton = sender;
    }
    sender.selected = !sender.selected;
    self.isEditing = !self.isEditing;
    [self.tableView setEditing:!self.tableView.editing animated:YES];
    [UIView animateWithDuration:0.5f animations:^{
        for (UIImageView * editView in self.imageViewArray) {
            if (self.isEditing) {
                editView.alpha = 1;
            }
            else{
                editView.alpha = 0;
            }
        }
    }];
}

- (instancetype)initWithRemindMatters:(NSArray *)reminds{
    self = [self init];
    if(self){
        self.reminds = [NSMutableArray array];
        self.reminds = reminds.mutableCopy;
    }
    return self;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.reminds.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell" ;
    DetailRemindTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
    if (!cell)
    {
        cell = [[NSBundle mainBundle]loadNibNamed:@"DetailRemindTableViewCell" owner:self options:nil][0];
    }
    [self.imageViewArray addObject:cell.editView];
    NSInteger index = indexPath.section;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSMutableArray *reminds = [NSMutableArray arrayWithContentsOfFile:self.remindPath];
    NSDictionary *remind = [NSDictionary dictionary];
    for (NSDictionary *dic in reminds) {
        NSNumber *idNum = [dic objectForKey:@"id"];
        if ([self.reminds[index].idNum isEqual:idNum]) {
            remind = [dic copy];
            break;
        }
    }
    cell.titleLabel.text = [remind objectForKey:@"title"];
    cell.contentLabel.text = [remind objectForKey:@"content"];
    NSNumber *time = [remind objectForKey:@"time"];
    if(time){
        cell.remindTimeLabel.text = [NSString stringWithFormat:@"%@分钟前",time];
        cell.clockImageView.image = [UIImage imageNamed:@"提醒"];
    }
    else{
        cell.remindTimeLabel.text = @"不提醒";
        cell.clockImageView.image = [UIImage imageNamed:@"不提醒"];
    }
    NSMutableArray *timeArray = [NSMutableArray array];
    NSArray *weekArray = [NSArray array];
    for (NSDictionary *date in [remind objectForKey:@"date"]) {
        weekArray = [date objectForKey:@"week"];
        NSNumber *time = @([[date objectForKey:@"day"] integerValue]*LONGLESSON+[[date objectForKey:@"class"] integerValue]);
        [timeArray addObject:time];
    }
    cell.weekLabel.text = [NSString stringWithFormat:@"第%@",[TimeHandle handleWeeks:weekArray]];
    cell.timeLabel.text = [TimeHandle handleTimes:timeArray];
    if(indexPath.section == self.reminds.count-1){
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(20, cell.frame.size.height, 4, 100)];
        view.backgroundColor = [UIColor whiteColor];
        [cell addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(cell.straightLine.mas_bottom);
            make.width.equalTo(cell.straightLine);
            make.centerX.equalTo(cell.straightLine);
            make.height.equalTo(@(CGFLOAT_MAX));
        }];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger index = indexPath.section;
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *remindPath = [path stringByAppendingPathComponent:@"remind.plist"];
    NSMutableArray *reminds = [NSMutableArray arrayWithContentsOfFile:remindPath];
    NSDictionary *remind;
    for (NSDictionary *dic in reminds) {
        NSNumber *idNum = [dic objectForKey:@"id"];
        if ([self.reminds[index].idNum isEqual:idNum]) {
            remind = dic;
            break;
        }
    }
   NSString *content = [remind objectForKey:@"content"];
    return [content boundingRectWithSize:CGSizeMake(SCREENWIDTH-56,CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil].size.height+120;
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    self.isEditing = NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *stuNum = [defaults objectForKey:@"stuNum"];
    NSString *idNum = [defaults objectForKey:@"idNum"];
    NSInteger index = indexPath.section;
    NSNumber *identifier = self.reminds[index].idNum;
    NSMutableArray *reminds = [NSMutableArray arrayWithContentsOfFile:self.remindPath];
    if(reminds == nil){
        reminds = [NSMutableArray array];
    }
    for (NSDictionary *remind in reminds) {
        if ([[remind objectForKey:@"id"] isEqual:identifier]) {
            [reminds removeObject:remind];
            break;
        }
    }
    [self.reminds removeObjectAtIndex:index];
    if([reminds writeToFile:self.remindPath atomically:YES]){
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        [center postNotificationName:@"deleteRemind" object:identifier];
//        [[[RemindNotification alloc]init] deleteNotificationAndIdentifiers];
    }
    HttpClient *client = [HttpClient defaultClient];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:stuNum forKey:@"idNum"];
    [parameters setObject:idNum forKey:@"stuNum"];
    [parameters setObject:identifier forKey:@"id"];
    
    [client requestWithPath:DELETEREMINDAPI method:HttpRequestPost parameters:parameters prepareExecute:^{
        
    } progress:^(NSProgress *progress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
        NSMutableArray *failureRequests = [NSMutableArray arrayWithContentsOfFile:self.failurePath];
        if(failureRequests == nil){
            failureRequests = [NSMutableArray array];
        }
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:parameters forKey:@"parameters"];
        [dic setObject:@"delete" forKey:@"type"];
        [failureRequests addObject:dic];
        [failureRequests writeToFile:self.failurePath atomically:YES];
    }];
    [tableView reloadData];

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(self.isEditing){
        NSMutableArray *reminds = [NSMutableArray arrayWithContentsOfFile:self.remindPath];
        for (NSDictionary *remind in reminds) {
            if ([[remind objectForKey:@"id"] isEqual:self.reminds[indexPath.section].idNum]) {
                AddRemindViewController *vc = [[AddRemindViewController alloc]initWithRemind:remind];
                [self addChildViewController:vc];
                [self.navigationController pushViewController:vc animated:YES];
                [vc didMoveToParentViewController:self];
                break;
            }
        }
        [self edit:nil];
    }
}

- (void)showNoRemindView{
    [self.tableView removeFromSuperview];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(MWIDTH, SCREENHEIGHT/6+STATUSBARHEIGHT+NVGBARHEIGHT, SCREENWIDTH-2*MWIDTH, SCREENWIDTH/2)];
    imageView.image = [UIImage imageNamed:@"无事项"];
    [self.view addSubview:imageView];
}

- (void)reloadWithRemindMatters:(NSArray *)reminds{
    self.reminds = [reminds mutableCopy];
    [self.tableView reloadData];
    if(self.reminds.count == 0){
        [self showNoRemindView];
    }
}
@end
