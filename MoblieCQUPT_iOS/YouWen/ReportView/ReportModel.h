//
//  ReportModel.h
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2018/4/22.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReportModel : NSObject
@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) NSString *content;
@property (strong, nonatomic) NSString *qusId;
- (void)setReport;
@end
