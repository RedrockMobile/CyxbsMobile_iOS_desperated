//
//  WantToSayController.m
//  MoblieCQUPT_iOS
//
//  Created by J J on 2018/8/14.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "WantToSayController.h"

#define width [UIScreen mainScreen].bounds.size.width//宽
#define height [UIScreen mainScreen].bounds.size.height//高

@interface WantToSayController ()

@end

@implementation WantToSayController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我想对你说";
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timg"]];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewInit) name:@"saveSucessful" object:nil];
    
//    [self getTheData];
    
    [self viewInit];
}

- (void)viewInit
{
 
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, width, height - 65)];
    _scrollView.bounces = YES;
    
    _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"背景"]];
    _imageView.frame = CGRectMake(0, 0, width, width * 2.568);
    _scrollView.contentSize = CGSizeMake(width, width * 2.5);
    
    [_scrollView addSubview:_imageView];
    
    [self.view addSubview:_scrollView];
    
//    _label01 = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, width - 40, width * 2.4185)];
//    _label01.text = _str02;
//    _label01.numberOfLines = 0;
//    
//    [_imageView addSubview:_label01];
//    [_scrollView addSubview:_imageView];
//    [self.view addSubview:_scrollView];
//    [self.view layoutSubviews];
    
//    NSLog(@"%@",_str02);
}



//- (void)getTheData
//{
//
//    AFHTTPSessionManager *session02 = [AFHTTPSessionManager manager];
//
//    NSString *path02 =  @"http://47.106.33.112:8080/welcome2018/data/get/byindex?index=我想对你说&pagenum=1&pagesize=1";
//    //中文转码
//    path02 = [path02 stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
//
//    NSLog(@"%@",path02);
//    [session02 GET:path02 parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"下载成功！");
//
//        if ([responseObject isKindOfClass:[NSDictionary class]])
//        {
//            NSLog(@"dic = %@",responseObject);
//
//            [self parseData:responseObject];
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
//        NSLog(@"下载失败！");
//    }];
//}
//
////解析数据
//- (void)parseData:(NSDictionary *)dicData
//{
//    NSArray *arrayEntry = [dicData objectForKey:@"array"];
//
//    _str01 = [[NSString alloc] init];
//    _str02 = [[NSString alloc] init];
//    _str03 = [[NSString alloc] init];
//    for (NSDictionary *dic in arrayEntry)
//    {
//        NSLog(@"%@",[dic objectForKey:@"name"]);
//        _str01 = [dic objectForKey:@"name"];
//
//        NSLog(@"%@",[dic objectForKey:@"content"]);
//        _str02 = [dic objectForKey:@"content"];
//
////        NSLog(@"%@",[dic objectForKey:@"picture"][0]);
////        _str03 = [dic objectForKey:@"picture"][0];
//    }
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"saveSucessful" object:self];
//}
//

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
