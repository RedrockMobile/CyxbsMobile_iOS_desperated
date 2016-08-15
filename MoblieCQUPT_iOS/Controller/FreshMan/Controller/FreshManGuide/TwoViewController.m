//
//  TwoViewController.m
//  FreshMan
//
//  Created by dating on 16/8/12.
//  Copyright © 2016年 dating. All rights reserved.
//

#import "TwoViewController.h"
#import "OneTableViewCell.h"
#define  navigationBarFrame 66
@interface TwoViewController ()
#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r, g, b) RGBA(r, g, b, 1.0f)
#define labelLead_Hight 30
#define iphoneScreen 666
@property UITableView  *tableView;
@property (strong, nonatomic) NSArray *Name;
@property (strong, nonatomic) NSArray *Content;
@property  NSInteger LabelHight;


@end

@implementation TwoViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self tableview];
    [self Data];
    // Do any additional setup after loading the view.
}
-(void)Data{
    
    NSError *error = nil;
    NSString *txtpath1 = [[NSBundle mainBundle] pathForResource:@"江北机场" ofType:@"txt"];
    NSString *txtpath2 = [[NSBundle mainBundle] pathForResource:@"龙头寺" ofType:@"txt"];
    NSString *txtpath3 = [[NSBundle mainBundle] pathForResource:@"菜园坝" ofType:@"txt"];
    NSString *txtpath4 = [[NSBundle mainBundle] pathForResource:@"朝天门" ofType:@"txt"];
    NSString *jiangbei = [NSString stringWithContentsOfFile:txtpath1 encoding:NSUTF8StringEncoding error:&error];
    NSString *longtousi = [NSString stringWithContentsOfFile:txtpath2 encoding:NSUTF8StringEncoding error:&error];
    NSString *caiyuanba = [NSString stringWithContentsOfFile:txtpath3 encoding:NSUTF8StringEncoding error:&error];
    NSString *chaotianmen = [NSString stringWithContentsOfFile:txtpath4 encoding:NSUTF8StringEncoding error:&error];
    self.Content = [[NSArray alloc]init];
    self.Name = [[NSArray alloc]init];
    NSString *Name1 = @"重庆江北机场（距离学校约40公里）：";
    NSString *Name2 = @"龙头寺火车站、重庆北站（距离学校约20公里）：";
    NSString *Name3 = @"菜园坝火车站、汽车站（距离学校约12公里）：";
    NSString *Name4 = @"朝天门码头（距离学校约9公里）：";
    self.Name = @[Name1,Name2,Name3,Name4];
    self.Content = @[jiangbei,longtousi,caiyuanba,chaotianmen];
    
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
    CGRect rect1 =[self.Content[indexPath.row] boundingRectWithSize:CGSizeMake(screenSize.width - 40, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil];
    CGRect rect2 =[self.Name[indexPath.row] boundingRectWithSize:CGSizeMake(screenSize.width - 40, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
    return rect1.size.height+rect2.size.height +30;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OneTableViewCell *cell = (OneTableViewCell *)[[[NSBundle mainBundle]loadNibNamed :@"OneTableViewCell" owner:self options:nil]  lastObject];
    cell.backgroundColor = [UIColor whiteColor];
    cell.Content.numberOfLines = 0;
    cell.Name.numberOfLines = 0;
    cell.Name.text=self.Name[indexPath.row];
    cell.Content.text=self.Content[indexPath.row];
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    if (screenSize.height > iphoneScreen) {
        UILabel *label = [[UILabel alloc]init];
        label.backgroundColor = RGB(248, 253, 254);
        label.frame = CGRectMake(0, screenSize.height*0.8, screenSize.width, 100);
        [self.view addSubview:label];
    }
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
