//
//  FourViewController.m
//  FreshMan
//
//  Created by dating on 16/8/12.
//  Copyright © 2016年 dating. All rights reserved.
//

#import "FourViewController.h"
#import "OneTableViewCell.h"
@interface FourViewController ()
#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r, g, b) RGBA(r, g, b, 1.0f)
#define  navigationBarFrame 66
@property UITableView  *tableView;
@property (strong, nonatomic) NSArray *Name;
@property (strong, nonatomic) NSArray *Content;
@property  NSInteger LabelHight;

@end

@implementation FourViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self tableview];
    [self Data];
    
    
    // Do any additional setup after loading the view.
}
-(void)Data{
    
    NSError *error = nil;
    NSString *txtpath1 = [[NSBundle mainBundle] pathForResource:@"重要东西" ofType:@"txt"];
    NSString *txtpath2 = [[NSBundle mainBundle] pathForResource:@"细节" ofType:@"txt"];
    
    NSString *zhongyao = [NSString stringWithContentsOfFile:txtpath1 encoding:NSUTF8StringEncoding error:&error];
    NSString *xijie = [NSString stringWithContentsOfFile:txtpath2 encoding:NSUTF8StringEncoding error:&error];
    self.Content = [[NSArray alloc]init];
    self.Name = [[NSArray alloc]init];
    NSString *Name1 = @"这些东西很重要：";
    NSString *Name2 = @"生活上的细节也不能够忽视：";
    self.Name = @[Name1,Name2];
    self.Content = @[zhongyao,xijie];
    
    
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
    cell.backgroundColor =  [UIColor whiteColor];
    cell.Content.numberOfLines = 0;
    cell.Name.numberOfLines = 0;
    cell.Name.text=self.Name[indexPath.row];
    cell.Content.text=self.Content[indexPath.row];
       CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    CGSize textViewSize = [cell.Content sizeThatFits:CGSizeMake(cell.Content.frame.size.width, FLT_MAX)];
    self.LabelHight  = size.height + textViewSize.height;
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //NSLog(@"点击的是第%ld个Cell",(long)indexPath.row);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
