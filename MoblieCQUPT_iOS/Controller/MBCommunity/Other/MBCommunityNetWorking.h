//
//  MBCommunityNetWorking.h
//  MoblieCQUPT_iOS
//
//  Created by GQuEen on 16/4/7.
//  Copyright © 2016年 Orange-W. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger , MBDataType) {
    MBDataTypeCommunityBBDD,
    MBDataTypeCommunitySearchHot,
    MBDataTypeCommunityNews,
    MBDataTypeCommunityComment
};

@interface MBCommunityNetWorking : NSObject

+ (void)NetRequestPOSTwithDataType:(MBDataType)type WithParameter:(NSDictionary *)dic;
+ (void)NetUploadPOST;

@end
