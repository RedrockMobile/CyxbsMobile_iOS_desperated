//
//  ReportWaterfallController.h
//  MoblieCQUPT_iOS
//
//  Created by J J on 2018/8/12.
//  Copyright © 2018年 Orange-W. All rights reserved.
//
typedef void(^callBack)(void);

#import <UIKit/UIKit.h>

@interface ReportWaterfallController : BaseViewController<UIScrollViewDelegate>


@property (retain,nonatomic)UIButton *button01;
@property (retain,nonatomic)UIButton *button02;
@property (retain,nonatomic)UIButton *button03;

@property (retain,nonatomic)UIImageView *imageView01;
@property (retain,nonatomic)UIImageView *imageView02;
@property (retain,nonatomic)UIImageView *imageView03;
@property (retain,nonatomic)UIImageView *imageView04;
@property (retain,nonatomic)UIImageView *imageView05;
@property (retain,nonatomic)UIImageView *imageView06;


@property (retain,nonatomic)UILabel *label01;
@property (retain,nonatomic)UILabel *label02;
@property (retain,nonatomic)UILabel *label03;
@property (retain,nonatomic)UILabel *label04;
@property (retain,nonatomic)UILabel *label05;
@property (retain,nonatomic)UILabel *label06;


//滚动视图
@property (retain,nonatomic)UIScrollView *scrollView;

@property (retain,nonatomic)UIView *view01;
@property (retain,nonatomic)UIView *view02;
@property (retain,nonatomic)UIView *view03;

//查看大图的背景
@property (strong,nonatomic)UIView *Img;

//获取地点
@property (retain,nonatomic)NSMutableArray *arrayData01;

//获取说明
@property (retain,nonatomic)NSMutableArray *arrayData02;

//获取图片url
@property (retain,nonatomic)NSMutableArray *arrayData03;


//储存图片URL
@property (retain,nonatomic)NSMutableArray *arr;

@property (nonatomic, strong)callBack callBackHandle;

//移动手势
@property (retain,nonatomic)UIPinchGestureRecognizer *_pinchGesture;

@end
