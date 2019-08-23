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
        _suShePhoto = [NSMutableArray array];
        _shiTangPhoto = [NSMutableArray array];
        _kuaiDiDetail = [NSMutableArray array];
        _kuaiDi = [NSMutableArray array];
        _kuaiDiNumber = [NSMutableArray array];
        _kuaiDiTitle2 = [NSMutableArray array];
        _kuaiDiDetail2 = [NSMutableArray array];
        _kuaiDiPhoto = [NSMutableArray array];
        _kuaiDiPhoto2 = [NSMutableArray array];
        dispatch_async_on_main_queue(^{
            [self getsuShe];
            [self getsuShePhoto];
            
            [self getshiTang];
            [self getshiTangPhoto];
            
            
            [self getkuaiDi];
            
            [self getxueYuanName];
        });
       
        //接受用户选择的学院
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getUserCollege:) name:@"LQQuserCollege" object:nil];
    }
    return self;
}

-(void)getxueYuanName{
    
    NSString *url = @"https://cyxbsmobile.redrock.team/zscy/zsqy/json/44";
    
    
    //初始化一个HTTP管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain",@"application/json",nil];//解决不能识别json的报错
    //为管理者分配url,参数，成功回掉方法，失败回掉方法
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        _xueYuanName = [NSMutableArray array];

        for(int i = 0;i < 16;i++){
        [_xueYuanName addObject:[NSString stringWithFormat:@"%@",responseObject[@"text"][i][@"name"]]];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败----%@", error);//失败的回调方法
    }];

}

- (void)getsuShe{
    NSString *url = @"https://cyxbsmobile.redrock.team/zscy/zsqy/json/3";
    
    
    //初始化一个HTTP管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain",@"application/json",nil];//解决不能识别json的报错
    
    //为管理者分配url,参数，成功回掉方法，失败回掉方法
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        _suSheDetail = [NSMutableArray array];
        _suShe = [NSMutableArray array];
        
        for(int i = 0;i < 4;i++){
            [_suSheDetail addObject:[NSString stringWithFormat:@"%@",responseObject[@"text"][0][@"message"][i][@"detail"]]];
            [_suShe addObject:[NSString stringWithFormat:@"%@",responseObject[@"text"][0][@"message"][i][@"name"]]];
        }
//        NSLog(@"LQLQLQ%@",_suShe);
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"getSuSheSuccess" object:nil userInfo:@{@"宿舍个数":@(_suShe.count)}];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败----%@", error);//失败的回调方法
    }];

}
-(void)getsuShePhoto{
    NSString *url = @"https://cyxbsmobile.redrock.team/zscy/zsqy/json/3";
    
    
    //初始化一个HTTP管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain",@"application/json",nil];//解决不能识别json的报错
    //为管理者分配url,参数，成功回掉方法，失败回掉方法
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        _suShePhoto = [NSMutableArray array];
        for(int i = 0;i < 4;i++){
            _suShePhoto[i] = [NSMutableArray array];
            for(int j =0; j < 3;j++){
                [_suShePhoto[i] addObject:[NSURL URLWithString:[NSString stringWithFormat:@"https://cyxbsmobile.redrock.team/zscy/zsqy/image/%@",responseObject[@"text"][0][@"message"][i][@"photo"][j]]]];
//                NSLog(@"LQLQQ%@",_suShePhoto[i][j]);

            }

        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败----%@", error);//失败的回调方法
    }];
}
-(void)getshiTang{
    NSString *url = @"https://cyxbsmobile.redrock.team/zscy/zsqy/json/3";
    
    
    //初始化一个HTTP管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain",@"application/json",nil];//解决不能识别json的报错
    //为管理者分配url,参数，成功回掉方法，失败回掉方法
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        _shiTangDetail = [NSMutableArray array];
        _fanTang = [NSMutableArray array];
        for(int i = 0;i < 6;i++){
            [_shiTangDetail addObject:[NSString stringWithFormat:@"%@",responseObject[@"text"][1][@"message"][i][@"detail"]]];
            [_fanTang addObject:[NSString stringWithFormat:@"%@",responseObject[@"text"][1][@"message"][i][@"name"]]];
        }
                [[NSNotificationCenter defaultCenter] postNotificationName:@"getFanTangSuccess" object:nil userInfo:@{@"食堂个数":@(_fanTang.count)}];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败----%@", error);//失败的回调方法
    }];
    
}
-(void)getshiTangPhoto{
    NSString *url = @"https://cyxbsmobile.redrock.team/zscy/zsqy/json/3";
    
    
    //初始化一个HTTP管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain",@"application/json",nil];//解决不能识别json的报错
    //为管理者分配url,参数，成功回掉方法，失败回掉方法
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        for(int i = 0;i < 6;i++){
            _shiTangPhoto[i] = [NSMutableArray array];
            for(int j =0; j < 3;j++){
                [_shiTangPhoto[i] addObject:[NSURL URLWithString:[NSString stringWithFormat:@"https://cyxbsmobile.redrock.team/zscy/zsqy/image/%@",responseObject[@"text"][1][@"message"][i][@"photo"][j]]]];
//                NSLog(@"QLQL%@",_shiTangPhoto[i]);
            }
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败----%@", error);//失败的回调方法
    }];
}


-(void)getkuaiDi{
    NSString *url = EXPRESSAPI;
    
    
    //初始化一个HTTP管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain",@"application/json",nil];//解决不能识别json的报错
    //为管理者分配url,参数，成功回掉方法，失败回掉方法
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        
        for(int i = 0;i < 9;i++){
            [_kuaiDiDetail addObject:[NSString stringWithFormat:@"%@",responseObject[@"text"][i][@"message"][0][@"detail"]]];
            [_kuaiDi addObject:[NSString stringWithFormat:@"%@",responseObject[@"text"][i][@"name"]]];
            
            NSArray *array = [NSArray arrayWithArray: responseObject[@"text"][i][@"message"]];
            [_kuaiDiNumber addObject:@(array.count)];
            if(_kuaiDiNumber[i]==[NSNumber numberWithLong:1]){
                [_kuaiDiTitle2 addObject:@"暂无第二快递点"];
                [_kuaiDiDetail2 addObject:@"暂无第二快递点介绍"];
            }else{
                [_kuaiDiTitle2 addObject:[NSString stringWithFormat:@"%@",responseObject[@"text"][i][@"message"][1][@"title"]]];
                [_kuaiDiDetail2 addObject:[NSString stringWithFormat:@"%@",responseObject[@"text"][i][@"message"][1][@"detail"]]];
            }
        }

        for(int i = 0;i < 9;i++){
            _kuaiDiPhoto[i] = [NSMutableArray array];
            _kuaiDiPhoto2[i] = [NSMutableArray array];
            for(int j =0; j < 1;j++){
                [_kuaiDiPhoto[i] addObject:[NSURL URLWithString:[NSString stringWithFormat:@"https://cyxbsmobile.redrock.team/zscy/zsqy/image/%@",responseObject[@"text"][i][@"message"][0][@"photo"]]]];
                if(_kuaiDiNumber[i]==[NSNumber numberWithLong:1]){//如果快递只有一个取货点
                    [_kuaiDiPhoto2[i] addObject:[NSURL URLWithString:[NSString stringWithFormat:@"https://cyxbsmobile.redrock.team/zscy/zsqy/image/%@",responseObject[@"text"][i][@"message"][0][@"photo"]]]];
                }else{//若有两个取货点
                    [_kuaiDiPhoto2[i] addObject:[NSURL URLWithString:[NSString stringWithFormat:@"https://cyxbsmobile.redrock.team/zscy/zsqy/image/%@",responseObject[@"text"][i][@"message"][1][@"photo"]]]];
                }
//                NSLog(@"LQ%@",_kuaiDiPhoto[i][j]);

            }                
            
        }

                [[NSNotificationCenter defaultCenter] postNotificationName:@"getKuaiDiSuccess" object:nil userInfo:@{@"快递个数":@(_kuaiDi.count)}];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败----%@", error);//失败的回调方法
    }];
    
}







-(void)getUserCollege:(NSNotification*)notification{//同时getbili和最难科目
    NSString *url = @"https://cyxbsmobile.redrock.team/zscy/zsqy/json/44";
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
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"biliDataOK" object:nil];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败----%@", error);//失败的回调方法
    }];

    url =@"https://cyxbsmobile.redrock.team/zscy/zsqy/json/4";
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        _subject = @[@{responseObject[@"text"][collegeIndex][@"message"][0][@"subject"]:responseObject[@"text"][collegeIndex][@"message"][0][@"data"]},@{responseObject[@"text"][collegeIndex][@"message"][1][@"subject"]:responseObject[@"text"][collegeIndex][@"message"][1][@"data"]},@{responseObject[@"text"][collegeIndex][@"message"][2][@"subject"]:responseObject[@"text"][collegeIndex][@"message"][2][@"data"]}];
        NSLog(@"subject is %@",_subject);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"biliDataOK" object:nil];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败----%@", error);//失败的回调方法
    }];

    
}

+ (instancetype)sharedSingleton{
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
