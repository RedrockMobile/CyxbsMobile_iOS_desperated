//
//  MBCommentModel.h
//  MoblieCQUPT_iOS
//
//  Created by GQuEen on 16/4/25.
//  Copyright © 2016年 Orange-W. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MBCommentModel : NSObject

@property (copy, nonatomic) NSString *stuNum;
@property (copy, nonatomic) NSString *headImageView;
@property (copy, nonatomic) NSString *IDLabel;
@property (copy, nonatomic) NSString *timeLabel;
@property (copy, nonatomic) NSString *contentLabel;

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end
