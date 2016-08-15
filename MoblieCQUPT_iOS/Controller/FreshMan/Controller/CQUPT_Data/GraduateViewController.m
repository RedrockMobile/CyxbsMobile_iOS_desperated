//
//  GraduateViewController.m
//  FreshManFeature
//
//  Created by 李展 on 16/8/13.
//  Copyright © 2016年 李展. All rights reserved.
//

#import "GraduateViewController.h"
#import "Timer.h"
#import "LZListView.h"
@interface GraduateViewController ()<LZListViewClickDelegate>{
    BOOL isOpenListView;
}
@property NSArray *work;
@property NSArray *furtherStudy;
@property NSArray *others;
@property NSArray *institute;
@property (weak, nonatomic) IBOutlet UIView *pieView;
@property (weak, nonatomic) IBOutlet UILabel *lb;
@property (weak, nonatomic) IBOutlet UIButton *bt;
@property (weak, nonatomic) IBOutlet UILabel *exampleNameLb1;
@property (weak, nonatomic) IBOutlet UILabel *exampleNameLb2;
@property (weak, nonatomic) IBOutlet UILabel *exampleNameLb3;
@property (weak, nonatomic) IBOutlet UILabel *exampleColorLb1;
@property (weak, nonatomic) IBOutlet UILabel *exampleColorLb2;
@property (weak, nonatomic) IBOutlet UILabel *exampleColorLb3;
@property LZListView *listView;
@end


@implementation GraduateViewController

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self closeListView];
}

-(void)viewDidLayoutSubviews{
    _listView = [[LZListView alloc]initWithFrame:CGRectMake(_lb.frame.origin.x, CGRectGetMaxY(_lb.frame), _lb.frame.size.width, 0) andStringArray:_institute andBtnHeight:_lb.frame.size.height];
    _listView.delegate = self;
    isOpenListView = NO;
    [self.view addSubview:_listView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _institute = @[@"通信与信息工程学院",@"计算机科学与技术学院",@"光电工程学院",@"自动化学院",@"理学院",@"生物信息学院",@"经济管理学院",@"体育学院",@"外国语学院",@"先进制造工程学院",@"传媒艺术学院",@"软件工程学院",@"法学院",@"重庆国际半导体学院"];
    _work = @[@75.60,@73.02,@71.06, @81.35,@77.85,@71.64,@85.61,@87.68,@84.39,@85.71,@82.64,@86.97,@63.75,@76.03];
    _furtherStudy = @[@22.23,@21.50,@23.40,@17.25,@14.56,@23.51,@9.30,@11.67,@15.63,@10.08,@10.60,@7.04,@31.25,@18.49];
    _others = @[@2.17,@5.48,@5.54,@1.40,@7.59,@4.85,@5.09,@1.67,@1.00,@4.21,@6.76,@5.99,@5.00,@5.48];
    
    self.view = [[[NSBundle mainBundle] loadNibNamed:@"GraduateViewController" owner:self options:nil] lastObject];
    [_lb setTextColor:[UIColor colorWithRed:204.f/255  green:204.f/255  blue:204.f/255  alpha:1]];
    _lb.text = @"    请选择学院";
    _lb.layer.borderWidth = 0.5f;
    _lb.layer.borderColor = [[UIColor colorWithRed:204.f/255 green:204.f/255  blue:204.f/255  alpha:1] CGColor];
    _lb.font = [UIFont systemFontOfSize:14.f];
    _lb.layer.cornerRadius = 4;
    _lb.layer.masksToBounds = YES;
    
    
    _bt.layer.cornerRadius = 4;
    _bt.layer.masksToBounds = YES;
    [self.bt setBackgroundImage:[UIImage imageNamed:@"pick.png"] forState:UIControlStateNormal];
    [self.bt addTarget:self action:@selector(click:)  forControlEvents:UIControlEventTouchUpInside];
    
    _exampleColorLb1.backgroundColor = [UIColor colorWithRed:207/255.f green:205/255.f blue:252/255.f alpha:1];
    _exampleColorLb2.backgroundColor = [UIColor colorWithRed:185/255.f green:230/255.f blue:254/255.f alpha:1];
    _exampleColorLb3.backgroundColor = [UIColor colorWithRed:254/255.f green:199/255.f blue:227/255.f alpha:1];
    

    _exampleColorLb1.layer.cornerRadius = 4;
    _exampleColorLb2.layer.cornerRadius = 4;
    _exampleColorLb3.layer.cornerRadius = 4;
    _exampleColorLb1.layer.masksToBounds = YES;
    _exampleColorLb2.layer.masksToBounds = YES;
    _exampleColorLb3.layer.masksToBounds = YES;
    _exampleNameLb1.text =@"  签就业协议";
    _exampleNameLb2.text =@"  升学就业";
    _exampleNameLb3.text =@"  其它";
    _exampleNameLb1.font = [UIFont systemFontOfSize:14];
    _exampleNameLb2.font = [UIFont systemFontOfSize:14];
    _exampleNameLb3.font = [UIFont systemFontOfSize:14];
    if ([UIScreen mainScreen].bounds.size.width==320) {
        _exampleNameLb1.font = [UIFont systemFontOfSize:12];
        _exampleNameLb2.font = [UIFont systemFontOfSize:12];
        _exampleNameLb3.font = [UIFont systemFontOfSize:12];
    }
    [self.exampleNameLb1 setHidden:YES];
    [self.exampleNameLb2 setHidden:YES];
    [self.exampleNameLb3 setHidden:YES];
    [self.exampleColorLb1 setHidden:YES];
    [self.exampleColorLb2 setHidden:YES];
    [self.exampleColorLb3 setHidden:YES];

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) click:(UIButton *)sender{
    if (isOpenListView) {
        _listView.scrollView.hidden = YES;
        [self closeListView];
    }
    else{
        [self openListView];
    }
    isOpenListView = !isOpenListView;
}

-(void) openListView{
    CGFloat height = _institute.count >5? _lb.frame.size.height*5 : _institute.count*_lb.frame.size.height;
    [UIView animateWithDuration:.2f animations:^{
        _listView.frame = CGRectMake(_listView.frame.origin.x, _listView.frame.origin.y, _listView.frame.size.width, height);
    } completion:^(BOOL finished) {
        _listView.scrollView.hidden = NO;
    }];
}


-(void) closeListView {
    _listView.scrollView.hidden = YES;
    [UIView animateWithDuration:.2f animations:^{
        _listView.frame = CGRectMake(_listView.frame.origin.x, _listView.frame.origin.y, _listView.frame.size.width, 0);
    } completion:^(BOOL finished) {
    }];
}

-(void)eventWhenClickListViewBtn:(UIButton *)sender{
    [self closeListView];
    _lb.text = [NSString stringWithFormat:@"    %@",sender.titleLabel.text];
    [self.pieView removeFromSuperview];
    //    [self.listView removeFromSuperview];
    CGRect square = self.pieView.frame;
    Timer *pieView = [[Timer alloc] initWithSquare:square Nums:@[_work[sender.tag],_furtherStudy[sender.tag],_others[sender.tag]]];
    _pieView = pieView;
    [self.view addSubview:pieView];
    [self.exampleNameLb1 setHidden:NO];
    [self.exampleNameLb2 setHidden:NO];
    [self.exampleNameLb3 setHidden:NO];
    [self.exampleColorLb1 setHidden:NO];
    [self.exampleColorLb2 setHidden:NO];
    [self.exampleColorLb3 setHidden:NO];
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
