//
//  MBCommentModel.m
//  MoblieCQUPT_iOS
//
//  Created by GQuEen on 16/4/25.
//  Copyright © 2016年 Orange-W. All rights reserved.
//

#import "MBCommentModel.h"

@implementation MBCommentModel

- (NSString *)description {
    NSString *result = @"";
    result = [result stringByAppendingFormat:@"headImageView : %@\n",self.headImageView];
    result = [result stringByAppendingFormat:@"IDLabel : %@\n",self.IDLabel];
    result = [result stringByAppendingFormat:@"timeLabel : %@\n",self.timeLabel];
    result = [result stringByAppendingFormat:@"contentLabel : %@\n",self.contentLabel];
    return result;
}

@end
