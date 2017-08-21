//
//  IntroductionTableViewCell.h
//  MoblieCQUPT_iOS
//
//  Created by helloworld on 2017/8/11.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IntroductionTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *grayView;
@property (weak, nonatomic) IBOutlet UIView *blueView;
@property (weak, nonatomic) IBOutlet UILabel *titltLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel1;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel2;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel3;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel4;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel5;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel6;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel7;

- (CGFloat)height;
@end
