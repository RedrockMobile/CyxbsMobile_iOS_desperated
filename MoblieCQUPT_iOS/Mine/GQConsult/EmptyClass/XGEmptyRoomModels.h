//
//  XGEmptyRoomModels.h
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2017/9/9.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XGEmptyRoomModels : NSObject
{
    NSString *weekdayNum;
    NSString *week;
}
@property (strong, nonatomic)NSString *buildNum;
@property (strong, nonatomic)NSString *sectionNum;
@property (strong, nonatomic)NSDictionary *FinalData;
- (void)loadEmptyData;

@end
