//
//  DetailLostViewController.h
//  MoblieCQUPT_iOS
//
//  Created by 李展 on 2017/3/9.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LostItem;
@interface DetailLostViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UITableView *footTableView;
- (void)refreshWithDetailInfo:(LostItem *)info;
@end
