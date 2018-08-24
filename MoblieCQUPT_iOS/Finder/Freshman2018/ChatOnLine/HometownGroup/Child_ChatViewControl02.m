//
//  Child_ChatViewControl02ViewController.m
//  MoblieCQUPT_iOS
//
//  Created by J J on 2018/8/20.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "Child_ChatViewControl02.h"

@interface Child_ChatViewControl02 ()

@end

@implementation Child_ChatViewControl02

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"老乡群");
    
    [self setView];
}

- (void)setView
{
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(30, 30, SCREENWIDTH - 60, 60)];
    _textField.borderStyle = UITextBorderStyleRoundedRect;
    _textField.placeholder = @"请输入区域名";
    
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    [_button setImage:[UIImage imageNamed:@"search.png"] forState:UIControlStateNormal];
    _button.frame = CGRectMake(SCREENWIDTH - 110, 0, 60, 60);
    
    [_textField addSubview:_button];
    [self.view addSubview:_textField];
    
    [_button addTarget:self action:@selector(pressBtn02) forControlEvents:UIControlEventTouchUpInside];
    _tableView.hidden = YES;
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
    //刷新
    [_tableView reloadData];
}

- (void)pressBtn02
{
    _tableView.hidden = YES;
    //判断输入字符串是否为空值
    NSString *temp = [_textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ([temp length] != 0)
    {
        //创建数据视图
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(30, 90, SCREENWIDTH - 60, 240) style:UITableViewStylePlain];
        
        //设置数据视图代理协议
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        //自动调整视图大小属性
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        
        _arrayData01 = [[NSMutableArray alloc] init];
        _arrayData02 = [[NSMutableArray alloc] init];
        
        AFHTTPSessionManager *session02 = [AFHTTPSessionManager manager];
        
        NSString *path02 = [NSString stringWithFormat:@"http://wx.yyeke.com/welcome2018/search/chatgroup/abstractly?index=老乡群&key=%@",_textField.text];
        
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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //使键盘回收，不再做为第一消息响应
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

//懒加载
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *strID = @"ID";
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:strID];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:strID];
    }
    
    cell.textLabel.text = _arrayData01[indexPath.row];
    cell.textLabel.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    cell.detailTextLabel.text = _arrayData02[indexPath.row];
    cell.detailTextLabel.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    
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
