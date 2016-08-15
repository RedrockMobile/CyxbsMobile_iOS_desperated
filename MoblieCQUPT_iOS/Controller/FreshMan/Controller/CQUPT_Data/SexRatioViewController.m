//
//  BigDataViewController.m
//  FreshManFeature
//
//  Created by 李展 on 16/8/7.
//  Copyright © 2016年 李展. All rights reserved.
//

#import "SexRatioViewController.h"
#import "Timer.h"
#import "LZListView.h"

@interface SexRatioViewController ()<LZListViewClickDelegate>{
    BOOL isOpenListView;
    BOOL isTheFirstLine;
    NSInteger flag;
    NSInteger flag1;
}

@property (weak, nonatomic) IBOutlet UILabel *exampleColorLb1;
@property (weak, nonatomic) IBOutlet UILabel *exampleColorLb2;
@property (weak, nonatomic) IBOutlet UILabel *exampleNameLb1;
@property (weak, nonatomic) IBOutlet UILabel *exampleNameLb2;

@property (weak, nonatomic) IBOutlet UILabel *lb;
@property (weak, nonatomic) IBOutlet UIButton *bt;
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UIButton *bt1;
@property (weak, nonatomic) IBOutlet UIView *pieView;
@property LZListView *listView;
@property LZListView *listView1;

@property NSArray *institute;
@property NSArray *major;
@property NSArray *manRatio;
@end
@implementation SexRatioViewController

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self closeListView];
}

-(void) viewDidLayoutSubviews{
    [_listView removeFromSuperview];
    [_listView1 removeFromSuperview];
    _listView = [[LZListView alloc]initWithFrame:CGRectMake(_lb.frame.origin.x, CGRectGetMaxY(_lb.frame)-1, _lb.frame.size.width, 0) andStringArray:_institute andBtnHeight:_lb.frame.size.height];
    _listView.delegate = self;
    isOpenListView = NO;
    
    _listView1 = [[LZListView alloc]initWithFrame:CGRectMake(_lb1.frame.origin.x, CGRectGetMaxY(_lb1.frame)-1, _lb1.frame.size.width, 0) andStringArray:_major[flag] andBtnHeight:_lb.frame.size.height];
    _listView1.delegate = self;
    [self.view addSubview:_listView1];
    [self.view addSubview:_listView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(120, 10, 80, 80)];
    view2.backgroundColor = [UIColor redColor];
    [self.view addSubview:view2];
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view2.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = view2.bounds;
    maskLayer.path = maskPath.CGPath;
    view2.layer.mask = maskLayer;

    _institute = @[@"通信与信息工程学院",@"计算机科学与技术学院",@"光电工程学院/重庆国际半导体学院",@"自动化学院",@"理学院",@"生物信息学院",@"经济管理学院",@"体育学院",@"外国语学院",@"先进制造工程学院",@"传媒艺术学院",@"软件工程学院",@"法学院",@"国际学院"];
//        _major = @[@[@"通信信息类（含通信工程、电子信息工程、信息工程三个专业）",@"广电与数字媒体类（含广播电视工程、数字媒体技术两个专业）"],@[@"计算机与智能科学类（含计算机科学与技术、信息安全、网络工程、智能科学与技术、地理信息科学、空间信息与数字技术六个专业）"],@[@"电子工程类（含光电信息科学与工程、电子科学与技术、电磁场与无线技术、电子信息科学与技术四个专业）",@"集成电路工程类（含微电子科学与工程、集成电路设计与集成系统两个专业）"],@[@"自动化与电气工程类（含自动化、电气工程及其自动化、物联网工程、智能电网信息工程、测控技术与仪器五个专业）"],@[@"数理科学与信息技术类（含信息与计算科学、数学与应用数学、应用物理学三个专业） "],@[@"生物信息学",@"生物医学工程"],@[@"电子商务类（含电子商务、物流管理两个专业）",@"工程管理",@"工商管理类（含工商管理、会计学、市场营销三个专业）",@"经济学",@"信息管理与信息系统"],@[@"社会体育指导与管理"],@[@"英语类（含英语、翻译两个专业）"],@[@"先进制造类（含机械设计制造及其自动化、机械电子工程两个专业）"],@[@"广播电视编导",@"数字媒体艺术与动画类（含动画、数字媒体艺术两个专业）",@"艺术设计类（含视觉传达设计、环境设计、产品设计三个专业）"],@[@"软件工程"],@[@"法学类（含法学、知识产权两个专业）"],@[@"电子信息工程（中外合作办学）",@"软件工程（中外合作办学）"]];
    
    _major = @[@[@"通信信息类",@"广电与数字媒体类"],@[@"计算机与智能科学类"],@[@"电子工程类",@"集成电路工程类"],@[@"自动化与电气工程类"],@[@"数理科学与信息技术类"],@[@"生物信息学",@"生物医学工程"],@[@"电子商务类",@"工程管理",@"工商管理类",@"经济学",@"信息管理与信息系统"],@[@"社会体育指导与管理"],@[@"英语类"],@[@"先进制造类"],@[@"广播电视编导",@"数字媒体艺术与动画类",@"艺术设计类"],@[@"软件工程"],@[@"法学类"],@[@"电子信息工程（中外合作办学）",@"软件工程（中外合作办学）"]];
    
    _manRatio = @[@[@76.00,@59.85],@[@79.79],@[@77.80,@88.74],@[@82.23],@[@72.31],@[@66.67,@51.65],@[@61.68,@80.33,@42.16,@57.53,@62.62],@[@75.41],@[@18.29],@[@90.94],@[@25.21,@37.28,@30.90],@[@83.90],@[@33.01],@[@88.74,@75.00]];

    self.view = [[[NSBundle mainBundle] loadNibNamed:@"SexRatioViewController" owner:self options:nil] lastObject];
    [_lb setTextColor:[UIColor colorWithRed:204.f/255  green:204.f/255  blue:204.f/255  alpha:1]];
    _lb.text = @"    请选择学院";
    _lb.layer.borderWidth = 0.5f;
    _lb.layer.borderColor = [[UIColor colorWithRed:204.f/255 green:204.f/255  blue:204.f/255  alpha:1] CGColor];
    _lb.font = [UIFont systemFontOfSize:14.f];
    _lb.layer.cornerRadius = 4;
    _lb.layer.masksToBounds = YES;

    [_lb1 setTextColor:[UIColor colorWithRed:204.f/255  green:204.f/255  blue:204.f/255  alpha:1]];
    _lb1.text = @"    请选择专业";
    _lb1.layer.borderWidth = 0.5f;
    _lb1.layer.borderColor = [[UIColor colorWithRed:204.f/255 green:204.f/255  blue:204.f/255  alpha:1] CGColor];
    _lb1.font = [UIFont systemFontOfSize:14.f];
    _lb1.layer.cornerRadius = 4;
    _lb1.layer.masksToBounds = YES;
    
    _bt.adjustsImageWhenHighlighted = NO;
    _bt.adjustsImageWhenDisabled = NO;
    _bt.layer.cornerRadius = 4;
    _bt.layer.masksToBounds = YES;
    _bt.tag = 0;
    [self.bt setBackgroundImage:[UIImage imageNamed:@"pick.png"] forState:UIControlStateNormal];
    [self.bt addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    
    _bt1.adjustsImageWhenHighlighted = NO;
    _bt1.layer.cornerRadius = 4;
    _bt1.layer.masksToBounds = YES;
    _bt1.tag = 1;
    [self.bt1 setBackgroundImage:[UIImage imageNamed:@"pick.png"] forState:UIControlStateNormal];
    [self.bt1 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    
    _exampleColorLb1.backgroundColor = [UIColor colorWithRed:207/255.f green:205/255.f blue:252/255.f alpha:1];
    _exampleColorLb2.backgroundColor = [UIColor colorWithRed:185/255.f green:230/255.f blue:254/255.f alpha:1];
    _exampleColorLb1.layer.cornerRadius = 4;
    _exampleColorLb2.layer.cornerRadius = 4;
    _exampleColorLb1.layer.masksToBounds = YES;
    _exampleColorLb2.layer.masksToBounds = YES;
    _exampleNameLb1.text = @"  女生";
    _exampleNameLb2.text = @"  男生";
    _exampleNameLb1.font = [UIFont systemFontOfSize:14];
    _exampleNameLb2.font = [UIFont systemFontOfSize:14];
    if ([UIScreen mainScreen].bounds.size.width==320) {
        _exampleNameLb1.font = [UIFont systemFontOfSize:12];
        _exampleNameLb2.font = [UIFont systemFontOfSize:12];
    }
    
    [self.exampleNameLb1 setHidden:YES];
    [self.exampleNameLb2 setHidden:YES];
    [self.exampleColorLb1 setHidden:YES];
    [self.exampleColorLb2 setHidden:YES];
    


 }

-(void) click:(UIButton *)sender{
    if (sender.tag == 0) {
        isTheFirstLine = YES;
        if (isOpenListView) {
            _listView.scrollView.hidden = YES;
            [self closeListView];
        }
        else{
            [self openListView];
        }
    }
    else {
        isTheFirstLine = NO;
        if ([_lb.text isEqualToString:@"    请选择学院"]) {
            UIAlertController *alertController =[UIAlertController alertControllerWithTitle:@"提示" message:@"请先选择学院" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [alertController addAction:ok];
            [alertController addAction:cancel];
            [self presentViewController:alertController animated:YES completion:^{
                return ;
            }];
        }
        else{
            if (isOpenListView) {
                _listView1.scrollView.hidden = YES;
                [self closeListView];
            }
            else{
                [self openListView];
            }
        }
    }
}

-(void) openListView{

    if (isTheFirstLine) {
        CGFloat height = _institute.count >5? _lb.frame.size.height*5 : _institute.count*_lb.frame.size.height;
        [UIView animateWithDuration:.2f animations:^{
            _listView.frame = CGRectMake(_listView.frame.origin.x, _listView.frame.origin.y, _listView.frame.size.width, height);
        } completion:^(BOOL finished) {
            _listView.scrollView.hidden = NO;
            _listView.layer.borderWidth = 0.5;

        }];
    }
    else{
        CGFloat height = [_major[flag] count] >5 ? _lb.frame.size.height*5 :[_major[flag] count]*_lb.frame.size.height;
        [UIView animateWithDuration:.2f animations:^{
            _listView1.frame = CGRectMake(_listView1.frame.origin.x, _listView1.frame.origin.y, _listView1.frame.size.width, height);
        } completion:^(BOOL finished) {
            _listView1.scrollView.hidden = NO;
            _bt.enabled = NO;
        }];
    }
    isOpenListView = YES;
}


-(void) closeListView{
    _listView.scrollView.hidden = YES;
    if (isTheFirstLine) {
        [UIView animateWithDuration:.2f animations:^{
            _listView.scrollView.hidden = YES;
            _listView.frame = CGRectMake(_listView.frame.origin.x, _listView.frame.origin.y, _listView.frame.size.width, 0);
        } completion:^(BOOL finished) {
            
        }];
    }
    else{
        [UIView animateWithDuration:.2f animations:^{
            _listView1.scrollView.hidden = YES;
            _listView1.frame = CGRectMake(_listView1.frame.origin.x, _listView1.frame.origin.y, _listView1.frame.size.width, 0);
        } completion:^(BOOL finished) {
            _bt.enabled = YES;
        }];
    }
    isOpenListView = NO;
}

-(void)eventWhenClickListViewBtn:(UIButton *)sender{
     [self.exampleNameLb1 setHidden:NO];
     [self.exampleNameLb2 setHidden:NO];
     [self.exampleColorLb1 setHidden:NO];
     [self.exampleColorLb2 setHidden:NO];
    if (isTheFirstLine) {
        flag = sender.tag;
        flag1 = 0;
        _listView1 = [[LZListView alloc]initWithFrame:_listView1.frame andStringArray:_major[flag] andBtnHeight:_lb.frame.size.height];
        _lb.text = [NSString stringWithFormat:@"    %@",sender.titleLabel.text];
        _lb1.text = [NSString stringWithFormat:@"    %@",_major[flag][flag1]];
    }
    else{
        _lb1.text = [NSString stringWithFormat:@"    %@",sender.titleLabel.text];
        flag1 = sender.tag;
    }
    CGRect square = _pieView.frame;
    NSNumber *man = _manRatio[flag][flag1];
    NSNumber *woman = @(100 - [_manRatio[flag][flag1] doubleValue]);
    [self.pieView removeFromSuperview];
    Timer *pieView = [[Timer alloc] initWithSquare:square Nums:@[man,woman]];
    _pieView = pieView;
    [self.view addSubview:pieView];
    [self closeListView];
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
