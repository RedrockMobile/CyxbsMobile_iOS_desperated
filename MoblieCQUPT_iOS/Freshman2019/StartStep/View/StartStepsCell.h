//
//  StartStepsCell.h
//  MoblieCQUPT_iOS
//
//  Created by 方昱恒 on 2019/8/10.
//  Copyright © 2019 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StepsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface StartStepsCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIButton *extendButton;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) UIImageView *photo;

@property (nonatomic, assign) BOOL isExtended;
@property (nonatomic, assign) CGFloat extendedHeight;
@property (nonatomic, strong) StepsModel *model;

@end

NS_ASSUME_NONNULL_END
