//
//  QRCodeView.h
//  MoblieCQUPT_iOS
//
//  Created by 千千 on 2019/8/18.
//  Copyright © 2019 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QRCodeView : UIView

@property (nonatomic, weak) UIView *background;
@property (nonatomic, weak) UIButton *cancelButton;
@property (nonatomic, weak) UIImageView *QRCode;

@end

NS_ASSUME_NONNULL_END
