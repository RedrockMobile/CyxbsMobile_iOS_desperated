//
//  BusRoutes.m
//  MoblieCQUPT_iOS
//
//  Created by 王一成 on 2019/8/3.
//  Copyright © 2019 Orange-W. All rights reserved.
//

#import "BusRoutes.h"
#import "SchoolAdressView.h"
#import "RecommendedRouteView.h"
#import "RecommendedRouteTableViewCell.h"
#import "RecommendedRouteHeaderView.h"
#import "BusRoutesModel.h"

@interface BusRoutes ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>

@property (strong, nonatomic)NSMutableArray *titleArray;
@property (strong, nonatomic)NSMutableArray *isExpandArray;//记录section是否展开
@property (strong, nonatomic)SchoolAdressView *schoolAdressView;
@property (strong, nonatomic)RecommendedRouteView *recommendedRouteView;
@property (strong, nonatomic)BusRoutesModel *model;
@property (assign, nonatomic)NSInteger section;
@end

@implementation BusRoutes

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(initView)
                                                 name:@"BusRoutesDataLoadSuccess" object:nil];
    self.title = @"公交线路";
    self.view.backgroundColor = [UIColor colorWithHexString:@"eff7ff"];
    self.isExpandArray = [[NSMutableArray alloc]init];
    [self initModel];
    
 
}

-(void)initModel{
    self.model = [[BusRoutesModel alloc]init];
    [self.model getBusRoutesData];
}
-(void)initView{
    [self getDataFromModel];
    [self setSchoolAdressView];
    [self setRecommendedRouteView];
}
-(void)setSchoolAdressView{
    self.schoolAdressView = [[SchoolAdressView alloc]initWithFrame:CGRectMake(0, 0,self.view.width, 118)];
    [self.schoolAdressView.schoolAdressBtn addTarget:self action:@selector(copySchoolAdress) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.schoolAdressView];
    

}


-(void)setRecommendedRouteView{
//    self.recommendedRouteView = [[RecommendedRouteView alloc]initWithFrame:CGRectMake(0, 118, self.view.width, self.view.height - 118 - TOTAL_TOP_HEIGHT - SCREEN_HEIGHT * 0.06 - TABBARHEIGHT)];
     self.recommendedRouteView = [[RecommendedRouteView alloc]initWithFrame:CGRectMake(0, 118, self.view.width, self.view.height - 118)];
    self.recommendedRouteView.tableView.delegate = self;
    self.recommendedRouteView.tableView.dataSource = self;
    [self.view addSubview:self.recommendedRouteView];
}


- (void)getDataFromModel{
//    NSString *dataList = [[NSBundle mainBundle]pathForResource:@"RecommendedRoute" ofType:@"plist"];
//    self.dataDic = [[NSDictionary alloc]initWithContentsOfFile:dataList];
//
    self.titleArray = self.model.nameArray;
    for (NSInteger i = 0; i < self.titleArray.count; i++) {
        [_isExpandArray addObject:@"0"];//0:没展开 1:展开
    }

}

 
#pragma -- mark tableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.titleArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([_isExpandArray[section]isEqualToString:@"1"]) {
        return  1;
    }else{
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 53;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    CGFloat height = tableView.frame.size.height;
    CGFloat width = tableView.frame.size.width;
  
    NSInteger tag = [self.isExpandArray[section] integerValue];
        
    RecommendedRouteHeaderView *headerView = [[RecommendedRouteHeaderView alloc]initWithFrame:CGRectMake(0, 0, width, 68) title:self.titleArray[section] tag:tag];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    tap.delegate = self;
    [headerView addGestureRecognizer:tap];
    headerView.tag = section;
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    /// 定义cell标识  每个cell对应一个自己的标识
    NSString *CellIdentifier = [NSString stringWithFormat:@"cell%ld%ld",indexPath.section,indexPath.row];
    // 通过不同标识创建cell实例
    RecommendedRouteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    // 判断为空进行初始化  --（当拉动页面显示超过主页面内容的时候就会重用之前的cell，而不会再次初始化）
    if (!cell) {
        cell = [[RecommendedRouteTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    NSString *text = self.model.routeArray[indexPath.section];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:text];
    [string addAttribute:NSForegroundColorAttributeName value:RGBColor(181, 115, 255, 1) range:[text rangeOfString:@"邮电大学站下车"]];
    [string addAttribute:NSForegroundColorAttributeName value:RGBColor(91, 105, 255, 1) range:[text rangeOfString:@"江北机场乘坐三号线"]];
    [string addAttribute:NSForegroundColorAttributeName value:RGBColor(91, 105, 255, 1) range:[text rangeOfString:@"乘坐323/119/354路公交车"]];
    [string addAttribute:NSForegroundColorAttributeName value:RGBColor(91, 105, 255, 1) range:[text rangeOfString:@"在菜园坝广场乘坐347路公交车"]];
    [string addAttribute:NSForegroundColorAttributeName value:RGBColor(91, 105, 255, 1) range:[text rangeOfString:@"乘车至南坪公交站转乘346/347路公交车"]];
    [string addAttribute:NSForegroundColorAttributeName value:RGBColor(91, 105, 255, 1) range:[text rangeOfString:@"乘坐325/426路公交车至南坪"]];
    
    cell.roadLabel.attributedText = string;
    return cell;
}

- (void)tapAction:(UITapGestureRecognizer *)tap{
    self.section = tap.view.tag;
    if ([_isExpandArray[tap.view.tag] isEqualToString:@"0"]) {
        //关闭 => 展开

        [_isExpandArray replaceObjectAtIndex:tap.view.tag withObject:@"1"];
    }else{
        //展开 => 关闭

        [_isExpandArray replaceObjectAtIndex:tap.view.tag withObject:@"0"];

    }

    NSIndexSet *set = [NSIndexSet indexSetWithIndex:tap.view.tag];
    [self.recommendedRouteView.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationFade];

}
- (void)copySchoolAdress{
    // 1.弹框提醒
    // 初始化对话框
    UIAlertController *alert = [UIAlertController
                                alertControllerWithTitle:@"提示" message:@"已复制" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    // 弹出对话框
    [self presentViewController:alert animated:true completion:^{

        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = @"重庆市南岸区南山街道崇文路2号重庆邮电大学";
    }];
    NSLog(@"%@",[UIPasteboard generalPasteboard].string);


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

