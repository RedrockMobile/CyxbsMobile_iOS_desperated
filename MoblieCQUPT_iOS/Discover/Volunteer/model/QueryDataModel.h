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
@property (nonatomic, copy) NSDictionary *data;
@property (nonatomic, copy) NSString *login_name;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *sid;
@property (nonatomic, copy) NSString *hour;
@property (nonatomic, copy) NSArray *record;
@property NSArray <QueryModel *> *models;
-(instancetype)initWithData:(NSDictionary *)data;
-(void)volunteerLogin:(NSString *)account password:(NSString *)password;
-(void)getVolunteerInfo:(NSString *)uid;

@end
