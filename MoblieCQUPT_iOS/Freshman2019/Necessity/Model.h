//
//  Model.h
//  MoblieCQUPT_iOS
//
//  Created by 汪明天 on 2019/8/9.
//  Copyright © 2019 Orange-W. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Model : NSObject
@property (nonatomic,copy)NSString *necessity;
@property (nonatomic,copy)NSString *detail;
@property (nonatomic,copy)NSString *property;
@property (nonatomic, assign)BOOL isShowMore;
@property (nonatomic, assign)BOOL isReady;
@property (nonatomic, assign)BOOL isSelected;
@property (nonatomic, assign)BOOL isShowMoreBtn;

-(instancetype)initWithDic: (NSDictionary*)dic;
+(instancetype)modelWithDictionary:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
