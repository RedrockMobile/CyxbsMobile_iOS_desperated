//
//  DataMode.h
//  MoblieCQUPT_iOS
//
//  Created by 千千 on 2019/8/2.
//  Copyright © 2019 Orange-W. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LQQDataModel : NSObject
@property(nonatomic, strong) NSArray<NSString*> *fanTang;//食堂名称
@property(nonatomic, strong) NSArray<NSString*> *firstDataTitle;//四个大标题
@property(nonatomic, strong)NSArray<NSString*> *suShe;//宿舍名称
@property(nonatomic, strong)NSArray<NSString*> *kuaiDi;//快递名称
@property(nonatomic, strong)NSArray<NSString*> *shuJuJieMi;
@property(nonatomic, strong)NSArray<NSDictionary*> *subject;//挂科前三科目:率 NSString:Float
@property(nonatomic,strong)NSArray<NSString*> *biLi;//数组中0为boy的百分比数字1为girl的百分比数字
@property(nonatomic,strong)NSMutableArray<NSString*>*xueYuanName;

@property(nonatomic,strong)NSMutableArray<NSMutableArray<NSURL *>*>*suShePhoto;
@property(nonatomic,strong)NSMutableArray<NSString*>*suSheDetail;//宿舍详情

@property(nonatomic, strong)NSMutableArray<NSMutableArray<NSURL*>*>*shiTangPhoto;
@property(nonatomic,strong)NSMutableArray<NSString*>*shiTangDetail;//食堂详情

@property(nonatomic, strong)NSMutableArray<NSMutableArray<NSURL*>*>*kuaiDiPhoto;
@property(nonatomic,strong)NSMutableArray<NSString*>*kuaiDiTitle;//快递Title
@property(nonatomic,strong)NSMutableArray<NSString*>*kuaiDiDetail;//快递详情
@property(nonatomic, strong)NSString*chooSingCollege;//用户当前选择的学院;
//- (void)getbili:(void (^)(NSArray *bili))success;
+ (instancetype)sharedSingleton;
@end
NS_ASSUME_NONNULL_END
