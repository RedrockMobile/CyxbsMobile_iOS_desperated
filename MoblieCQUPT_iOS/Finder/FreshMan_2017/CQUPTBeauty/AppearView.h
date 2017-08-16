//
//  AppearView.h
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2017/8/8.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppearView : UIView
@property UIImageView *closeImage;
- (instancetype)initWithFrame:(CGRect )frame WithString:(NSString *) string With:(NSString *) imagee AndContext:(NSString *) context;
@end
