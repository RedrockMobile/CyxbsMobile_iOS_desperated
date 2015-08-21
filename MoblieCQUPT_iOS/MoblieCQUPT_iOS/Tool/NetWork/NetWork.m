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

/**
 *  @author Orange-W, 15-07-24 21:07:26
 *
 *  @brief  快捷 post
 *  @param theModel    model
 *  @param requestUrl  url 地址
 *  @param ditParam   参数
 *  @return  jsonModel 数据对象
 */
+ (void) PostFastObjectFromJsonModel: (id) theModel
                               Url:(NSString*) requestUrl
                         WithParam:(NSDictionary*) ditParam
                       SucessBlock:(SucessWithJson) sucessBlock
                      FailureBlock:(FailureFunction) failureBlock
{
    
    void (^dealWithDataBlock)(id returnValue)= ^(id returnValue){
        NSArray *out = [requestUrl componentsSeparatedByString:@"/"];
        int end = (int)([out count]-1);
        DDLog(@"\n%@获取成功!\n原始数据如下:%@",out[end],returnValue);
        int status = [returnValue[@"status"] intValue];
        
        if(status==Sucess){
            if(sucessBlock != nil){
                sucessBlock(returnValue);
            }
        }else if (status==PurviewNotEnough){
            NSLog(@"权限不够,请先登录!");
            //登录页面调用
        }
    };
    void (^failureDealWithBlock)()=^(){
        NSArray *out = [requestUrl componentsSeparatedByString:@"/"];
        int end = (int)([out count]-1);
        NSLog(@"%@获取失败!",out[end] );
    };
    
    
    if(failureBlock == nil){
        failureBlock = failureDealWithBlock;
    }
    

    [NetWork NetRequestPOSTWithRequestURL       : requestUrl
                                  WithParameter : ditParam
                          WithReturnValeuBlock  : dealWithDataBlock
                             WithFailureBlock   : failureBlock];
}



@end
