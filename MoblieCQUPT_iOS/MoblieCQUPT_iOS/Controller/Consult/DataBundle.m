//
//  DataBundle.m
//  ConsultingTest
//
//  Created by RainyTunes on 8/22/15.
//  Copyright (c) 2015 RainyTunes. All rights reserved.
//

#import "DataBundle.h"
#import "We.h"
#import "SchduleViewController.h"
#import "MainViewController.h"
#import "ViewController.h"
#import "EmptyRoomsViewController.h"
#import "GradeViewController.h"
#import "ProgressHUD.h"

@interface DataBundle ()
@property (nonatomic, strong) EmptyRoomsViewController *emptyRoomDelegate;

@end

@implementation DataBundle

- (instancetype)init
{
    self = [super init];
    if (self) {
        _manager  = [AFHTTPRequestOperationManager manager];
        _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
    }
    return self;
}

- (void)httpPostForSchedule:(NSString *)postType
{
    [ProgressHUD show:consultingHint];
    [_manager POST:postType parameters:_postParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
        _json = [[self handleHexDataStream:responseObject] mutableCopy];
        if(_json)
        {
            [self pushToShowResults:postType];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [ProgressHUD showError:consultNetworkErrorHint];
    }];
}

- (void)httpPostForEmptyRooms
{
    [ProgressHUD show:consultingHint];
    self.emptyRoomBundle = [[NSMutableArray alloc]init];
    self.flag = 0;
    self.hasCompleted = 0;
    for (int i = 0; i < 5; i++) {
        NSDictionary *param = @{@"sectionNum":[NSString stringWithFormat:@"%d",i]};
        [_manager POST:API_EMPTY_ROOMS parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
            //对「时段数组」进行筛选处理
            NSMutableArray *roomNameArray = [self handleHexDataStream:responseObject][@"data"];
            for (int i = 0;i < roomNameArray.count;i++) {
                unichar c = [roomNameArray[i] characterAtIndex:0];
                if (c < '2' || c > '8') {
                    roomNameArray[i] = @"";
                }
            }
            [roomNameArray removeObject:@""];
            //「时段数组」加入「当日数组」
            [self.emptyRoomBundle addObject:roomNameArray];
            self.hasCompleted++;
            // 如果这是最后一个网络请求了
            if (self.hasCompleted == 5) {
                [ProgressHUD showSuccess:consultCompleteHint];
                EmptyRoomsViewController *viewController = [[EmptyRoomsViewController alloc]init];
                viewController.delegate = self;
                self.emptyRoomDelegate = viewController;
                [self.mainDelegate presentViewController:viewController animated:YES completion:nil];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            if (self.flag == 0) {
                self.flag = -1;
                [ProgressHUD showError:consultNetworkErrorHint];
            }
        }];
    }
}

- (void)pushToShowResults:(NSString *)type{
    [ProgressHUD showSuccess:consultCompleteHint];
    [_json setObject:type forKey:@"type"];
    SchduleViewController *viewController = [[SchduleViewController alloc]init];
    viewController.delegate = self;
    [_mainDelegate presentViewController:viewController animated:YES completion:nil];
}

- (NSDictionary *)handleHexDataStream:(id)responseObject
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
    [ProgressHUD show:consultingHint];
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [_manager POST:API_EXAM_GRADE parameters:_postParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.htmlString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        GradeViewController *viewController = [[GradeViewController alloc]init];
        viewController.delegate = self;
        [ProgressHUD showSuccess:consultCompleteHint];
        [_mainDelegate presentViewController:viewController animated:YES completion:nil];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [ProgressHUD showError:consultNetworkErrorHint];
    }];
}

- (NSString *)getUserHint {
    int flag1 = 0;
    int flag2 = 0;
    for (int i = 0; i < 5; i++) {
        if ([self.emptyRoomDelegate.buildCheckboxGroup[i] isChecked]) {
            flag1++;
        }
        if ([self.emptyRoomDelegate.periodCheckboxGroup[i] isChecked]) {
            flag2++;
        }
    }
    
    self.emptyRoomDelegate.lock = YES;
    if (flag1 != 5 && [self.emptyRoomDelegate.buildCheckboxGroup[5] isChecked]) {
        [self.emptyRoomDelegate.buildCheckboxGroup[5] uncheckAnimated:YES];
    }
    if (flag2 != 5 && [self.emptyRoomDelegate.periodCheckboxGroup[5] isChecked]) {
        [self.emptyRoomDelegate.periodCheckboxGroup[5] uncheckAnimated:YES];
    }
    self.emptyRoomDelegate.lock = NO;
    
    if (flag1 != 0 && flag2 == 0) {
        return periodGroupUncheckHint;
    }else if (flag1 == 0 && flag2 != 0) {
        return roomGroupUncheckHint;
    }else if (flag1 == 0 && flag2 ==0) {
        return bothGroupsUncheckHint;
    }else {
        return [self.emptyRoomDelegate refreshResult];
    }
}


@end
