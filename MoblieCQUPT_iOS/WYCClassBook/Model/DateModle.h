//
//  DateModle.h
//  ChatBotTest
//
//  Created by 王一成 on 2018/8/30.
//  Copyright © 2018年 wyc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateModle : NSObject
@property (nonatomic, strong) NSMutableArray *dateArray;
-(void)initCalculateDate:(NSString *)startDate;

@end
