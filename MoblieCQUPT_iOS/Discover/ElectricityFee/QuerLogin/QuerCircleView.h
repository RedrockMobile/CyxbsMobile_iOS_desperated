//
//  QuerCircleView.h
//  Query
//
//  Created by hzl on 2017/3/1.
//  Copyright © 2017年 c. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuerCircleView : UIView
//百分比
@property (nonatomic) CGFloat percentage;

//电费
@property (nonatomic, strong) NSString *chargeStr;

//用了多少度
@property (nonatomic, strong) NSString *ElectrolysisStr;

//
//
////日均量
//@property (nonatomic, strong) NSString *AveragELecStr;
//
////月优惠量
//@property (nonatomic, strong) NSString *FreeElecStr;
//
////电起度
//@property (nonatomic, strong) NSString *ElcStarStr;
//
////电止度
//@property (nonatomic, strong) NSString *ElcEndStr;
-(void)highlightWithPercentage:(CGFloat)percentage;
-(void)logIt;
@end
