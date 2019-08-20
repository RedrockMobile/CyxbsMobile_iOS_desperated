//
//  LQQsubjectDataView.h
//  MoblieCQUPT_iOS
//
//  Created by 千千 on 2019/8/5.
//  Copyright © 2019 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LQQsubjectDataView;
NS_ASSUME_NONNULL_BEGIN

@interface LQQsubjectDataView : UIView
@property(nonatomic,strong)UIView*viewOne;
@property(nonatomic,strong)UIView*viewTwo;
@property(nonatomic,strong)UIView*viewThree;
@property(nonatomic,strong)UIImageView*xyZhou;//xy轴
@property(nonatomic,strong)NSArray<NSDictionary*> *subjectArr;
@property int x;//第几次加载此页面
-(instancetype)initWithDictionary:(NSArray<NSDictionary*> *)subjectArr;

@end

NS_ASSUME_NONNULL_END
