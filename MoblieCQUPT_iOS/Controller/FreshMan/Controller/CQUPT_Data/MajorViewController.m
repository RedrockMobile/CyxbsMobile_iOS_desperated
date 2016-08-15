//
//  MajorViewController.m
//  FreshManFeature
//
//  Created by 李展 on 16/8/13.
//  Copyright © 2016年 李展. All rights reserved.
//

#import "MajorViewController.h"
#import "Timer.h"
#import "LZListView.h"

@interface MajorViewController ()<LZListViewClickDelegate>
{
    BOOL isOpenListView;
}
@property LZListView *listView;
@property (weak, nonatomic) IBOutlet UILabel *exampleColorLb1;
@property (weak, nonatomic) IBOutlet UILabel *exampleColorLb2;
@property (weak, nonatomic) IBOutlet UILabel *exampleColorLb3;
@property (weak, nonatomic) IBOutlet UILabel *exampleNameLb1;
@property (weak, nonatomic) IBOutlet UILabel *exampleNameLb2;
@property (weak, nonatomic) IBOutlet UILabel *exampleNameLb3;
@property (weak, nonatomic) IBOutlet UIView *pieView;
@property NSArray *firstSubject;
@property NSArray *secondSubject;
@property NSArray *thirdSubject;
@property NSArray *firstRatio;
@property NSArray *secondRatio;
@property NSArray *thirdRatio;
@property NSArray *institute;
@property (weak, nonatomic) IBOutlet UILabel *lb;
@property (weak, nonatomic) IBOutlet UIButton *bt;

@end

@implementation MajorViewController
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
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
    _firstRatio = @[@62.00,@40.00,@54.00,@45.00,@49.0,@45.00,@42.00,@56.00,@44.55,@55.00,@43.00,@56.00,@54.90,@52.00];
    _secondRatio = @[@18.00,@35.00 ,@26.00 ,@30.00 ,@28.00 ,@31.00 ,@38.00 ,@22.00 ,@28.18 ,@24.00 ,@32.00 ,@23.00 ,@24.51 ,@32.00];
    _thirdRatio = @[@20.00, @25.00 ,@20.00 ,@25.00 ,@23.00 ,@24.00 ,@20.00 ,@22.00 ,@27.27 ,@21.00 ,@25.00 ,@21.00  ,@20.59 ,@16.00 ];
    _firstSubject = @[@"电子电路",@"大学物理",@"大学物理",@"大学物理", @"数学分析", @"高等数学",@"概率论",@"运动解剖学",@"基础英语",@"工程图学",@"视听说",@"高等数学",@"刑法",@"软件设计基础"];
    _secondSubject = @[@"高等数学",@"高等数学" ,@"概率论",@"高等数学",@"高等数学",@"视听说" ,@"高等数学",@"体育概论",@"英语语音",@"大学物理",@"读写译",@"离散数学",@"民法",@"线性代数"];
    _thirdSubject = @[@"大学物理",@"线性代数",@"工程图学",@"C语言",@"大学物理",@"化学",@"C语言",@"健美操",@"英语阅读",@"高等数学",@"美术史",@"C++",@"法理",@"大学物理"];
    self.view = [[[NSBundle mainBundle] loadNibNamed:@"MajorViewController" owner:self options:nil]lastObject];
    [_lb setTextColor:[UIColor colorWithRed:204.f/255  green:204.f/255  blue:204.f/255  alpha:1]];
    _lb.tintColor = [UIColor redColor];
    _lb.text = @"    请选择学院";
    _lb.layer.borderWidth = 0.5f;
    _lb.layer.borderColor = [[UIColor colorWithRed:204.f/255 green:204.f/255  blue:204.f/255  alpha:1] CGColor];
    _lb.font = [UIFont systemFontOfSize:14.f];
    _lb.layer.cornerRadius = 4;
    _lb.layer.masksToBounds = YES;
    
    _bt.layer.cornerRadius = 4;
    _bt.layer.masksToBounds = YES;
    _bt.tag = 0;
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
    CGRect square = self.pieView.frame;
    _exampleNameLb1.text = [NSString stringWithFormat:@"  %@",_firstSubject[sender.tag]];
    _exampleNameLb2.text = [NSString stringWithFormat:@"  %@",_secondSubject[sender.tag]];
    _exampleNameLb3.text = [NSString stringWithFormat:@"  %@",_thirdSubject[sender.tag]];
    
    Timer *pieView = [[Timer alloc] initWithSquare:square Nums:@[_firstRatio[sender.tag],_secondRatio[sender.tag],_thirdRatio[sender.tag]]];
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
