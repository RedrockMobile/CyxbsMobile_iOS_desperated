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

@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *grade;
@property (strong, nonatomic) UILabel *type;
@property (strong, nonatomic) UIScrollView *scrollView;

@property (strong, nonatomic) UIView *topView;

@property (strong, nonatomic) MBProgressHUD *hub;

@end

@implementation ExamGradeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self postGradeData];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)initUI {
    
    if (ScreenWidth == 320) {
        _fontSize = 13;
        _kHeight = 35;
    }else if (ScreenWidth == 375){
        _fontSize = 15;
        _kHeight = 40;
    }else {
        _fontSize = 17;
        _kHeight = 50;
    }
    
    _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, _kHeight)];
    _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 200, _kHeight)];
    _nameLabel.text = @"课程名称";
    _nameLabel.font = [UIFont systemFontOfSize:_fontSize];
    [_nameLabel sizeToFit];
    _nameLabel.frame = CGRectMake(20, 0, _nameLabel.frame.size.width, _kHeight);
    _nameLabel.textColor = MAIN_COLOR;
    
    _grade = [[UILabel alloc]initWithFrame:CGRectZero];
    _grade.text = @"成绩";
    _grade.font = [UIFont systemFontOfSize:_fontSize];
    [_grade sizeToFit];
    _grade.textColor = MAIN_COLOR;
    _grade.frame = CGRectMake(_topView.frame.size.width-_grade.frame.size.width-35, 0, _grade.frame.size.width, _kHeight);
    
    _type = [[UILabel alloc]initWithFrame:CGRectZero];
    _type.text = @"课程类型";
    _type.font = [UIFont systemFontOfSize:_fontSize];
    [_type sizeToFit];
    _type.textColor = MAIN_COLOR;
    _type.frame = CGRectMake(_grade.frame.origin.x-_type.frame.size.width-40, 0, _type.frame.size.width, _kHeight);
    
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight-_kHeight-10, ScreenWidth, _kHeight)];
    UILabel *bottomLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    bottomLabel.text = @"注:	学院没有注册的同学不能查到具体成绩";
    bottomLabel.font = [UIFont systemFontOfSize:_fontSize-2];
    bottomLabel.textColor = [UIColor colorWithRed:173/255.0 green:173/255.0 blue:173/255.0 alpha:1];
    [bottomLabel sizeToFit];
    bottomLabel.frame = CGRectMake(20, 0, bottomLabel.frame.size.width, _kHeight+10);
    
    [self.view addSubview:bottomView];
    [bottomView addSubview:bottomLabel];
    [self.view addSubview:_topView];
    [_topView addSubview:_nameLabel];
    [_topView addSubview:_grade];
    [_topView addSubview:_type];
    
    
}

- (void)postGradeData {
    NSString *stuNum = [NSString stringWithFormat:@"%@",[LoginEntry getByUserdefaultWithKey:@"stuNum"]];
    
    _hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _hub.labelText = @"正在加载...";
    
    [NetWork NetRequestPOSTWithRequestURL:GRADEAPI WithParameter:@{@"stuNum":stuNum} WithReturnValeuBlock:^(id returnValue) {

        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSMutableArray *dataArray = returnValue[@"data"];
        
        NSLog(@"%ld",dataArray.count);
        
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, _topView.frame.origin.y+_topView.frame.size.height, ScreenWidth, ScreenHeight-_kHeight*2-64)];
        _scrollView.contentSize = CGSizeMake(ScreenWidth, (dataArray.count)*_kHeight);
        _scrollView.showsVerticalScrollIndicator = NO;
        [self.view addSubview:_scrollView];
        
        
        
        for (int i = 0; i < dataArray.count; i ++) {
            NSDictionary *dic = dataArray[i];
            
            GradeView *view = [[GradeView alloc]initWithFrame:CGRectMake(0, i*_kHeight, ScreenWidth, _kHeight) titileWithDic:dic fontSize:_fontSize gradeFrame:_grade.frame typeFrame:_type.frame];
            if (i%2 == 0) {
                view.backgroundColor = [UIColor colorWithRed:249/255.0 green:249/255.0 blue:249/255.0 alpha:1];
            }else if (i%2 == 1) {
                view.backgroundColor = [UIColor whiteColor];
            }
            [_scrollView addSubview:view];
        }
        
    } WithFailureBlock:^{
        NSLog(@"network is boomshakalaka");
    }];
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
