//
//  StepsModel.h
//  MoblieCQUPT_iOS
//
//  Created by 方昱恒 on 2019/8/10.
//  Copyright © 2019 Orange-W. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/*
 {
 "title": "报到时间",
 "message": "9月5-6日",
 "photo": "...",
 "detail": ""
 }
 */

@interface StepsModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSString *photo;
@property (nonatomic, copy) NSString *detail;

+ (void)getModelData:(void (^)(NSArray *modelDataArray))success;
- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
