//
//  ThreeViewController.m
//  FreshMan
//
//  Created by dating on 16/8/12.
//  Copyright © 2016年 dating. All rights reserved.
//

#import "ThreeViewController.h"
#import "ThreeTableViewCell.h"




@interface ThreeViewController ()
#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r, g, b) RGBA(r, g, b, 1.0f)
#define  navigationBarFrame 66
#define  labelHeadHight 30
@property UITableView  *tableView;
@property  NSInteger LabelHight;
@property NSArray *arrayContent;

@end




@implementation ThreeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =  [UIColor whiteColor];
//    [self dwonload];
   
    //label.text = @"宿舍情况 : 宿舍床铺的长宽大致为80cm*200cm，每栋宿舍的床会有略微的差别。";
    
    // Do any additional setup after loading the view.
}
-(void)dwonload{
    self.arrayContent = [[NSArray alloc]init];
   
    NSError *error = nil;
    NSString *txtpath1 = [[NSBundle mainBundle] pathForResource:@"寝室介绍1" ofType:@"txt"];
    NSString *txtpath2 = [[NSBundle mainBundle] pathForResource:@"寝室介绍2" ofType:@"txt"];
    NSString *txtpath3 = [[NSBundle mainBundle] pathForResource:@"寝室介绍3" ofType:@"txt"];
    NSString *txtpath4 = [[NSBundle mainBundle] pathForResource:@"寝室介绍4" ofType:@"txt"];
    NSString *Content1 = [NSString stringWithContentsOfFile:txtpath1 encoding:NSUTF8StringEncoding error:&error];
    NSString *Content2 = [NSString stringWithContentsOfFile:txtpath2 encoding:NSUTF8StringEncoding error:&error];
    NSString *Content3 = [NSString stringWithContentsOfFile:txtpath3 encoding:NSUTF8StringEncoding error:&error];
    NSString *Content4 = [NSString stringWithContentsOfFile:txtpath4 encoding:NSUTF8StringEncoding error:&error];
    self.arrayContent = @[Content1,Content2,Content3,Content4];
//    NSLog(@"%@",self.arrayContent);
    [self tableview];
    
    
}

-(void)tableview{
    self.tableView = [[UITableView alloc]init];
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.tableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    self.tableView.frame = CGRectMake(0, 0, screenSize.width, screenSize.height-104);
    [self.view addSubview:self.tableView];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    CGRect rect2 =[self.arrayContent[indexPath.row] boundingRectWithSize:CGSizeMake(screenSize.width - 40, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil];
    return rect2.size.height +340;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ThreeTableViewCell *cell = (ThreeTableViewCell *)[[[NSBundle mainBundle]loadNibNamed :@"ThreeTableViewCell" owner:self options:nil]  lastObject];
    cell.backgroundColor = [UIColor whiteColor];
    cell.Introduce.numberOfLines = 0;
    cell.image.image = [UIImage imageNamed:[NSString stringWithFormat:@"寝室%ld.jpg",(long)indexPath.row ]];
    cell.Introduce.text = self.arrayContent[indexPath.row];
    cell.image.layer.masksToBounds = YES;
    cell.image.layer.cornerRadius = 20;
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //NSLog(@"点击的是第%ld个Cell",indexPath.row);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end