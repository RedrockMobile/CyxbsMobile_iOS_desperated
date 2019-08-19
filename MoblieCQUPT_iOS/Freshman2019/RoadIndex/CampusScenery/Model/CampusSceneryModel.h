//
//  CampusSceneryModel.h
//  MoblieCQUPT_iOS
//
//  Created by 王一成 on 2019/8/11.
//  Copyright © 2019 Orange-W. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CampusSceneryModel : NSObject
-(void)getCampusSceneryData;

@property(strong ,nonatomic)NSURL *schoolMapUrl;
@property(strong ,nonatomic)NSMutableArray *schoolPicArray;
@property(strong ,nonatomic)NSMutableArray *schoolPicNameArray;
@property(strong ,nonatomic)NSMutableArray *schoolPicUrlArray;

@end

NS_ASSUME_NONNULL_END
