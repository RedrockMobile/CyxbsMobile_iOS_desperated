//
//  QueryDataModel.h
//  MoblieCQUPT_iOS
//
//  Created by MaggieTang on 12/10/2017.
//  Copyright © 2017 Orange-W. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QueryModel.h"
@interface QueryDataModel : NSObject
@property (nonatomic, copy) NSString *data;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *hour;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSArray *record;
@property NSArray <QueryModel *> *models;
-(instancetype)initWithData:(NSDictionary *)data;
@end
