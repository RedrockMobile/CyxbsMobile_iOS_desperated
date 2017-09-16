//
//  ExamGradeViewController.m
//  MoblieCQUPT_iOS
//
//  Created by GQuEen on 16/3/4.
//  Copyright © 2016年 Orange-W. All rights reserved.
//

#import "ExamGradeViewController.h"
#import "GradeView.h"
#import "LoginEntry.h"
#import "MBProgressHUD.h"

#define GRADEAPI @"http://hongyan.cqupt.edu.cn/api/examGrade"

@interface ExamGradeViewController ()

@property (assign, nonatomic) CGFloat kHeight;
@property (assign, nonatomic) CGFloat fontSize;

@property (strong, nonatomic) UIScrollView *scrollView;

@property (strong, nonatomic) UIView *topView;

@property (strong, nonatomic) MBProgressHUD *hub;

@end

@implementation ExamGradeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    UIColor *unKnow = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1.0];
    [self initUI];
    [self postGradeData];
    
    // Do any additional setup after loading the view from its nib.
}
- (void)initUI {
    _fontSize = 14;
    _kHeight = 50;
    
}

- (void)postGradeData {
    NSString *stuNum = [NSString stringWithFormat:@"%@",[UserDefaultTool getStuNum]];
    _hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _hub.labelText = @"正在加载...";
    [NetWork NetRequestPOSTWithRequestURL:GRADEAPI WithParameter:@{@"stuNum":stuNum} WithReturnValeuBlock:^(id returnValue) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        NSMutableArray *dataArray = returnValue[@"data"];
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64 - 50)];
        _scrollView.contentSize = CGSizeMake(ScreenWidth, (dataArray.count)*_kHeight);
        _scrollView.showsVerticalScrollIndicator = NO;
        [_scrollView flashScrollIndicators];
        [self.view addSubview:_scrollView];
        
        for (int i = 0; i < dataArray.count; i ++) {
            NSDictionary *dic = dataArray[i];
            GradeView *view = [[GradeView alloc]initWithFrame:CGRectMake(0, i*_kHeight, ScreenWidth, _kHeight - 1) titileWithDic:dic fontSize:_fontSize];
                view.backgroundColor = [UIColor whiteColor];

            [_scrollView addSubview:view];
        }
        
    } WithFailureBlock:^{
       [self initFailViewWithDetail:@"哎呀！网络开小差了 T^T"];
    }];
}
- (void)initFailViewWithDetail:(NSString *)string{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    UIImageView *failLoad = [[UIImageView alloc]initWithFrame:CGRectMake(0, 50, SCREENWIDTH, 250)];
    failLoad.contentMode = UIViewContentModeScaleAspectFit;
    failLoad.image = [UIImage imageNamed:@"emptyImage"];
    UILabel *detailLab= [[UILabel alloc]initWithFrame:CGRectMake(0, failLoad.bottom, SCREENWIDTH, 30)];
    detailLab.textAlignment = NSTextAlignmentCenter;
    detailLab.font = kFont;
    detailLab.textColor = [UIColor colorWithHexString:@"4B535B"];
    detailLab.text = string;
    [self.view addSubview:detailLab];
    [self.view addSubview:failLoad];
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
