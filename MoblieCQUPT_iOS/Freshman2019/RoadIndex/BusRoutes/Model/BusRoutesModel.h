//
//  BusRoutesModel.h
//  MoblieCQUPT_iOS
//
//  Created by 王一成 on 2019/8/11.
//  Copyright © 2019 Orange-W. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BusRoutesModel : NSObject
-(void)getBusRoutesData;
@property(strong ,nonatomic)NSMutableArray *nameArray;
@property(strong ,nonatomic)NSMutableArray *routeArray;
@property(strong, nonatomic)NSDictionary *recommendedRouteData;
@end

NS_ASSUME_NONNULL_END
