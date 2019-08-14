//
//  OnlineActivitiesCell.h
//  CQUPT_Mobile
//
//  Created by 方昱恒 on 2019/8/3.
//  Copyright © 2019 方昱恒. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OnlineActivitiesCell : UITableViewCell

@property (nonatomic, weak) UIImageView *contentImageView;
@property (nonatomic, weak) UIImageView *backgroundIamgeView;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UIButton *joinButton;

@end

NS_ASSUME_NONNULL_END
