//
//  ViewControl.m
//  MoblieCQUPT_iOS
//
//  Created by J J on 2018/8/12.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "ChatViewControl.h"
#import "AFNetworking.h"

#define width [UIScreen mainScreen].bounds.size.width//宽
#define height [UIScreen mainScreen].bounds.size.height//高

@interface ChatViewControl ()

@end

@implementation ChatViewControl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"线上交流";
    
    //self.view.backgroundColor = [UIColor whiteColor];
    [self SetSegmentedControl:_segmentedControl];
    
}

- (void)SetSegmentedControl:(UISegmentedControl *)segmentedControl
{
    segmentedControl = [[UISegmentedControl alloc] init];
    segmentedControl.frame = CGRectMake(0, 0, width, 50);
    [segmentedControl insertSegmentWithTitle:@"学院群" atIndex:0 animated:YES];
    [segmentedControl insertSegmentWithTitle:@"老乡群" atIndex:1 animated:YES];
    
    [segmentedControl setTintColor:[UIColor whiteColor]];
    
    [segmentedControl setBackgroundImage:[UIImage imageNamed:@"all_image_background"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    [segmentedControl addTarget:self action:@selector(segChange:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:segmentedControl];
}

- (void)segChange:(UISegmentedControl *)seg
{
    
    if (seg.selectedSegmentIndex == 0)
    {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(30, 60, width - 60, 60)];
        _textField.borderStyle = UITextBorderStyleRoundedRect;
        _textField.placeholder = @"请输入学院名称";
        
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button setImage:[UIImage imageNamed:@"search.png"] forState:UIControlStateNormal];
        _button.frame = CGRectMake(width - 110, 0, 60, 60);
        
        [_textField addSubview:_button];
        [self.view addSubview:_textField];
        NSLog(@"00");
        
        [_button addTarget:self action:@selector(pressBtn01) forControlEvents:UIControlEventTouchUpInside];
        _tableView.hidden = YES;
    }
    else if (seg.selectedSegmentIndex == 1)
    {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(30, 60, width - 60, 60)];
        _textField.borderStyle = UITextBorderStyleRoundedRect;
        _textField.placeholder = @"请输入区域名";
        
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button setImage:[UIImage imageNamed:@"search.png"] forState:UIControlStateNormal];
        _button.frame = CGRectMake(width - 110, 0, 60, 60);
        
        [_textField addSubview:_button];
        [self.view addSubview:_textField];
        NSLog(@"01");
        
        [_button addTarget:self action:@selector(pressBtn02) forControlEvents:UIControlEventTouchUpInside];
        _tableView.hidden = YES;
    }
}

//解析数据函数
- (void)parseData:(NSDictionary *)dicData
{
    NSArray *arrayEntry = [dicData objectForKey:@"array"];
    for (NSDictionary *dicCollege in arrayEntry)
    {
        NSArray *array01 = [dicCollege objectForKey:@"array1"];
        
        for (NSDictionary *dicArray01 in array01)
        {
            //获取学院QQ群名称
            NSLog(@"%@",[dicArray01 objectForKey:@"name"]);
            [_arrayData01 addObject:[dicArray01 objectForKey:@"name"]];
            [_arrayData02 addObject:[dicArray01 objectForKey:@"code"]];
            
            //判断获取数据是否为空
            if (arrayEntry != nil && ![arrayEntry isKindOfClass:[NSNull class]] && arrayEntry.count != 0)
                [self.view addSubview:_tableView];
        }
    }
    [_tableView reloadData];
}

- (void)pressBtn01
{
    _tableView.hidden = YES;
    NSLog(@"%@",_textField.text);
    //判断输入字符串是否为空值
    NSString *temp = [_textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ([temp length] != 0)
    {
        
        //创建数据视图
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(30, 120, width - 60, 240) style:UITableViewStylePlain];
        
        //设置数据视图代理协议
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        //自动调整视图大小属性
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        
        _arrayData01 = [[NSMutableArray alloc] init];
        _arrayData02 = [[NSMutableArray alloc] init];
        
        //[self initTheData01];
        AFHTTPSessionManager *session02 = [AFHTTPSessionManager manager];
        
        NSString *path02 = [NSString stringWithFormat:@"http://118.24.175.82/search/chatgroup/abstractly?index=学校群&key=%@",_textField.text];
        
        //中文转码
        path02 = [path02 stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        
        NSLog(@"%@",path02);
        [session02 GET:path02 parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"下载成功！");
            
            if ([responseObject isKindOfClass:[NSDictionary class]])
            {
                NSLog(@"dic = %@",responseObject);
                
                [self parseData:responseObject];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
            NSLog(@"下载失败！");
        }];
    }
    else if ([temp length] == 0)
    {
        UIAlertController *_alertController = [UIAlertController alertControllerWithTitle:@"Error" message:@"输入不能为空" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:nil];
        [_alertController addAction:ok];
        
        [self presentViewController:_alertController animated:YES completion:nil];
    }
}
- (void)pressBtn02
{
    _tableView.hidden = YES;
    //NSLog(@"%@",_textField.text);
    //判断输入字符串是否为空值
    NSString *temp = [_textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    NSArray *array = @[@"贵州",@"江苏",@"山西",@"福建",@"安徽",@"陕西",@"广东",@"辽宁",@"海南",@"吉林",@"浙江",@"宁夏",@"湖南",@"天津",@"湖北",@"山东",@"河北",@"四川",@"江西",@"黑龙江",@"河南",@"云南宣威",@"云南玉溪",@"云南曲靖",@"广西贵港",@"广东韶山",@"广东惠州",@"四川成都",@"四川绵阳",@"四川眉山",@"重庆武隆",@"重庆涪陵",@"重庆梁平",@"重庆璧山",@"重庆綦江"];
    NSArray *number = @[@"",@"123736116",@"119738941",@"",@"757804061",@"193388613",@"113179139",@"134489031",@"9334029",@"118060379",@"247010642",@"319432002",@"204491110",@"8690505",@"33861584",@"384043802",@"634830545",@"142604890",@"476426072",@"316348915",@"",@"211910023",@"256581906",@"117499346",@"5819894",@"66484867",@"213337022",@"298299346",@"191653502",@"273968035",@"123122421",@"199748999",@"85423833",@"112571803",@"109665788"];
    if ([temp length] != 0)
    {
        //创建数据视图
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(30, 120, width - 60, 240) style:UITableViewStylePlain];
        
        //设置数据视图代理协议
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        //自动调整视图大小属性
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        
        _arrayData01 = [[NSMutableArray alloc] init];
        _arrayData02 = [[NSMutableArray alloc] init];
        
        NSString *strPosition = _textField.text;
        for (int n = 0; n < [array count]; n ++)
        {
            if ([array[n] rangeOfString:strPosition].location != NSNotFound)
            {
                [_arrayData01 addObject:array[n]];
                [_arrayData02 addObject:number[n]];
                [self.view addSubview:_tableView];
            }
        }
        [_tableView reloadData];
    }
    else if ([temp length] == 0)
    {
        UIAlertController *_alertController = [UIAlertController alertControllerWithTitle:@"Error" message:@"输入不能为空" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:nil];
        [_alertController addAction:ok];
        
        [self presentViewController:_alertController animated:YES completion:nil];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //使虚拟键盘回收，不再做为第一消息响应
    [_textField resignFirstResponder];
    
    _tableView.hidden = YES;
}

//判断是否纯中文
- (BOOL)isChinese:(NSString *)userName
{
    NSString *match = @"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@",match];
    return [predicate evaluateWithObject:userName];
}

//组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//数据的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arrayData01.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *strID = @"ID";
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:strID];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:strID];
    }
    
    cell.textLabel.text = _arrayData01[indexPath.row];
    cell.detailTextLabel.text = _arrayData02[indexPath.row];
    
    return cell;
}

//设置单元格高度
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}


//点击单元格时，调用函数
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@",_arrayData01[indexPath.row]);
    
    UIAlertController *_alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"你已将该群号码复制到剪贴板" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Copy That!" style:UIAlertActionStyleCancel handler:nil];
    
    [_alertController addAction:ok];
    
    [self presentViewController:_alertController animated:YES completion:nil];
    
    UIPasteboard *pad = [UIPasteboard generalPasteboard];
    
    [pad setString:_arrayData02[indexPath.row]];
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
