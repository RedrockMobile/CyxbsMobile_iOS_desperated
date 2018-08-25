//
//  SchollGeneralTableViewCell.h
//  MoblieCQUPT_iOS
//
//  Created by 王一成 on 2018/8/17.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIFont+AdaptiveFont.h"

@interface SchollGeneralTableViewCell : UITableViewCell<UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UIView *RootView;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *contentLabel;
@property (assign, nonatomic) NSInteger index;
@property (strong, nonatomic) NSArray *picUrl;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *contentLabelHeight;

-(void)initWithDic:(NSDictionary *)dataDic;
@end
