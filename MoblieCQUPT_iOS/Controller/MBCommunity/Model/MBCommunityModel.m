//
//  MBCommunityModel.m
//  MoblieCQUPT_iOS
//
//  Created by GQuEen on 16/4/6.
//  Copyright © 2016年 Orange-W. All rights reserved.
//

#import "MBCommunityModel.h"

@implementation MBCommunityModel


- (NSString *)description {
    NSString *result = @"";
    result = [result stringByAppendingFormat:@"headImageView : %@\n",self.headImageView];
    result = [result stringByAppendingFormat:@"IDLabel : %@\n",self.IDLabel];
    result = [result stringByAppendingFormat:@"timeLabel : %@\n",self.timeLabel];
    result = [result stringByAppendingFormat:@"contentLabel : %@\n",self.contentLabel];
    result = [result stringByAppendingFormat:@"pictureArray : %@\n",self.pictureArray];
    result = [result stringByAppendingFormat:@"comprssPictureArray : %@\n",self.comprssPictureArray];
    result = [result stringByAppendingFormat:@"numOfSupport : %@\n",self.numOfSupport];
    result = [result stringByAppendingFormat:@"numOfComment : %@\n",self.numOfComment];
    result = [result stringByAppendingFormat:@"isMyLike : %d\n",self.isMyLike];
    return result;
}

@end
