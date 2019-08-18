//
//  GroupModel.h
//  MoblieCQUPT_iOS
//
//  Created by 汪明天 on 2019/8/9.
//  Copyright © 2019 Orange-W. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Model.h"

NS_ASSUME_NONNULL_BEGIN

@interface GroupModel : NSObject

@property (nonatomic, copy) NSString *headerTitle;
@property (nonatomic, copy) NSArray<Model *> *modelArray;

+ (instancetype)groupWithDictinary:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
