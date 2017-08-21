//
//  AddRemindViewController.m
//  Demo
//
//  Created by 李展 on 2016/11/26.
//  Copyright © 2016年 zhanlee. All rights reserved.
//

#import "AddRemindViewController.h"
#import "RemindTableViewCell.h"
#import "TimeChooseViewController.h"
#import "WeekChooseViewController.h"
#import "TimeChooseScrollView.h"
#import "TimeHandle.h"
#import "TickButton.h"
#import "CoverView.h"
#import "RemindNotification.h"
#import "UIFont+AdaptiveFont.h"
@interface AddRemindViewController ()<UITableViewDelegate,UITableViewDataSource,SaveDelegate,UITextFieldDelegate>
@property TimeChooseScrollView *remindChooseView;
@property NSMutableArray <NSString *>*contentArray;
@property BOOL isShowRemindChooseView;
@property TickButton *selectedButton;
@property TimeChooseViewController *timeChoose;
@property WeekChooseViewController *weekChoose;
@property NSMutableArray <NSNumber *>*timeArray;
@property NSNumber *time;
@property NSMutableArray *weekArray;
@property CoverView *coverView;
@property BOOL isEditing;
@property NSDictionary *remind;
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *contentTextField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSNumber *idNum;
@property NSArray *titleArray;
@property NSArray *imageArray;
@end

@implementation AddRemindViewController
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [textField becomeFirstResponder];
}

- (instancetype)initWithRemind:(NSDictionary *)remind{
    self = [self init];
    if (self) {
        self.remind = remind;
        self.isEditing = YES;
    }
    return self;
}

- (void)loadViewWithRemind:(NSDictionary *)remind{
    if (remind != nil) {
        self.isEditing = YES;
        self.idNum = [remind objectForKey:@"id"];
        self.titleTextField.text = [remind objectForKey:@"title"];
        self.contentTextField.text = [remind objectForKey:@"content"];
        NSArray *dateArray = [remind objectForKey:@"date"];
        self.timeArray = [NSMutableArray array];
        for (int i = 0; i<dateArray.count; i++) {
            self.weekArray = [dateArray[i] objectForKey:@"week"];
            NSInteger timeCount = [[dateArray[i] objectForKey:@"day"] integerValue]*LONGLESSON+[[dateArray[i] objectForKey:@"class"] integerValue];
            [self.timeArray addObject:@(timeCount)];
        }
        self.time = [remind objectForKey:@"time"];
        NSArray *array = @[@0,@5,@10,@20,@30,@60];
        if (self.time == nil) {
            self.time = array[0];
            self.selectedButton = self.remindChooseView.btnArray[0];
        }
        else {
            for (int i = 1;i<array.count;i++) {
                if ([array[i] isEqual:self.time]) {
                    self.selectedButton = self.remindChooseView.btnArray[i];
                    break;
                }
            }
        }
        self.selectedButton.selected = YES;
        self.contentArray[0] = [TimeHandle handleTimes:self.timeArray];
        self.contentArray[1] = [TimeHandle handleWeeks:self.weekArray];
        self.contentArray[2] = self.selectedButton.currentTitle;
        [self.tableView reloadData];
    }
    else{
        NSMutableArray *weeks = [@[[[NSUserDefaults standardUserDefaults] objectForKey:@"nowWeek"] ] mutableCopy];
        [self saveWeeks: weeks];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
     self.imageArray = @[@"remind_image_week",@"remind_image_time",@"remind_image_remind"];
    self.titleArray = @[@"周数",@"时间",@"提醒"];
    
    [[RemindNotification shareInstance]creatIdentifiers];
    self.title = @"事项编辑";
    self.titleTextField.delegate = self;
    self.contentTextField.delegate = self;
    self.coverView = [[CoverView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    __weak AddRemindViewController *weakSelf = self;
    self.coverView.passTap = ^(NSSet *touches,UIEvent *event){
        [weakSelf touchesBegan:touches withEvent:event];
    };
    self.contentArray = [NSMutableArray arrayWithArray:@[@"",@"",@""]];
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.scrollEnabled = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UIBarButtonItem *saveItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"remind_image_confirm"] style:UIBarButtonItemStyleDone target:self action:@selector(saveRemind)];
    self.navigationItem.rightBarButtonItem = saveItem;
    
    self.remindChooseView = [[TimeChooseScrollView alloc]initWithFrame:CGRectMake(0, SCREENHEIGHT/12*7.f, SCREENWIDTH, SCREENHEIGHT/12*5.f)];
    for (int i = 0; i<self.remindChooseView.btnArray.count; i++) {
        [self.remindChooseView.btnArray[i] addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    CGRect frame = self.remindChooseView.frame;
    frame.origin.y = SCREENHEIGHT;
    frame.size.height = 1;
    self.remindChooseView.frame = frame;
    self.isShowRemindChooseView = NO;
    self.isEditing = NO;
    
    [self loadViewWithRemind:self.remind];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RemindTableViewCell *cell = [[NSBundle mainBundle] loadNibNamed:@"RemindTableViewCell" owner:self options:nil][0];
//    [cell layoutIfNeeded];
    NSInteger index = indexPath.row;
    cell.titleLabel.text = self.titleArray[index];
    cell.contentLabel.text = self.contentArray[index];
    cell.cellImageView.image = [UIImage imageNamed:self.imageArray[index]];
//    switch (indexPath.row) {
//        case 0:
//            cell.titleLabel.text = @"时间";
//            cell.contentLabel.text = self.contentArray[0];
//            break;
//        case 1:
//            cell.titleLabel.text = @"周数";
//            cell.contentLabel.text = self.contentArray[1];
//            break;
//        case 2:
//            cell.titleLabel.text = @"提醒";
//            cell.contentLabel.text = self.contentArray[2];
//            cell.preservesSuperviewLayoutMargins = NO;
//            cell.layoutMargins = UIEdgeInsetsZero;
//            cell.separatorInset = UIEdgeInsetsMake(0, SCREENWIDTH, 0, 0); //去除最后一条分割线
//            break;
//        default:
//            break;
//    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return tableView.height/self.contentArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.titleTextField resignFirstResponder];
    [self.contentTextField resignFirstResponder];
    switch (indexPath.row) {
        case 0:
            self.timeChoose = [[TimeChooseViewController alloc]initWithTimeArray:self.timeArray];
            self.timeChoose.delegate = self;
            [self.navigationController pushViewController:self.timeChoose animated:YES];
            break;
        case 1:
            self.weekChoose = [[WeekChooseViewController alloc]initWithTimeArray:self.weekArray];
            self.weekChoose.delegate = self;
            [self.navigationController pushViewController:self.weekChoose animated:YES];
            break;
        case 2:
            [self remindChooseViewAnimated];
            break;
        default:
            break;
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if(self.isShowRemindChooseView){
        [self remindChooseViewAnimated];
    }
    [self.titleTextField resignFirstResponder];
    [self.contentTextField resignFirstResponder];
}

- (void)remindChooseViewAnimated{
    if (self.isShowRemindChooseView == YES) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect frame = self.remindChooseView.frame;
            frame.origin.y = SCREENHEIGHT;
            frame.size.height = 1;
            self.remindChooseView.frame = frame;
        }completion:^(BOOL finished) {
            self.isShowRemindChooseView = NO;
            [self.remindChooseView removeFromSuperview];
            [self.coverView removeFromSuperview];
        }];
    }
    else{
        [self.view.window addSubview:self.coverView];
        [self.view.window addSubview:self.remindChooseView];
        [UIView animateWithDuration:0.3 animations:^{
            self.remindChooseView.frame = CGRectMake(0, SCREENHEIGHT/12*7.f, SCREENWIDTH, SCREENHEIGHT/12*5);
        }completion:^(BOOL finished) {
            self.isShowRemindChooseView = YES;
        }];
    }

}
- (void)click:(TickButton *)sender{
    NSArray *array = @[@0,@5,@10,@20,@30,@60];
    if (![sender isEqual:self.selectedButton]) {
        self.selectedButton.selected = NO;
    }
    self.selectedButton = sender;
    self.time = array[sender.tag];
    self.contentArray[2] = sender.currentTitle;
    [self remindChooseViewAnimated];
    [self.tableView reloadData];
}

- (void)saveWeeks:(NSMutableArray *)weekArray{
    self.contentArray[1] = [TimeHandle handleWeeks:weekArray];
    self.weekArray = weekArray;
    [self.tableView reloadData];
}

- (void)saveTimes:(NSMutableArray *)timeArray{
    self.timeArray = timeArray;
    self.contentArray[0] = [TimeHandle handleTimes:timeArray];
    [self.tableView reloadData];
}


- (void)saveRemind{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"哎呀" message:@"你漏了点信息哦" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:action];
    for (int i = 0; i<self.contentArray.count; i++) {
        if ([self.contentArray[i] isEqualToString:@""]) {
            [self presentViewController:alertController animated:YES completion:nil];
            return;
        }
    }
    if([self.titleTextField isEqual:@""] ||[self.time isEqual:nil] || self.weekArray.count == 0){
        [self presentViewController: alertController animated:YES completion:nil];
        return;
    }
    else{
        [self postRemind];
        [self.navigationController popViewControllerAnimated:YES];
    }
}


- (void)postRemind{
    NSMutableString *idString = [NSMutableString stringWithFormat:@"%ld",(long)([[NSDate date] timeIntervalSince1970]*1000)];
    [idString appendString:[NSString stringWithFormat:@"%d",arc4random()%10000]];
    NSNumber *identifier = [NSNumber numberWithInteger:idString.integerValue];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *stuNum = [defaults objectForKey:@"stuNum"];
    NSString *idNum = [defaults objectForKey:@"idNum"];
    
    NSMutableString *weekString = [[self.contentArray[1] stringByReplacingOccurrencesOfString:@"周" withString:@""] mutableCopy];
    weekString = [[weekString stringByReplacingOccurrencesOfString:@"、" withString:@","] mutableCopy];
    
    NSMutableArray *dateArray = [NSMutableArray array];
    for (int i = 0; i<self.timeArray.count; i++) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setValue:weekString forKey:@"week"];
        [dic setValue:@(self.timeArray[i].integerValue%(LONGLESSON)) forKey:@"class"];
        [dic setValue:@(self.timeArray[i].integerValue/(LONGLESSON)) forKey:@"day"];
        [dateArray addObject:dic];
    }
    
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *remindPath = [path stringByAppendingPathComponent:@"remind.plist"];
    NSString *failurePath = [path stringByAppendingPathComponent:@"failure.plist"];
    NSMutableArray *reminds = [NSMutableArray arrayWithContentsOfFile:remindPath];
    if(reminds == nil){
        reminds = [NSMutableArray array];
    }
    NSMutableArray *date = [NSMutableArray array];
    for (int i = 0; i < self.timeArray.count; i++) {
        NSNumber *classNum = @(self.timeArray[i].integerValue%(LONGLESSON));
        NSNumber *dayNum = @(self.timeArray[i].integerValue/(LONGLESSON));
        NSArray *week = self.weekArray;
        NSDictionary *dateDic = @{@"class":classNum,@"day":dayNum,@"week":week};
        [date addObject:dateDic];
    }
    NSMutableDictionary *remind = [@{
                                     @"stuNum":stuNum,
                                     @"idNum":idNum,
                                     @"title":self.titleTextField.text,
                                     @"content":self.contentTextField.text,
                                     @"date":date,
                                     } mutableCopy];
    if (![self.time isEqual:@0]) {
        [remind setObject:self.time forKey:@"time"];
    }
    
    
    NSMutableDictionary *parameters = [@{
                                         @"stuNum":stuNum,
                                         @"idNum":idNum,
                                         @"date":dateArray,
                                         @"time":self.time,
                                         @"title":self.titleTextField.text,
                                         @"content":self.contentTextField.text,
                                         } mutableCopy];
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dateArray options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSMutableDictionary *jsonParameters = [@{
                                         @"stuNum":stuNum,
                                         @"idNum":idNum,
                                         @"date":jsonString,
                                         @"time":self.time,
                                         @"title":self.titleTextField.text,
                                         @"content":self.contentTextField.text,
                                         } mutableCopy];
    NSLog(@"%@",jsonParameters);
    HttpClient *client = [HttpClient defaultClient];
    if (!_isEditing) {
        [parameters setValue:identifier forKey:@"id"];
        [jsonParameters setValue:identifier forKey:@"id"];
        [remind setValue:identifier forKey:@"id"];
        [reminds addObject:remind];
        if([reminds writeToFile:remindPath atomically:YES]){
            NSNotificationCenter *center= [NSNotificationCenter defaultCenter];
            [center postNotificationName:@"addRemind" object:identifier];
            [[RemindNotification shareInstance]addNotifictaion];
        }
        [client requestWithPath:ADDREMINDAPI method:HttpRequestPost parameters:jsonParameters prepareExecute:^{
            
        } progress:^(NSProgress *progress) {
            
        } success:^(NSURLSessionDataTask *task, id responseObject) {
            NSLog(@"%@",responseObject);
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"%@",error);
            NSMutableArray *failureRequests = [NSMutableArray arrayWithContentsOfFile:failurePath];
            if(failureRequests == nil){
                failureRequests = [NSMutableArray array];
            }
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setObject:parameters forKey:@"parameters"];
            [dic setObject:@"add" forKey:@"type"];
            [failureRequests addObject:dic];
            [failureRequests writeToFile:failurePath atomically:YES];
        }];
    }
    else{
        [parameters setValue:self.idNum forKey:@"id"];
        [jsonParameters setValue:self.idNum forKey:@"id"];
        [remind setValue:self.idNum forKey:@"id"];
        for (NSDictionary *remindDic in reminds) {
            if ([[remindDic objectForKey:@"id"]isEqual:self.idNum]) {
                [reminds removeObject:remindDic];
                break;
            }
        }
        [reminds addObject:remind];
        if([reminds writeToFile:remindPath atomically:YES]){
            [[NSNotificationCenter defaultCenter] postNotificationName:@"editRemind" object:self.idNum];
             [[RemindNotification shareInstance]updateNotificationWithIdetifiers:self.idNum.stringValue];
        }
        [client requestWithPath:EDITREMINDAPI method:HttpRequestPost parameters:jsonParameters prepareExecute:^{
            
        } progress:^(NSProgress *progress) {
            
        } success:^(NSURLSessionDataTask *task, id responseObject) {
            NSLog(@"%@",responseObject);
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSMutableArray *failureRequests = [NSMutableArray arrayWithContentsOfFile:failurePath];
            if(failureRequests == nil){
                failureRequests = [NSMutableArray array];
            }
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setObject:parameters forKey:@"parameters"];
            [dic setObject:@"edit" forKey:@"type"];
            [failureRequests addObject:dic];
            [failureRequests writeToFile:failurePath atomically:YES];
        }];
    }
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
