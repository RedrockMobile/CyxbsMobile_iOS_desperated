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
@property (copy, nonatomic) NSString *nickname;
@property (copy, nonatomic) NSString *photo_src;
@property (copy, nonatomic) NSString *created_time;
@property (copy, nonatomic) NSString *content;

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end
