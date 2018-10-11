//
//  FoodTableViewCell.h
//  迎新
//
//  Created by 陈大炮 on 2018/8/15.
//  Copyright © 2018年 陈大炮. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FoodTableViewCell : UITableViewCell
<UIScrollViewDelegate>


@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *illstrateLabel;
@property (weak, nonatomic) IBOutlet UIButton *rankButton;
//@property (assign, nonatomic) NSInteger index;
@property (assign, nonatomic) NSInteger index;
@property (strong, nonatomic) NSArray *picUrl;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (weak, nonatomic) IBOutlet UIScrollView *topScr;



@property (nonatomic, strong) UIPageControl *pageControl;
-(void)initWithDic:(NSDictionary *)dataDic;


@end
