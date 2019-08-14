//
//  ActivityItem.h
//  CQUPT_Mobile
//
//  Created by 方昱恒 on 2019/8/6.
//  Copyright © 2019 方昱恒. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ActivityItem : NSObject

@property (nonatomic, copy) NSString *QRCode;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *photo;
@property (nonatomic, copy) NSString *message;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
