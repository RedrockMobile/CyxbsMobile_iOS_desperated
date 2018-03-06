//
//  QuerInfo.h
//  Query
//
//  Created by hzl on 2017/3/16.
//  Copyright © 2017年 c. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuerInfo : UIView

//日均量显示标签
@property (nonatomic, strong) UILabel *avergaeElecLabel;

//月优惠显示标签
@property (nonatomic, strong) UILabel *freeElcLabel;

//电起度显示标签
@property (nonatomic, strong) UILabel *ElcStartLabel;

//电止度显示标签
@property (nonatomic, strong) UILabel *ElcEndLabel;


@end
