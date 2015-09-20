//
//  XBSFindClassroomModel.m
//  MoblieCQUPT_iOS
//
//  Created by RainyTunes on 9/14/15.
//  Copyright (c) 2015 Orange-W. All rights reserved.
//

#import "XBSFindClassroomModel.h"
#import "ProgressHUD.h"
#import "XBSConsultConfig.h"
#import "AFNetworking.h"
#import "XBSFindClassroomViewController.h"
#import "XBSConsultDataBundle.h"
#import "XBSFindClassroomPeriodView.h"
#import "We.h"

@interface XBSFindClassroomModel ()
@property (nonatomic, strong) AFHTTPRequestOperationManager *manager;
@property (nonatomic, strong) XBSFindClassroomViewController *findClassroomDelegate;
@end

@implementation XBSFindClassroomModel


- (void)httpPostForEmptyClassroom {
    [ProgressHUD show:ConsultingHint Interaction:NO];
    for (int i = 0; i < 6; i++) {
        NSDictionary *param = @{@"sectionNum":[NSString stringWithFormat:@"%d",i]};
        [self.manager POST:API_EMPTY_ROOMS parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
            //对「时段数组」进行筛选处理
            NSMutableArray *arr = [XBSConsultDataBundle handleHexDataStream:responseObject][@"data"];
            for (int i = 0;i < arr.count;i++) {
                unichar c = [arr[i] characterAtIndex:0];
                if (c < '2' || c > '8') {
                    arr[i] = @"";
                }
            }
            [arr removeObject:@""];
            //「时段数组」加入「当日数组」
            [self.availableClassroomArray addObject:arr];
            self.hasCompleted++;
            // 如果这是最后一个网络请求了
            if (self.hasCompleted == 6) {
                [ProgressHUD showSuccess:ConsultCompleteHint];
                XBSFindClassroomViewController *vc = [[XBSFindClassroomViewController alloc]init];
                vc.model = self;
                self.findClassroomDelegate = vc;
                [self.mainDelegate presentViewController:vc animated:YES completion:nil];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                [ProgressHUD showError:ConsultNetworkErrorHint];
        }];
    }
}

- (instancetype)init {
    self = [super init];
    self.manager                    = [AFHTTPRequestOperationManager manager];
    self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    self.manager.requestSerializer.timeoutInterval = 5;
    self.availableClassroomArray    = [[NSMutableArray alloc]init];
    self.hasCompleted               = 0;
    return self;
}

- (void)refreshEmptyClassroomTableData {
    BOOL changed = NO;
    for (XBSFindClassroomPeriodView *view in self.findClassroomDelegate.periodViewArray) {
        if (view.selected) {
            changed = YES;
        }
    }
    if (changed) {
        //换表格数据
        self.findClassroomDelegate.table.hidden = NO;
        [self tableDataDidChanged];
        [self.findClassroomDelegate.table reloadData];
    }else{
        //未填写时间
        self.findClassroomDelegate.table.hidden = YES;
    }
    
}

- (void)tableDataDidChanged {
    NSMutableArray *tempArr = [[NSMutableArray alloc]init];
    NSInteger tag[5] = BuildTagList;
    NSInteger buildingIndex = tag[self.findClassroomDelegate.buildingSelectorButton.tag];
    //取出所有合适的时段对应的教室列表
    for (int i = 0;i < 6;i++) {
        XBSFindClassroomPeriodView *view = self.findClassroomDelegate.periodViewArray[i];
        if (view.selected) {
            [tempArr addObject:[(NSMutableArray *)self.availableClassroomArray[i] mutableCopy]];
        }
    }
    NSLog(@"%@",tempArr);
    //筛选掉非指定教学楼的教室
    for (int i = 0;i < tempArr.count;i++) {
        for (int j = 0; j < ((NSArray *)tempArr[i]).count; j++) {
            if ([(NSString *)tempArr[i][j] characterAtIndex:0] != buildingIndex + 48) {
                tempArr[i][j] = @"";
            }
        }
        [tempArr[i] removeObject:@""];
    }
    
    NSLog(@"%@",tempArr);
    //取出所有时段共有的教室列表
    self.resultClassroomArray = [We getSameComponents:tempArr];
    
}
@end
