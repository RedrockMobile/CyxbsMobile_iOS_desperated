//
//  NetWork.m
//  OrangeFrame
//
//  Created by user on 15/7/16.
//  Copyright (c) 2015年 Orange-W. All rights reserved.
//


#import "NetWork.h"
#import "ORWRequestCache.h"

@implementation NetWork




#pragma 监测网络的可链接性
+ (BOOL) netWorkReachability:(NSString *) strUrl
{
    __block BOOL isReachability = NO;
    
    NSURL *baseURL = [NSURL URLWithString:strUrl];
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];
    
    NSOperationQueue *operationQueue = manager.operationQueue;
    
    [manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
            case AFNetworkReachabilityStatusReachableViaWiFi:
                [operationQueue setSuspended:NO];
                isReachability = YES;
                break;
            case AFNetworkReachabilityStatusNotReachable:
                isReachability = NO;
            default:
                [operationQueue setSuspended:YES];
                break;
        }
    }];
    [manager.reachabilityManager startMonitoring];
    
    return isReachability;
}


/***************************************
 在这做判断如果有dic里有errorCode
 调用errorBlock(dic)
 没有errorCode则调用block(dic
 ******************************/

#pragma --mark GET请求方式
+ (void) NetRequestGETWithRequestURL: (NSString *) requestURLString
                       WithParameter: (NSDictionary *) parameter
                WithReturnValeuBlock: (SucessWithJson) successFunction
                 // WithErrorCodeBlock: (ErrorCode) errorBlock
                    WithFailureBlock: (FailureFunction) failureFunction
{

    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
//    manager = [self addCommonHeader:manager withUserToken:nil];//header
    AFHTTPRequestOperation *op = [manager GET:requestURLString parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
       // DDLog(@"%@", dic);
        if(successFunction){
            successFunction(dic);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
      if(failureFunction){
            failureFunction();
      }
    }];
    
    op.responseSerializer = [AFHTTPResponseSerializer serializer];
    [op start];
    
}

#pragma --mark POST请求方式

+ (void) NetRequestPOSTWithRequestURL: (NSString *) requestURLString
                        WithParameter: (NSDictionary *) parameter
                 WithReturnValeuBlock: (SucessWithJson) block
                   //WithErrorCodeBlock: (ErrorCode) errorBlock
                     WithFailureBlock: (FailureFunction) failureBlock
{
//    ORWRequestCache *cache = [[ORWRequestCache alloc] init];
//    [cache isOutOfDateWithUrl:requestURLString];
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
//    manager =[self addCommonHeader:manager withUserToken:nil];//header
    AFHTTPRequestOperation *op = [manager POST:requestURLString parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        //DDLog(@"%@", dic);
        if(block){
//            self.database_path = [documents stringByAppendingPathComponent:DBNAME];
//            self.db = [FMDatabase databaseWithPath:self.database_path];
            block(dic);
        }else{
            NSLog(@"无成功调用");
        }
        
        /***************************************
         在这做判断如果有dic里有errorCode
         调用errorBlock(dic)
         没有errorCode则调用block(dic
         ******************************/
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(failureBlock){
            failureBlock();
        } else{
            NSLog(@"无失败调用");
        }
        
    }];
    
    op.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [op start];
}

/**
 *  @author Orange-W, 15-07-21 23:07:14
 *
 *  @brief  公共 header
 *
 *  @param manager   当前请求的mangager类
 *  @param userToken  用户token
 */
+ (AFHTTPRequestOperationManager*) addCommonHeader: (AFHTTPRequestOperationManager*) manager
         withUserToken  : (NSString *) userToken{
    NSString * token = [NSString stringWithFormat:@"{\"token\":\"%@\",\"type\":\"android\",\"version\":\"10\"}",@"dfc200eb0e78a4904d0bb324aa90ebb5" ];
    
    NSLog(@"%@",token);
    
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"token"];
    return manager;
}

+ (void)uploadImageWithUrl:(NSString *)URL
             WithParameter:(NSDictionary *)params
           WithUploadImage:(UIImage *)image
      WithReturnValueBlock:(SucessWithJson) block
          WithFailureBlock:(FailureFunction) failureBlock {
    
//    //获取图片路径
//    NSString *fileName = @"pic";
//    NSURL *filePath = [[NSBundle mainBundle] URLForResource:fileName withExtension:@"png"];
    //奖图片写入Document文件目录下
    NSData *imgData = UIImageJPEGRepresentation(image, 0.5);
    NSDate *currentTime = [NSDate date];
    NSString *imgName = [NSString stringWithFormat:@"%@",currentTime];
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imgName];
    [imgData writeToFile:fullPath atomically:NO];
    NSURL *filePath = [NSURL URLWithString:fullPath];
    // 额外请求参数
//    NSDictionary *params = @{@"name":@"pic.png"};
    // 请求地址
//    NSString* url = [NSString stringWithFormat:@"%@%@", SERVER_URL, @"uploadPicture" ];
    
    // 初始化请求的manager.
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    /*
     设置请求头的contentTypes 以下两种方法任选一种
     也可以修改AFHTTPResponseSerialization.m 里面的self.acceptableContentTypes（添加@"text/html"）.
     */
    //    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    //    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    // 将request与response序列化
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    // 发送post请求.
    [manager POST:URL parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        /**
         *  appendPartWithFileURL   //  指定上传的文件
         *  name                    //  指定在服务器中获取对应文件或文本时的key
         *  fileName                //  指定上传文件的原始文件名
         *  mimeType                //  指定上传文件的MIME类型
         */
        [formData appendPartWithFileURL:filePath name:@"fold" error:nil];
        
    } success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSLog(@"uploadSuccess!");
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        if(block){
            block(dic);
        }else{
            NSLog(@"无成功调用");
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"failure uploaded!. err:%@", error);
        
    }];
}

@end
