//
//  TopicRequest.h
//  TopicSearch
//
//  Created by hzl on 2017/5/21.
//  Copyright © 2017年 hzl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TopicRequest : NSObject

@property (nonatomic, copy) void(^topicBlk)(NSDictionary *dic);

@property (nonatomic, copy) void(^myJoinBlk)(NSDictionary *dic);

- (void)requestTopicDataWithSize:(NSString *)size page:(NSString *)page searchText:(NSString *)serachText;

- (void)requestMyJoinTopicDataWithSize:(NSString *)szie page:(NSString *)page stuNum:(NSString *)stuNum idNum:(NSString *)idNum searchText:(NSString *)searchText;

- (void)requestImageForImageView:(UIImageView *)imageView withUrlStr:(NSString *)urlStr;
@end
