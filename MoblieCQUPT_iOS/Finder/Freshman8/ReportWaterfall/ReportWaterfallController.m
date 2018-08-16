//
//  ReportWaterfallController.m
//  MoblieCQUPT_iOS
//
//  Created by J J on 2018/8/12.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import "ReportWaterfallController.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"



#define width [UIScreen mainScreen].bounds.size.width//宽
#define height [UIScreen mainScreen].bounds.size.height//高

@interface ReportWaterfallController ()

@end

NSString *str01;
NSString *str02;
NSString *str03;
NSString *str04;

@implementation ReportWaterfallController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewInit) name:@"saveSuccessful" object:nil];
    
    //标题文字
    self.title = @"报道流程";
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"BackGround"]];

    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 60, width, height)];
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.bounces = YES;
    //画布大小
    _scrollView.contentSize = CGSizeMake(width, height - 60);
    [self.view addSubview:_scrollView];
    
    //网络请求
    [self getTheData];
    
    //初始化体育馆/宿舍
    _view01 = [[UIView alloc] init];
    _view02 = [[UIView alloc] init];
    _label01 = [[UILabel alloc] init];
    _label03 = [[UILabel alloc] init];
    _label02 = [[UILabel alloc] init];
    _label04 = [[UILabel alloc] init];
    _button01 = [UIButton buttonWithType:UIButtonTypeCustom];
    _button02 = [UIButton buttonWithType:UIButtonTypeCustom];
    _imageView01 = [[UIImageView alloc] init];
    _imageView02 = [[UIImageView alloc] init];
    _imageView03 = [[UIImageView alloc] init];
    _imageView04 = [[UIImageView alloc] init];
    
    //[self viewInit];
}

- (void)viewInit
{
    //体育馆
    _view01.frame = CGRectMake(0, 0, width, (height - 100) / 2);
    _view01.backgroundColor = [UIColor clearColor];
    _label01.frame = CGRectMake(20, 10, 200, 30);
    _label01.text = _arrayData01[0];
    _label03.frame = CGRectMake(20, (height - 100) / 2 * 3 / 4, width - 40, 30);
    _label03.text = @"点击按钮，查看具体流程";
    _label03.numberOfLines = 0;
    
    //设置字体样式
    _label01.font = [UIFont fontWithName:@"AaPangYaer" size:19.f];
    _label03.font = [UIFont fontWithName:@"AaPangYaer" size:19.f];

    _imageView01.frame = CGRectMake(20, 40, (width - 60) / 2, (height - 100) * 3 / 8 - 40);
    [_imageView01 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://47.106.33.112:8080/welcome2018%@",_arr[0]]] placeholderImage:nil];
    _imageView02.frame = CGRectMake(width / 2 + 10, 40, (width - 60) / 2, (height - 100) * 3 / 8 - 40);
    [_imageView02 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://47.106.33.112:8080/welcome2018%@",_arr[1]]] placeholderImage:nil];
    
    //圆角处理
    _imageView01.layer.cornerRadius = 20;
    _imageView01.layer.masksToBounds = YES;
    _imageView02.layer.cornerRadius = 20;
    _imageView02.layer.masksToBounds = YES;
    
    [_view01 addSubview:_label01];
    [_view01 addSubview:_label03];
    [_view01 addSubview:_imageView01];
    [_view01 addSubview:_imageView02];

    //寝室
    _view02.frame = CGRectMake(0, (height - 100) / 2 + 40, width, (height - 100) / 2);
    _view02.backgroundColor = [UIColor clearColor];
    _label02.frame = CGRectMake(20, 10, 200, 30);
    _label02.text = _arrayData01[1];
    _label04.frame = CGRectMake(20, (height - 100) / 2 * 3 / 4, width - 40, 30);
    _label04.text = @"点击按钮，查看具体流程";
    _label04.numberOfLines = 0;

    //设置字体样式
    _label02.font = [UIFont fontWithName:@"AaPangYaer" size:19.f];
    _label04.font = [UIFont fontWithName:@"AaPangYaer" size:19.f];
    
    _imageView03.frame = CGRectMake(20, 40, (width - 60) / 2, (height - 100) * 3 / 8 - 40);
    [_imageView03 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://47.106.33.112:8080/welcome2018%@",_arr[2]]] placeholderImage:nil];
    _imageView04.frame = CGRectMake(width / 2 + 10, 40, (width - 60) / 2, (height - 100) * 3 / 8 - 40);
    [_imageView04 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://47.106.33.112:8080/welcome2018%@",_arr[3]]] placeholderImage:nil];
    
    //圆角处理
    _imageView03.layer.cornerRadius = 20;
    _imageView03.layer.masksToBounds = YES;
    _imageView04.layer.cornerRadius = 20;
    _imageView04.layer.masksToBounds = YES;
    
    [_view02 addSubview:_label02];
    [_view02 addSubview:_label04];
    [_view02 addSubview:_imageView03];
    [_view02 addSubview:_imageView04];

    //体育馆button01
    _button01.frame = CGRectMake(width / 2 - 15, (height - 100) / 2 * 3 / 4 + 30, 30, 30);
    [_button01 setImage:[UIImage imageNamed:@"button"] forState:UIControlStateNormal];
    [_view01 addSubview:_button01];
    _button01.tag = 0;
    [_button01 addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];

    //宿舍button02
    _button02.frame = CGRectMake(width / 2 - 15, (height - 100) / 2 * 3 / 4 + 30, 30, 30);
    [_button02 setImage:[UIImage imageNamed:@"button"] forState:UIControlStateNormal];
    [_view02 addSubview:_button02];
    _button02.tag = 1;
    [_button02 addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];

    [_scrollView addSubview:_view01];
    [_scrollView addSubview:_view02];
}


- (void)pressBtn:(UIButton *)btn
{
    if (btn.tag == 0)
    {
        _scrollView.contentSize = CGSizeMake(width, height * 3 / 2 - 10);
        _view01.frame = CGRectMake(0, 0, width, height - 60);
        _label03.text = _arrayData02[0];
        _label03.frame = CGRectMake(20, (height - 100) / 2 * 3 / 4, width - 40, height - 60 - (height - 100) / 2 * 3 / 4 - 60);
//        _label03.numberOfLines = 0;
        NSLog(@"%@",_arrayData02[0]);
        [_button01 setImage:[UIImage imageNamed:@"upBtn"] forState:UIControlStateNormal];
        _button01.frame = CGRectMake(width / 2 - 15, height - 120, 30, 30);
        _button01.tag = 3;
        [_button01 addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        //宿舍位置复原
        _view02.frame = CGRectMake(0, height - 20, width, (height - 100) / 2);
        _label04.text = @"点击按钮，查看具体流程";
        _label04.frame = CGRectMake(20, (height - 100) / 2 * 3 / 4, width - 40, 30);
        _imageView03.frame = CGRectMake(20, 40, (width - 60) / 2, (height - 100) * 3 / 8 - 40);
        _imageView04.frame = CGRectMake(width / 2 + 10, 40, (width - 60) / 2, (height - 100) * 3 / 8 - 40);
        _button02.frame = CGRectMake(width / 2 - 15, (height - 100) / 2 * 3 / 4 + 30, 30, 30);
        [_button02 setImage:[UIImage imageNamed:@"button"] forState:UIControlStateNormal];
        
    }
    else if (btn.tag == 1)
    {
        _scrollView.contentSize = CGSizeMake(width, height * 3 / 2 - 10);
        _view02.frame = CGRectMake(0, (height - 100) / 2 + 40, width, height - 60);
        _label04.text = _arrayData02[1];
        _label04.frame = CGRectMake(20, (height - 100) / 2 * 3 / 4, width - 40, height - 60 - (height - 100) / 2 * 3 / 4 - 60);
//        _label04.numberOfLines = 0;
        //NSLog(@"%@",_arrayData02[1]);
        _button02.frame = CGRectMake(width / 2 - 15, height - 120, 30, 30);
        [_button02 setImage:[UIImage imageNamed:@"upBtn"] forState:UIControlStateNormal];
        _button02.tag = 3;
        [_button02 addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        //体育馆位置复原
        _view01.frame = CGRectMake(0, 0, width, (height - 100) / 2);
        _label03.text = @"点击按钮，查看具体流程";
        _label03.frame = CGRectMake(20, (height - 100) / 2 * 3 / 4, width - 40, 30);
        _imageView01.frame = CGRectMake(20, 40, (width - 60) / 2, (height - 100) * 3 / 8 - 40);
        _imageView02.frame = CGRectMake(width / 2 + 10, 40, (width - 60) / 2, (height - 100) * 3 / 8 - 40);
        _button01.frame = CGRectMake(width / 2 - 15, (height - 100) / 2 * 3 / 4 + 30, 30, 30);
        [_button01 setImage:[UIImage imageNamed:@"button"] forState:UIControlStateNormal];
    }
    else if (btn.tag == 3)
    {
        _scrollView.contentSize = CGSizeMake(width, height - 60);
        
        
        //体育馆
        _view01.frame = CGRectMake(0, 0, width, (height - 100) / 2);
        _label01.frame = CGRectMake(20, 10, 200, 30);
        _label03.frame = CGRectMake(20, (height - 100) / 2 * 3 / 4, width - 40, 30);
        _label03.text = @"点击按钮，查看具体流程";
        _label03.numberOfLines = 0;
        _imageView01.frame = CGRectMake(20, 40, (width - 60) / 2, (height - 100) * 3 / 8 - 40);
        _imageView02.frame = CGRectMake(width / 2 + 10, 40, (width - 60) / 2, (height - 100) * 3 / 8 - 40);
        
        //寝室
        _view02.frame = CGRectMake(0, (height - 100) / 2 + 40, width, (height - 100) / 2);
        _label02.frame = CGRectMake(20, 10, 200, 30);
        _label04.frame = CGRectMake(20, (height - 100) / 2 * 3 / 4, width - 40, 30);
        _label04.text = @"点击按钮，查看具体流程";
        _label04.numberOfLines = 0;
        _imageView03.frame = CGRectMake(20, 40, (width - 60) / 2, (height - 100) * 3 / 8 - 40);
        _imageView04.frame = CGRectMake(width / 2 + 10, 40, (width - 60) / 2, (height - 100) * 3 / 8 - 40);
        
        
        //体育馆button01
        _button01.frame = CGRectMake(width / 2 - 15, (height - 100) / 2 * 3 / 4 + 30, 30, 30);
        [_button01 setImage:[UIImage imageNamed:@"button"] forState:UIControlStateNormal];
        [_view01 addSubview:_button01];
        _button01.tag = 0;
        [_button01 addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        
        //宿舍button02
        _button02.frame = CGRectMake(width / 2 - 15, (height - 100) / 2 * 3 / 4 + 30, 30, 30);
        [_button02 setImage:[UIImage imageNamed:@"button"] forState:UIControlStateNormal];
        [_view02 addSubview:_button02];
        _button02.tag = 1;
        [_button02 addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
}

//网络请求

- (void)getTheData
{
    
    AFHTTPSessionManager *session02 = [AFHTTPSessionManager manager];
    
    NSString *path02 = @"http://47.106.33.112:8080/welcome2018/data/get/byindex?index=报道流程&pagenum=1&pagesize=2";
    
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
    //获取name;
    _arrayData01 = [[NSMutableArray alloc] init];
    //获取content
    _arrayData02 = [[NSMutableArray alloc] init];
    
    _arr = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in arrayEntry)
    {
        [_arrayData01 addObject:[dic objectForKey:@"name"]];
        NSLog(@"%@",[dic objectForKey:@"name"]);
        
    
        [_arrayData02 addObject:[dic objectForKey:@"content"]];
        NSLog(@"%@",[dic objectForKey:@"content"]);
        
        _arrayData03 = [dic objectForKey:@"picture"];
        NSLog(@"%@ + hello",_arrayData03);
        [_arr addObject:_arrayData03[0]];
        [_arr addObject:_arrayData03[1]];
        //NSLog(@"%@ + %@",_arrayData03[0],_arrayData03[1]);
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"saveSuccessful" object:self];

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
