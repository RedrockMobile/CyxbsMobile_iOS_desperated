//
//  NetWork.m
//  OrangeFrame
//
//  Created by user on 15/7/16.
//  Copyright (c) 2015年 Orange-W. All rights reserved.
//


#import "NetWork.h"


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




@end
