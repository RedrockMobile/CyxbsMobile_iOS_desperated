//
//  LQQpercentageOfStudent.h
//  MoblieCQUPT_iOS
//
//  Created by 千千 on 2019/8/7.
//  Copyright © 2019 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LQQpercentageOfStudent : UIView
@property(nonatomic, strong)NSArray<NSString*>*biliArray;
-(instancetype)initWithArray:(NSArray<NSString*> *)biLiArray userXueYuan:(NSString*)xueYuan;

@end

NS_ASSUME_NONNULL_END
