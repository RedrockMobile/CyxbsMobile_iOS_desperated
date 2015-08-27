//
//  DataBundle.h
//  ConsultingTest
//
//  Created by RainyTunes on 8/22/15.
//  Copyright (c) 2015 RainyTunes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "ViewController.h"
#import "MainViewController.h"
#import "Config.h"

@interface DataBundle : NSObject

@property (nonatomic, strong) NSDictionary *postParams;
@property (nonatomic, strong) NSMutableDictionary *json;
@property (nonatomic, strong) AFHTTPRequestOperationManager *manager;
@property (nonatomic, strong) ViewController *delegate;
@property (nonatomic, strong) MainViewController *mainDelegate;


@property (assign, atomic)NSInteger flag;
@property (assign, atomic)NSInteger hasCompleted;
@property (strong, atomic)NSMutableArray *emptyRoomBundle;
@property (nonatomic, strong) NSString *htmlString;

- (void)httpPostForSchedule:(NSString *)postType;
- (void)httpPostForEmptyRooms;
- (void)httpPostForGrade;
- (instancetype)init;
- (NSString *)getUserHint:(int)flag1 :(int)flag2;

@end
