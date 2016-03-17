//
//  XBSConsultDataBundle.m
//  ConsultingTest
//
//  Created by RainyTunes on 8/22/15.
//  Copyright (c) 2015 RainyTunes. All rights reserved.
//

#import "XBSConsultDataBundle.h"
#import "We.h"
#import "XBSSchduleViewController.h"
#import "MainViewController.h"
#import "ViewController.h"
#import "XBSGradeViewController.h"
#import "ProgressHUD.h"
#import "XBSFindClassroomViewController.h"

@interface XBSConsultDataBundle ()
@end

@implementation XBSConsultDataBundle

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.manager  = [AFHTTPRequestOperationManager manager];
        self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        self.manager.requestSerializer.timeoutInterval = 5;
    }
    return self;
}

- (void)httpPostForSchedule:(NSString *)postType
{
    [ProgressHUD show:ConsultingHint Interaction:NO];
    [self.manager POST:postType parameters:_postParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
        _json = [[XBSConsultDataBundle handleHexDataStream:responseObject] mutableCopy];
        if(_json)
        {
            [self pushToShowResults:postType];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [ProgressHUD showError:ConsultNetworkErrorHint];
    }];
}

- (void)pushToShowResults:(NSString *)type{
    [ProgressHUD showSuccess:ConsultCompleteHint];
    [_json setObject:type forKey:@"type"];
    XBSSchduleViewController *viewController = [[XBSSchduleViewController alloc]init];
    viewController.delegate = self;
    [_mainDelegate presentViewController:viewController animated:YES completion:nil];
}

+ (NSDictionary *)handleHexDataStream:(id)responseObject
{
    NSDictionary *json = [We getDictionaryWithHexData:responseObject];
    NSInteger status = [json[@"status"] integerValue];
    if ([json[@"info"] isEqualToString:@"student id error"]) {
        status = 999;
    }
    if (status == 200) {
        return json;
    }else{
        [ProgressHUD showError:[Config errInfo:status]];
        return nil;
    }
}

- (void)httpPostForGrade {
    [ProgressHUD show:ConsultingHint Interaction:NO];
    self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [self.manager POST:API_EXAM_GRADE parameters:_postParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.htmlString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"%@",self.htmlString);
//        NSLog(@"%@",_postParams);
        XBSGradeViewController *viewController = [[XBSGradeViewController alloc]init];
        viewController.delegate = self;
        [ProgressHUD showSuccess:ConsultCompleteHint];
        [_mainDelegate presentViewController:viewController animated:YES completion:nil];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [ProgressHUD showError:ConsultNetworkErrorHint];
    }];
}

@end
