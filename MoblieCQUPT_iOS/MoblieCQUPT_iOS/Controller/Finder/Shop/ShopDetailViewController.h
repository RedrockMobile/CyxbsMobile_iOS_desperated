//
//  ShopDetailViewController.h
//  MoblieCQUPT_iOS
//
//  Created by 张润峰 on 15/8/19.
//  Copyright (c) 2015年 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailDishView.h"

@interface ShopDetailViewController : UIViewController

@property (strong, nonatomic) NSMutableDictionary *detailData;

@property (strong, nonatomic) DetailDishView *detailDishView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *picture;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@end
