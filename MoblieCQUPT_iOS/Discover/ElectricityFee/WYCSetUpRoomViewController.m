//
//  WYCSetUpRoomViewController.m
//  MoblieCQUPT_iOS
//
//  Created by 王一成 on 2019/4/2.
//  Copyright © 2019年 Orange-W. All rights reserved.
//

#import "WYCSetUpRoomViewController.h"
@interface WYCSetUpRoomViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (strong, nonatomic) IBOutlet UIImageView *backImgView;
@property (weak, nonatomic) IBOutlet UIView *tapToPickView;

@property (weak, nonatomic) IBOutlet UILabel *buildingNumLabel;
@property (weak, nonatomic) IBOutlet UITextField *roomNum;
@property (strong, nonatomic)UIPickerView *pickView;
@property (strong, nonatomic) NSArray *buildingName;
@property (strong, nonatomic) NSArray *buildingNum;
@end

@implementation WYCSetUpRoomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置寝室";
    NSMutableArray *imgArray = [NSMutableArray arrayWithCapacity:26];
    for (int i = 1; i < 27; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"settingRoomBackground-%i.png",i]];
        [imgArray addObject:image];
    }
    UIImage *img =  [UIImage animatedImageWithImages:imgArray duration:1.6];
    self.backImgView.image = img;
    
    self.tapToPickView.layer.borderWidth = 1;
    self.tapToPickView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.tapToPickView.layer.cornerRadius = 5;
    self.tapToPickView.layer.masksToBounds = YES;
    UIGestureRecognizer *tapToPickView = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(displayPickView)];
    [self.tapToPickView addGestureRecognizer:tapToPickView];

    self.buildingName = @[@"知行苑", @"兴业苑", @"四海苑", @"宁静苑",@"明理苑"];
    self.buildingNum = @[@"1舍", @"2舍", @"3舍", @"4舍",@"5舍",@"6舍",@"7舍",@"8舍",@"9舍"];
}

- (void)displayPickView{
    
    if ([[UIApplication sharedApplication].keyWindow viewWithTag:999]) {
        [[[UIApplication sharedApplication].keyWindow viewWithTag:999] removeFromSuperview];
    }
    //初始化全屏view
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
   
    //设置view的tag
    view.tag = 999;
     UIGestureRecognizer *tapToBack = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapToBack)];
    [view addGestureRecognizer:tapToBack];
    UIView *backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    backgroundView.backgroundColor = [UIColor blackColor];
    backgroundView.alpha = 0.6;
    
    [view addSubview:backgroundView];

    self.pickView = [[UIPickerView alloc]init];
    [self.pickView setFrame:CGRectMake(SCREEN_WIDTH/2 - 150, SCREEN_HEIGHT/2 - 100, 300, 200)];
    self.pickView.backgroundColor = [UIColor whiteColor];
    self.pickView.delegate = self;
    self.pickView.dataSource = self;
    [self.pickView reloadAllComponents];
    [view addSubview:self.pickView];
    
    //显示全屏view
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:view];
//    [UIView animateWithDuration:0.4f animations:^{
//        self.pickView.layer.opacity = 1.0f;
//    } completion:nil];
    
}
- (IBAction)confirmBtn:(UIButton *)sender {
    
    
    if (![self.buildingNumLabel.text isEqualToString:@""]&&![self.roomNum.text isEqualToString:@""]) {
        NSDictionary *dic = @{@"知行苑1舍":@"01",@"知行苑2舍":@"02",@"知行苑3舍":@"03",@"知行苑4舍":@"04",@"知行苑5舍":@"05",@"知行苑6舍":@"06",@"知行苑7舍":@"15",@"知行苑8舍":@"16",@"兴业苑1舍":@"17",@"兴业苑2舍":@"18",@"兴业苑3舍":@"19",@"兴业苑4舍":@"20",@"兴业苑5舍":@"21",@"兴业苑6舍":@"22",@"兴业苑7舍":@"23a",@"兴业苑8舍":@"23b",@"四海苑1舍":@"36",@"四海苑2舍":@"37",@"宁静苑1舍":@"08",@"宁静苑2舍":@"09",@"宁静苑3":@"10",@"宁静苑4舍":@"11",@"宁静苑5舍":@"12",@"宁静苑6舍":@"32",@"宁静苑7舍":@"33",@"宁静苑8舍":@"34",@"宁静苑9舍":@"35",@"明理苑1舍":@"24",@"明理苑2舍":@"25",@"明理苑3舍":@"26",@"明理苑4舍":@"27",@"明理苑5舍":@"28",@"明理苑6舍":@"29",@"明理苑8舍":@"30",@"明理苑8舍":@"31",@"明理苑9舍":@"39"};
        NSString *buildingNum = dic[self.buildingNumLabel.text];
        NSString *roomNum = self.roomNum.text;
        
        NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = pathArray[0];
        NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"RoomAndBuild.plist"];
        NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
        [data setObject:roomNum forKey:@"roomNum"];
        [data setObject:buildingNum forKey:@"buildingNum"];
        [data writeToFile:plistPath atomically:YES];
    }
    [[NSNotificationCenter defaultCenter]postNotificationName:@"reloadFeeData" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)tapToBack{
    NSInteger num1 = [self.pickView selectedRowInComponent:0];
    NSInteger num2 = [self.pickView selectedRowInComponent:1];
    NSString *str1 = self.buildingName[num1];
    NSString *str2 = self.buildingNum[num2];
    NSString *building = [NSString stringWithFormat:@"%@%@",str1,str2];
    self.buildingNumLabel.text = building;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIView *view = [window viewWithTag:999];
    [view removeFromSuperview];
    
}

#pragma mark Picker Data Source Methods
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return [self.buildingName count];
    } else {
        return [self.buildingNum count];
    }
}

#pragma mark Picker Delegate Methods
- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    if (component == 0) {
        return self.buildingName[row];
    } else {
        return self.buildingNum[row];
    }
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 40;
}
@end
