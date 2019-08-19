//
//  ExpressSpotItem.h
//  MoblieCQUPT_iOS
//
//  Created by 千千 on 2019/8/17.
//  Copyright © 2019 Orange-W. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ExpressSpotItem : NSObject

@property (nonatomic, copy) NSString *spotName;
@property (nonatomic, copy) NSString *detail;
@property (nonatomic, copy) NSString *photo;

@property (nonatomic, assign) CGRect ImageFrame;
@property (nonatomic, assign) CGRect titleLabelFrame;
@property (nonatomic, assign) CGRect detailLabelFrame;
@property (nonatomic, assign) CGRect backgroundFrame;

@property (nonatomic, assign) CGFloat cellHeight;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)spotWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
