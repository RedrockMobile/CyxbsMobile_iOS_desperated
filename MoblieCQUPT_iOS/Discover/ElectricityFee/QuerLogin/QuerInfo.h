//
//  QuerInfo.h
//  Query
//
//  Created by hzl on 2017/3/16.
//  Copyright © 2017年 c. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuerInfo : UIScrollView
//
////日均量显示标签
//@property (nonatomic, strong) UILabel *avergaeElecLabel;
//
////月优惠显示标签
//@property (nonatomic, strong) UILabel *freeElcLabel;
//
////电起度显示标签
//@property (nonatomic, strong) UILabel *ElcStartLabel;
//
////电止度显示标签
//@property (nonatomic, strong) UILabel *ElcEndLabel;

//用了多少度
@property (nonatomic, strong) NSString *ElectrolysisStr;

//日均量
@property (nonatomic, strong) NSString *AveragELecStr;

//月优惠量
@property (nonatomic, strong) NSString *FreeElecStr;

//电起度
@property (nonatomic, strong) NSString *ElcStarStr;

//电止度
@property (nonatomic, strong) NSString *ElcEndStr;
@end
