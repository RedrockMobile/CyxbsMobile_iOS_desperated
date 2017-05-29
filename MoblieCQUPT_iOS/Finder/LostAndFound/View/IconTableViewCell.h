//
//  IconTableViewCell.h
//  MoblieCQUPT_iOS
//
//  Created by 李展 on 2017/3/18.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IconTableViewCell : UITableViewCell<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *contentTextField;


@end
