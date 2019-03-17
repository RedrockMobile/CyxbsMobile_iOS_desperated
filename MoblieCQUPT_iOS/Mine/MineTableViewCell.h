//
//  MineTableViewCell.h
//  MoblieCQUPT_iOS
//
//  Created by 李展 on 2017/8/18.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, MineCellType){
    MineCellTypeNormal = 0,
    MineCellTypeStart,
    MineCellTypeMiddle,
    MineCellTypeEnd,
};

@interface MineTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *cellImageView;
@property (weak, nonatomic) IBOutlet UILabel *cellLabel;
@property (weak, nonatomic) IBOutlet UIImageView *redPoint;
@property (weak, nonatomic) IBOutlet UIView *backgroudView;
@property (weak, nonatomic) IBOutlet UIView *shadowView;
@property (nonatomic) MineCellType type;

- (instancetype)initWithType:(MineCellType)type;

@end
