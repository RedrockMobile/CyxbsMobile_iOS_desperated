//
//  AcademyItem.h
//  CQUPT_Mobile
//
//  Created by 方昱恒 on 2019/8/2.
//  Copyright © 2019 方昱恒. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AcademyOrHometownItem : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *data;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
