//
//  MainViewController.h
//  CQUPT_Mobile
//
//  Created by 方昱恒 on 2019/8/2.
//  Copyright © 2019 方昱恒. All rights reserved.
//

#import "FYHSegmentesController.h"
#import "AcademyOrHometownItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface FYHOnlineActivityMainViewController : FYHSegmentesController

// 这里的逻辑有点乱，因为两个控制器（学院群，老乡群）的搜索功能共用了一个搜索框。。。
// 这里的模型数组，是搜索得到的结果，所以只能把它写在主控制器里面了（只有这里面有搜索框）。。。
@property (nonatomic, copy) NSArray<AcademyOrHometownItem *> *academyArray;
@property (nonatomic, copy) NSArray<AcademyOrHometownItem *> *hometownArray;

@end

NS_ASSUME_NONNULL_END
