//
//  commitSuccessFrameView.h
//  MoblieCQUPT_iOS
//
//  Created by helloworld on 2018/6/1.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface commitSuccessFrameView : UIView
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

- (void)show;
- (void)free;
@end
