# OWAnimation 
[TOC]
## ExamplAnimation
 成型动画,能直接用
 
 ```
 /** 遮罩动画 **/
 + (void) discoverViewAnimation:(UIView *)aniView;
 ```
 
## OrangeAnimation
动画封装,自动回调,使用方法参照ExamplAnimation的discoverViewAnimation方法:

```
	/** 动画初始化类 **/
    OrangeAnimation *ani = [[OrangeAnimation alloc] init];
    
    /** 设置动画1 时间0.3秒 **/
    [ani addAnimate:^{    
        backView.frame  = CGRectMake(40, 100, 80, 120);
        backView.center = CGPointMake([240, 400);  
    } withTime:0.3];
    
    /** 设置动画2 时间0.7秒 **/
    [ani addAnimate:^{
        backView.frame  = [UIScreen mainScreen].bounds;   
    } withTime:0.7];
    
    /** 运行动画(共1秒) **/
    [ani runAnimation];

```


其他方法

```Object-c

- (void) addAnimate:(void (^)(void))block withTime:(float)time;//添加动画 block,持续时间
- (void) runAnimation;//运行动画


//--- 以下三个不常用 ---//
/** 在动画链末尾中插入动画 **/
- (NSMutableArray *) addAnimateWithArray: (NSMutableArray *)animateArray
                                    time: (float)time
                            animateBlock: (void (^)(void)) block;

- (void)runWithAnimateChain:(NSMutableArray *)animateArray;//根据动画链数组执行动画
- (void)runAnimateChain:(NSMutableArray *)arr now:(int)indexPath;//从动画链indexPath 开始执行动画

/**
 *  @author Orange-W, 15-08-17 09:08:22
 *
 *  @brief  旋转效果
 *  @param angle           旋转角度
 *  @param time            时间
 *  @param view            旋转的视图
 *  @param completionState 成功后的状态 block
 *  @param distributeAngle 动画离散度(不能大于180) (默认为30)
 *  @return 旋转的弧度
 *  备注:动画队列链和旋转一起用的时候,要在completionState设置末状态与队列中一样.
 */
+ (CGFloat)animateTransformWithRotate:(NSInteger)angle
                                 time:(CGFloat)time
                              forView:(UIView *)view
                           distribute:(NSInteger)distributeAngle
                      completionState:(void (^)())block;

/* 功能同上,简化版,默认动画离散度30,无回调 block */
+ (CGFloat)animateTransformWithRotate:(NSInteger)angle
                                 time:(CGFloat)time
                              forView:(UIView *)view;
```