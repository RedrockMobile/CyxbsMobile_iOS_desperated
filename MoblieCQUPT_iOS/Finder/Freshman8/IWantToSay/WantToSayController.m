//
//  WantToSayController.m
//  MoblieCQUPT_iOS
//
//  Created by J J on 2018/8/14.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "WantToSayController.h"

@interface WantToSayController ()

@end

@implementation WantToSayController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我想对你说";
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timg"]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewInit) name:@"saveSucessful" object:nil];
    
    [self getTheData];
}

- (void)viewInit
{
    _label01 = [[UILabel alloc] initWithFrame:CGRectMake(20, 70, SCREENWIDTH - 40, SCREENHEIGHT - 60)];
    _label01.text = _str02;
    _label01.numberOfLines = 0;
    [self.view addSubview:_label01];
}

- (void)getTheData
{
    
    AFHTTPSessionManager *session02 = [AFHTTPSessionManager manager];
    
    NSString *path02 =  @"http://118.24.175.82/data/get/byindex?index=我想对你说&pagenum=1&pagesize=1";
    
    
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

//解析数据
- (void)parseData:(NSDictionary *)dicData
{
    NSArray *arrayEntry = [dicData objectForKey:@"array"];
    
    _str01 = [[NSString alloc] init];
    _str02 = [[NSString alloc] init];
    _str03 = [[NSString alloc] init];
    for (NSDictionary *dic in arrayEntry)
    {
        NSLog(@"%@",[dic objectForKey:@"name"]);
        _str01 = [dic objectForKey:@"name"];
        
        NSLog(@"%@",[dic objectForKey:@"content"]);
        _str02 = [dic objectForKey:@"content"];

        NSLog(@"%@",[dic objectForKey:@"picture"][0]);
        _str03 = [dic objectForKey:@"picture"][0];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"saveSucessful" object:self];
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
