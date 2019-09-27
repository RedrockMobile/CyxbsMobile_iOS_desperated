//
//  ClassmatesSearchResultCell.h
//  MoblieCQUPT_iOS
//
//  Created by 方昱恒 on 2019/9/27.
//  Copyright © 2019 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ClassmatesSearchResultCell : UITableViewCell

// 姓名
@property (nonatomic, weak) UILabel *nameLabel;
// 专业和学号
@property (nonatomic, weak) UILabel *detaileLabel;

@end

NS_ASSUME_NONNULL_END
