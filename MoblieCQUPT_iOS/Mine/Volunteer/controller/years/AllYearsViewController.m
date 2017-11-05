//
//  AllYearsViewController.m
//  MoblieCQUPT_iOS
//
//  Created by MaggieTang on 08/10/2017.
//  Copyright © 2017 Orange-W. All rights reserved.
//

#import "AllYearsViewController.h"
#import "HeaderTableViewCell.h"
#import "QueryTableViewCell.h"
#import "BackgroundTableViewCell.h"
#import "QueryModel.h"
#import "QueryDataModel.h"
#import "HeaderGifRefresh.h"
#import "HttpClient.h"
@interface AllYearsViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) NSMutableArray *mutArray;
//@property (strong, nonatomic) NSMutableArray *mutableArray;
@property (strong, nonatomic) UIImageView *noRecordImage;
@property (strong, nonatomic) NSString *hour;
@end
@implementation AllYearsViewController
#define REUESED_SIZE  100
static NSString *reUsedStr[REUESED_SIZE] = {nil}; // 重用标示
#define REUESED_FLAG  reUsedStr[0]
+ (void)initialize{
    if (self == [AllYearsViewController class]){
        for (int i = 0; i < REUESED_SIZE; i++){
            reUsedStr[i] = [NSString stringWithFormat:@"section_%d", i];
            if (i>=2) {
                reUsedStr[i] = [NSString stringWithFormat:@"section_2"];
            }
        }
    }
}
- (void)noRecord{
    NSMutableArray *array = self.mutableArray[0];
    NSMutableArray *array1 = self.mutableArray[1];
    NSMutableArray *array2 = self.mutableArray[2];
    NSMutableArray *array3 = self.mutableArray[3];
    self.noRecordImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_W, MAIN_SCREEN_H-64)];
    self.noRecordImage.image = [UIImage imageNamed:@"没有记录"];
    if (array.count== 0 && array1.count== 0 && array2.count== 0 && array3.count== 0) {
        [self.view addSubview:self.noRecordImage];
    }
    else if (array.count!= 0 || array1.count!= 0 ||array2.count!= 0 || array3.count!= 0){
        [self.view addSubview:self.tableView];
    }
}

- (void)setMutableArray:(NSArray *)mutableArray{
    _mutableArray = mutableArray;
    [self noRecord];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc]init];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,MAIN_SCREEN_W, MAIN_SCREEN_H-64-39) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    UIColor *backgroundColor = [UIColor colorWithRed:244/255.0 green:243/255.0 blue:243/255.0 alpha:1];
    self.tableView.backgroundColor = backgroundColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView reloadData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSUInteger row = 0;
    if (section == 0 || section == 1) {
        row = 1;
    }
    else if (section == 2 ){
        NSMutableArray *array = self.mutableArray[0];
        if (array!= nil) {
            row = array.count;
        }
    }
    else if (section == 3 ){
        NSMutableArray *array = self.mutableArray[1];
        if (array!= nil) {
            row = array.count;
        }
    }
    else if (section == 4 ){
        NSMutableArray *array = self.mutableArray[2];
        if (array!= nil) {
            row = array.count;
        }
    }
    else if (section == 5 ){
        NSMutableArray *array = self.mutableArray[3];
        if (array!= nil) {
            row = array.count;
        }
        
    }
    return row;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 6;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 ){
        BackgroundTableViewCell *cell = [[BackgroundTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reUsedStr[indexPath.section]];
        UIColor *myColor = [UIColor colorWithRed:244/255.0 green:243/255.0 blue:243/255.0 alpha:1];
        cell.backgroundColor = myColor;
        NSUserDefaults *hourDefault = [NSUserDefaults standardUserDefaults];
        NSString *hour = [[hourDefault objectForKey:@"totalhour"] stringValue];
        cell.backgroundLabel3.text = hour;
        cell.selected = false;
        return cell;
    }
    else if (indexPath.section == 1 ){
       HeaderTableViewCell *cell = [[HeaderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reUsedStr[indexPath.section]];
        UIColor *myColor = [UIColor colorWithRed:244/255.0 green:243/255.0 blue:243/255.0 alpha:1];
        cell.backgroundColor = myColor;
        cell.selected = false;
        return cell;
    }
    QueryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reUsedStr[indexPath.section]];
    if (cell == nil){
        cell = [[QueryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reUsedStr[indexPath.section]];
    }
    QueryModel *model = self.mutableArray[indexPath.section-2][indexPath.row];
    [cell.yearsImageView removeFromSuperview];
    [cell.yearsLabel removeFromSuperview];
    if (indexPath.row == 0) {
        NSDate  *currentDate = [NSDate date];
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:currentDate];
        NSInteger year=[components year];
        cell.yearsImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"年份圆圈"]];
        cell.yearsImageView.frame = CGRectMake(15, 0, 31, 31);
        [cell.contentView addSubview:cell.yearsImageView];
        [cell.contentView bringSubviewToFront:cell.yearsImageView];
        cell.yearsLabel = [[UILabel alloc]initWithFrame:CGRectMake(17, 9, 28, 11)];
        cell.yearsLabel.textColor = [UIColor whiteColor];
        cell.yearsLabel.text = [NSString stringWithFormat:@"%ld",year+2-indexPath.section];
        cell.yearsLabel.textAlignment = NSTextAlignmentCenter;
        cell.yearsLabel.font = [UIFont systemFontOfSize:11];
        cell.yearsLabel.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:cell.yearsLabel];
    }
    NSDate *date = [NSDate dateWithString:model.start_time format:@"yyyy-MM-dd"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"MM-dd"];
    cell.cellHourLabel.text = model.hours;
    cell.cellTimeLabel.text = [formatter stringFromDate:date];
    cell.cellAddressLabel.text = model.address;
    cell.cellContentLabel.text = model.content;
    cell.userInteractionEnabled = NO;
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *redLine = [[UIView alloc]init];
    if (section == 2 || section == 3 || section == 4 || section == 5) {
        redLine.frame = CGRectMake(29, 0, 3, 11);
        redLine.backgroundColor = [UIColor colorWithRed:253/255.0 green:105/255.0 blue:103/255.0 alpha:1];
    }
    if (section == 1) {
        redLine.backgroundColor = [UIColor colorWithRed:244/255.0 green:243/255.0 blue:243/255.0 alpha:1];
    }

    return redLine;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *redLine = [[UIView alloc]init];
    if ( section == 3 || section == 4 || section == 5) {
        redLine.frame = CGRectMake(29, 0, 3, 11);
        redLine.backgroundColor = [UIColor colorWithRed:253/255.0 green:105/255.0 blue:103/255.0 alpha:1];
    }
    if (section == 1 ||section == 2) {
        redLine.backgroundColor = [UIColor colorWithRed:244/255.0 green:243/255.0 blue:243/255.0 alpha:1];
    }
    return redLine;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    CGFloat headerHeight = 0;
    if(section == 2 || section == 3 || section == 4 || section == 5){
        headerHeight = 0;
    }
    if (section == 1) {
        headerHeight = 1;
    }
    if(section == 0){
        headerHeight = 0;
    }
    return headerHeight;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    CGFloat footerHeight = 0;
    if(section == 2 || section == 3 || section == 4 || section == 5){
        footerHeight = 0;
    }
    if (section == 1) {
        footerHeight = 5;
    }
    if(section == 0){
        footerHeight = 0;
    }
    return footerHeight;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat rowHeight = 0;
    if(indexPath.section == 0){
        rowHeight = 200;
    }
    if (indexPath.section == 1) {
        rowHeight = 20;
    }
    if (indexPath.section == 2 ||indexPath.section == 3 ||indexPath.section == 4 ||indexPath.section == 5 ) {
        rowHeight = 127;
    }
    return rowHeight;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
