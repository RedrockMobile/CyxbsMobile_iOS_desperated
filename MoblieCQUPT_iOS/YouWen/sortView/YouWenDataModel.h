//
//  YouWenDataModel.h
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2018/2/24.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YouWenDataModel : NSObject
- (instancetype)initWithStyle:(NSString *)style;
- (void)newPage:(NSString *)page;
- (void)newYWDate;

@property (copy, nonatomic) NSArray *YWdataArray;
@end
