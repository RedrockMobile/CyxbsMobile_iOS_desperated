//
//  StuDiningRoomViewController.m
//  MoblieCQUPT_iOS
//
//  Created by 王一成 on 2018/8/14.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "StuDormitoryRootViewController.h"
#import "SchollSubViewController.h"
#import "SegmentView.h"
#import "FreshmanModel.h"

@interface StuDormitoryRootViewController ()
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *topHignt;
@property (strong, nonatomic) IBOutlet UIView *constraintView;
@property (nonatomic, strong) FreshmanModel *Model;
@property (nonatomic, strong) SegmentView *MainSegmentView;
@property (nonatomic, strong) NSMutableArray *Array;

@end

@implementation StuDormitoryRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"学生寝室";
    
    //设置背景色
    self.view.backgroundColor =  [UIColor whiteColor];
    
    _constraintView.backgroundColor = [UIColor clearColor];
    
    
    _topHignt.constant = HEADERHEIGHT;
    _Array = [NSMutableArray arrayWithCapacity:4];
    SchollSubViewController *vc1 = [[SchollSubViewController alloc]init];
    vc1.title = @"明理苑";
    [vc1 setUrl:@"http://wx.yyeke.com/welcome2018/data/get/sushe?name=明理苑"];
    [self addChildViewController:vc1];
    _Array[0] = vc1;

    SchollSubViewController *vc2 = [[SchollSubViewController alloc]init];
    vc2.title = @"宁静苑";
    [vc2 setUrl:@"http://wx.yyeke.com/welcome2018/data/get/sushe?name=宁静苑"];
    [self addChildViewController:vc2];
    _Array[1] = vc2;

   SchollSubViewController *vc3 = [[SchollSubViewController alloc]init];
    vc3.title = @"兴业苑";
     [vc3 setUrl:@"http://wx.yyeke.com/welcome2018/data/get/sushe?name=兴业苑"];
    [self addChildViewController:vc3];
    _Array[2] = vc3;

    SchollSubViewController *vc4 = [[SchollSubViewController alloc]init];
    vc4.title = @"知行苑";
     [vc4 setUrl:@"http://wx.yyeke.com/welcome2018/data/get/sushe?name=知行苑"];
    [self addChildViewController:vc4];
    _Array[3] = vc4;

    
    self.MainSegmentView =  [[SegmentView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT-HEADERHEIGHT) andControllers:[NSArray arrayWithArray:_Array]];
    self.MainSegmentView.titleColor = [UIColor colorWithHexString:@"999999"];
    self.MainSegmentView.selectedTitleColor = [UIColor colorWithHexString:@"54acff"];
    [self.constraintView addSubview:self.MainSegmentView];
    
    
    //NSLog(@"MainSegmentView.currentIndex:%ld",(long)self.MainSegmentView.currentIndex);
    
    

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//- (void)eventWhenScrollSubViewWithIndex:(NSInteger)index{
//    NSLog(@"MainSegmentView.currentIndex:%ld",(long)index);
//    SchollSubViewController *vc = _Array[index];
//    [vc.tableView reloadData];
//    
//
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
