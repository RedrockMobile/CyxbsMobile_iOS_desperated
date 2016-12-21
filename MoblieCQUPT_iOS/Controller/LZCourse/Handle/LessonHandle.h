//
//  LessonHandle.h
//  Demo
//
//  Created by 李展 on 2016/11/17.
//  Copyright © 2016年 zhanlee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LessonMatter.h"
@interface LessonHandle : NSObject
+ (LessonMatter *)handle:(NSDictionary *)data;

@end
