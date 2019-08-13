//
//  DataMode.m
//  MoblieCQUPT_iOS
//
//  Created by 千千 on 2019/8/2.
//  Copyright © 2019 Orange-W. All rights reserved.
//

#import "LQQDataModel.h"
@implementation LQQDataModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _firstDataTitle = @[@"宿舍",@"食堂",@"快递",@"数据揭秘"];
        _shuJuJieMi = @[@"最难科目",@"男女比例"];
        
        [self getsuShe];
        [self getsuShePhoto];
        
        [self getshiTang];
        [self getshiTangPhoto];
        
        
        [self getkuaiDiPhoto];
        [self getkuaiDi];
        
        [self getxueYuanName];
        //接受用户选择的学院
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getUserCollege:) name:@"LQQuserCollege" object:nil];
        
    }
    return self;
}

-(void)getxueYuanName{
    //http://129.28.185.138:9025/zsqy/json/44
    
    NSString *url = @"http://129.28.185.138:9025/zsqy/json/44";
    
    
    //初始化一个HTTP管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain",@"application/json",nil];//解决不能识别json的报错
    //为管理者分配url,参数，成功回掉方法，失败回掉方法
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        _xueYuanName = [NSMutableArray array];
        
        for(int i = 0;i < 16;i++){
            [_xueYuanName addObject:[NSString stringWithFormat:@"%@",responseObject[@"text"][i][@"name"]]];
            NSLog(@"%@QWWQ",_xueYuanName);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败----%@", error);//失败的回调方法
    }];
    
}

-(void)getsuShe{
    NSString *url = @"http://129.28.185.138:9025/zsqy/json/3";
    
    
    //初始化一个HTTP管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain",@"application/json",nil];//解决不能识别json的报错
    //为管理者分配url,参数，成功回掉方法，失败回掉方法
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        _suSheDetail = [NSMutableArray array];
        
        for(int i = 0;i < 4;i++){
            [_suSheDetail addObject:[NSString stringWithFormat:@"%@",responseObject[@"text"][0][@"message"][i][@"detail"]]];
            NSLog(@"%@",_suSheDetail[i]);
            [_suShe addObject:[NSString stringWithFormat:@"%@",responseObject[@"text"][0][@"message"][i][@"name"]]];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败----%@", error);//失败的回调方法
    }];
    
}
-(void)getsuShePhoto{
    NSString *url = @"http://129.28.185.138:9025/zsqy/json/3";
    
    
    //初始化一个HTTP管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain",@"application/json",nil];//解决不能识别json的报错
    //为管理者分配url,参数，成功回掉方法，失败回掉方法
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        _suShePhoto = [NSMutableArray array];
        
        for(int i = 0;i < 4;i++){
            for(int j =0; j < 3;j++){
                _suShePhoto[i] = [NSMutableArray array];
                [_suShePhoto[i] addObject:[NSURL URLWithString:[NSString stringWithFormat:@"http://129.28.185.138:9025/zsqy/image/%@",responseObject[@"text"][0][@"message"][i][@"photo"][j]]]];
            }
            NSLog(@"LQLQQ%@",_suShePhoto);
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败----%@", error);//失败的回调方法
    }];
}
-(void)getshiTang{
    NSString *url = @"http://129.28.185.138:9025/zsqy/json/3";
    
    
    //初始化一个HTTP管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain",@"application/json",nil];//解决不能识别json的报错
    //为管理者分配url,参数，成功回掉方法，失败回掉方法
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        _shiTangDetail = [NSMutableArray array];
        _fanTang = [NSMutableArray array];
        for(int i = 0;i < 6;i++){
            [_shiTangDetail addObject:[NSString stringWithFormat:@"%@",responseObject[@"text"][1][@"message"][i][@"detail"]]];
            NSLog(@"%@",_shiTangDetail[i]);
            [_fanTang addObject:[NSString stringWithFormat:@"%@",responseObject[@"text"][1][@"message"][i][@"name"]]];
        }
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败----%@", error);//失败的回调方法
    }];
    
}
-(void)getshiTangPhoto{
    NSString *url = @"http://129.28.185.138:9025/zsqy/json/3";
    
    
    //初始化一个HTTP管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain",@"application/json",nil];//解决不能识别json的报错
    //为管理者分配url,参数，成功回掉方法，失败回掉方法
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        _shiTangPhoto = [NSMutableArray array];
        for(int i = 0;i < 6;i++){
            for(int j =0; j < 3;j++){
                _shiTangPhoto[i] = [NSMutableArray array];
                [_shiTangPhoto[i] addObject:[NSURL URLWithString:[NSString stringWithFormat:@"http://129.28.185.138:9025/zsqy/image/%@",responseObject[@"text"][1][@"message"][i][@"photo"][j]]]];
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败----%@", error);//失败的回调方法
    }];
}


-(void)getkuaiDi{
    NSString *url = @"http://129.28.185.138:9025/zsqy/json/33";
    
    
    //初始化一个HTTP管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain",@"application/json",nil];//解决不能识别json的报错
    //为管理者分配url,参数，成功回掉方法，失败回掉方法
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        _kuaiDiDetail = [NSMutableArray array];
        _kuaiDi = [NSMutableArray array];
        for(int i = 0;i < _kuaiDi.count;i++){
            [_kuaiDiDetail addObject:[NSString stringWithFormat:@"%@",responseObject[@"text"][i][@"message"][0][@"detail"]]];
            [_kuaiDi addObject:[NSString stringWithFormat:@"%@",responseObject[@"text"][i][@"message"][0][@"name"]]];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败----%@", error);//失败的回调方法
    }];
    
}
-(void)getkuaiDiPhoto{
    NSString *url = @"http://129.28.185.138:9025/zsqy/json/33";
    
    
    //初始化一个HTTP管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain",@"application/json",nil];//解决不能识别json的报错
    //为管理者分配url,参数，成功回掉方法，失败回掉方法
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        _kuaiDiPhoto = [NSMutableArray array];
        
        for(int i = 0;i < _kuaiDi.count;i++){
            for(int j =0; j < 1;j++){
                _kuaiDiPhoto[i] = [NSMutableArray array];
                [_kuaiDiPhoto[i] addObject:[NSURL URLWithString:[NSString stringWithFormat:@"http://129.28.185.138:9025/zsqy/image/%@",responseObject[@"text"][i][@"message"][0][@"photo"]]]];
                NSLog(@"快递照片URLis%@",_kuaiDiPhoto);
            }
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败----%@", error);//失败的回调方法
    }];
}






-(void)getUserCollege:(NSNotification*)notification{//同时getbili和最难科目
    NSString *url = @"http://129.28.185.138:9025/zsqy/json/44";
    NSLog(@"QLLQQQ%@",notification.userInfo[@"用户选择的学院"]);
    static int collegeIndex = 0;//记录用户所选择学院的下标
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain",@"application/json",nil];//解决不能识别json的报错
    //为管理者分配url,参数，成功回掉方法，失败回掉方法
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //遍历最难科目的不同name来确定下标亦用作获取比例和最难科目
        for(int i = 0 ; i < 16;i++){
            if([notification.userInfo[@"用户选择的学院"] isEqualToString:[NSString stringWithFormat:@"%@",responseObject[@"text"][i][@"name"]]])
            {
                collegeIndex = i;
                break;
            }
        }
        NSLog(@"下标是%d",collegeIndex);
        
        _biLi = @[[NSString stringWithFormat:@"%@",responseObject[@"text"][collegeIndex][@"girl"]],[NSString stringWithFormat:@"%@",responseObject[@"text"][collegeIndex][@"boy"]]];
        NSLog(@"The bili is %@",_biLi);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败----%@", error);//失败的回调方法
    }];
    url =@"http://129.28.185.138:9025/zsqy/json/4";
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        _subject = @[@{responseObject[@"text"][collegeIndex][@"message"][0][@"subject"]:responseObject[@"text"][collegeIndex][@"message"][0][@"data"]},@{responseObject[@"text"][collegeIndex][@"message"][1][@"subject"]:responseObject[@"text"][collegeIndex][@"message"][1][@"data"]},@{responseObject[@"text"][collegeIndex][@"message"][2][@"subject"]:responseObject[@"text"][collegeIndex][@"message"][2][@"data"]}];
        NSLog(@"subject is %@",_subject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败----%@", error);//失败的回调方法
    }];
    
    
}

+ (instancetype)sharedSingleton {
    static LQQDataModel *_sharedSingleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //不能再使用alloc方法
        //因为已经重写了allocWithZone方法，所以这里要调用父类的分配空间的方法
        _sharedSingleton = [[super allocWithZone:NULL] init];
    });
    return _sharedSingleton;
}
@end
