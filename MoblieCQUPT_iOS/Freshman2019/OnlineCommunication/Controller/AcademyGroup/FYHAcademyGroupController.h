//
//  FYHAcademyGroupController.h
//  CQUPT_Mobile
//
//  Created by 方昱恒 on 2019/8/2.
//  Copyright © 2019 方昱恒. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AcademyOrHometownItem.h"
#import <AFNetworking.h>

NS_ASSUME_NONNULL_BEGIN

@interface FYHAcademyGroupController : UITableViewController

@property (nonatomic, copy) NSArray<AcademyOrHometownItem *> *allModelArray;

- (void)requestAllModelData;

@end

NS_ASSUME_NONNULL_END
