//
//  QueryDataModel.m
//  MoblieCQUPT_iOS
//
//  Created by MaggieTang on 12/10/2017.
//  Copyright © 2017 Orange-W. All rights reserved.
//

#import "QueryDataModel.h"

@implementation QueryDataModel
-(instancetype)initWithData:(NSDictionary *)data{
    self = [self init];
    if (self) {
//        self.status = data[@"status"];
//        self.data = data[@"data"];
        self.hour = data[@"hours"];
        self.uid = data[@"uid"];
        self.record = data[@"record"];
        
    }
    return self;
}
@end
