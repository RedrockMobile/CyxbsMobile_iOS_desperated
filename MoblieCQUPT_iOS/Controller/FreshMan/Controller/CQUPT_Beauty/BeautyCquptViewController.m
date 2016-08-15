//
//  BeautyCquptViewController.m
//  FreshManFeature
//
//  Created by hzl on 16/8/12.
//  Copyright © 2016年 李展. All rights reserved.
//

#import "BeautyCquptViewController.h"


#import "AFNetWorking.h"
#import "UIImageView+WebCache.h"
#import "UIImageView+WebCache.h"

#define maxScreenHeight [UIScreen mainScreen].bounds.size.height
#define maxScreenWdith [UIScreen mainScreen].bounds.size.width


#import "BeautyCquptTableViewCell.h"

@interface BeautyCquptViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong, readwrite) UITableView *tableView;
@property (nonatomic, copy) NSMutableArray *dataArray;
@property (nonatomic, copy) NSDictionary *dataDict;

@property (nonatomic, strong) NSArray *introduceArray;

@end

@implementation BeautyCquptViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatIntroduce];
//    [self downLoad];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 114) style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)downLoad
{
//    dispatch_queue_attr_t q1 = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://hongyan.cqupt.edu.cn/cyxbsMobile/index.php/Home/WelcomeFreshman/cquptView"]];
    // 2.创建一个网络请求，分别设置请求方法、请求参数
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    NSString *args = [NSString stringWithFormat:@"page=0&size=19"];
    request.HTTPBody = [args dataUsingEncoding:NSUTF8StringEncoding];
    
    // 3.获得会话对象
    NSURLSession *session = [NSURLSession sharedSession];
    
    // 4.根据会话对象，创建一个Task任务
    NSURLSessionDataTask *sessionDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil)
        {
            self.dataDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            self.dataArray = [_dataDict objectForKey:@"data"];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.view addSubview:_tableView];
            [self.tableView reloadData];
        });
    }];
    [sessionDataTask resume];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BeautyCquptTableViewCell *cell = [BeautyCquptTableViewCell cellWithTableView:tableView];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    [cell.introduceImageView sd_setImageWithURL:[NSURL URLWithString:_dataArray[indexPath.row][@"photo"][0][@"photo_src"]]];
    
    cell.introduceLabel.text = _introduceArray[indexPath.row];
//    NSLog(@"%@",_introduceArray[indexPath.row]);
//    NSLog(@"第%ld : 个%f",indexPath.row,cell.introduceLabel.frame.size.width);
       CGRect rect2 = [_introduceArray[indexPath.row] boundingRectWithSize:CGSizeMake(maxScreenWdith - 30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
    [cell.introduceLabel sizeToFit];
    cell.introduceLabel.frame = CGRectMake(15, CGRectGetMaxY(cell.introduceImageView.frame)+15, cell.introduceImageView.frame.size.width, rect2.size.height);
//    NSLog(@"%ld",cell.introduceLabel.numberOfLines);
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect rect2 = [_introduceArray[indexPath.row] boundingRectWithSize:CGSizeMake(maxScreenWdith - 30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
    CGFloat cellHeigh = rect2.size.height > 20 ? 180 + rect2.size.height : 165;
    return cellHeigh;
    
//  if (indexPath.row == 2 | indexPath.row == 3 | indexPath.row == 4)
//    {
//        return 0.288 * maxScreenHeight;
//    }else{
//    return 0.421 * maxScreenHeight;
//        }
}

- (void)creatIntroduce
{
    NSString *str1 = @"我抬头仰望，那专属的红绿蓝，牵引着我追寻梦想的思绪。整个校园，就像是一艘正在缓慢行驶的帆船，而这巍峨的第八教学楼仿佛在诉说：“我亲爱的孩子，这里就是你梦想的帆！”";
    NSString *str2 = @"恰同学少年的我，常常奔赴于书生意气浓厚的数字图书馆。它就像一本厚厚的百科全书，而里面珍藏的书籍，是它每一章节最精彩的部分。当我翻开她的卷首，她告诉我：“静观，静思，静记”";
    NSString *str3 = @"我不知道走过了多少次这样的路，二教，三教，四教……上课，下课，嬉笑，和这几座静谧而安定的教学楼串成了一个个精彩纷呈的，无语伦比的小故事。那一大片的草坪，都在浅唱：“修德、博学、求实、创新。”";
    NSString *str4 = @"我来到信科楼下，驻足，仰望，我想要飞，飞进信科顶端的云层里，憧憬，翱翔，细数我曾在这里做实验敲代码的日日夜夜……云朵在我的身体里飘过，呼唤着：“亲爱的孩子，一步一个脚印，梦想在你的翅膀上！”";
    NSString *str5 = @"在爬完这个远近闻名的重邮天梯，虽然感觉到一阵疲惫但我的心里，却充满了时时刻刻的幸福。我的一个个向上攀爬的身躯都在激励我：“会当凌绝顶，一览众山小。”";
    NSString *str6 = @"夕阳下，你吟出了绝美的一幕。日光与云层交相辉映的太极操场，填满着我整颗感动的心。缓缓坐在足球场上，体味着夕阳融入身体的温暖。身在哪里，心就在哪里，仿佛自己也是这幅画卷里一部分。渐渐的，我听见了整个太极都在呢喃：“青春是一束束淡淡的日光，耀眼并且温暖人心。”";
    
    NSString *txtpath = [[NSBundle mainBundle] pathForResource:@"美在重邮" ofType:@"txt"];
    NSString *str7 = [[NSString alloc] initWithContentsOfFile:txtpath encoding:NSUTF8StringEncoding error:nil];
    
    _introduceArray = @[str1,str2,@"",@"",@"",str3,str4,str5,str6,str7];
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
