//
//  SYCCustomLayoutModel.m
//  MoblieCQUPT_iOS
//
//  Created by 施昱丞 on 2018/9/26.
//  Copyright © 2018 Orange-W. All rights reserved.
//

#import "SYCCustomLayoutModel.h"
#import "SYCToolModel.h"

static SYCCustomLayoutModel *newInstance = nil;

@interface SYCCustomLayoutModel()

@property (nonatomic, strong)NSString *filePath;

@end

@implementation SYCCustomLayoutModel

+ (SYCCustomLayoutModel *)sharedInstance{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        newInstance = [[self alloc] init];
        [newInstance createFileIfNeed];
    });
    return newInstance;
}

- (void)createFileIfNeed{
    self.filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"customLayout.archiver"];
    NSDictionary *toolsArray = [NSKeyedUnarchiver unarchiveObjectWithFile:self.filePath];
    
    
    // 无论toolsArray是否有值，都要重新写入缓存，以防止用户更新以后看不到新模块
    
//    if (toolsArray) {
//        self.inuseTools = [toolsArray objectForKey:@"inuseTools"];
//        self.unuseTools = [toolsArray objectForKey:@"unuseTools"];
//    }else{
        self.inuseTools = [NSMutableArray array];
        [self.inuseTools addObject:[[SYCToolModel alloc] initWithTitle:@"我的考试" ImageName:@"成绩单" ClassName:@"ExamTotalViewController"]];
        [self.inuseTools addObject:[[SYCToolModel alloc] initWithTitle:@"查电费" ImageName:@"查电费" ClassName:@"QuerLoginViewController"]];
        [self.inuseTools addObject:[[SYCToolModel alloc] initWithTitle:@"关于红岩" ImageName:@"关于红岩" ClassName:@"WebViewController"]];
        [self.inuseTools addObject:[[SYCToolModel alloc] initWithTitle:@"课前提醒" ImageName:@"课前提醒" ClassName:@"BeforeClassViewController"]];
        [self.inuseTools addObject:[[SYCToolModel alloc] initWithTitle:@"空教室" ImageName:@"空教室" ClassName:@"EmptyClassViewController"]];
        [self.inuseTools addObject:[[SYCToolModel alloc] initWithTitle:@"没课约" ImageName:@"没课约" ClassName:@"LZNoCourseViewController"]];
        [self.inuseTools addObject:[[SYCToolModel alloc] initWithTitle:@"校历" ImageName:@"校历" ClassName:@"CalendarViewController"]];
        [self.inuseTools addObject:[[SYCToolModel alloc] initWithTitle:@"志愿时长" ImageName:@"志愿时长圆" ClassName:@"QueryLoginViewController"]];
        [self.inuseTools addObject:[[SYCToolModel alloc] initWithTitle:@"重邮地图" ImageName:@"重邮地图" ClassName:@"MapViewController"]];
        [self.inuseTools addObject:[[SYCToolModel alloc] initWithTitle:@"校车定位" ImageName:@"校车定位" ClassName:@"SchoolCarController"]];
        [self.inuseTools addObject:[[SYCToolModel alloc] initWithTitle:@"同学课表" ImageName:@"同学课表" ClassName:@"ClassmateSearchViewController"]];
//        [self.inuseTools addObject:[[SYCToolModel alloc] initWithTitle:@"教务新闻" ImageName:@"教务新闻" ClassName:@"NewsViewController"]];
        
        self.unuseTools = [NSMutableArray array];
        
        
        toolsArray = @{@"inuseTools":self.inuseTools, @"unuseTools":self.unuseTools};
        [NSKeyedArchiver archiveRootObject:toolsArray toFile:self.filePath];
//    }
}

- (void)save{
    self.filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"customLayout.archiver"];
    NSDictionary *toolsArray = @{@"inuseTools":_inuseTools, @"unuseTools":_unuseTools};
    [NSKeyedArchiver archiveRootObject:toolsArray toFile:_filePath];
}

@end

