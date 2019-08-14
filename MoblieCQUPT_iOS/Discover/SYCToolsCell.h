//
//  SYCToolsCell.h
//  MoblieCQUPT_iOS
//
//  Created by 施昱丞 on 2018/9/25.
//  Copyright © 2018 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SYCToolsCell : UICollectionViewCell

@property (nonatomic, assign)BOOL isMoving;

- (void)setImage:(UIImage *)image title:(NSString *)title;

@property (nonatomic, strong)UIImage *image;
@property (nonatomic, strong)NSString *title;

@end

NS_ASSUME_NONNULL_END
