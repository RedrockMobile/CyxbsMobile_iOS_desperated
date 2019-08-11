//
//  FYHSearchResult.h
//  CQUPT_Mobile
//
//  Created by 方昱恒 on 2019/8/3.
//  Copyright © 2019 方昱恒. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AcademyOrHometownItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface FYHSearchResult : UITableView

@property (nonatomic, copy) NSArray<AcademyOrHometownItem *> *resultArray;

@end


NS_ASSUME_NONNULL_END
