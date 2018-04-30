//
//  myUILabel.h
//  MoblieCQUPT_iOS
//
//  Created by xiaogou134 on 2018/3/26.
//  Copyright © 2018年 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface myUILabel : UILabel
typedef enum
{
    VerticalAlignmentTop = 0, // default
    VerticalAlignmentMiddle,
    VerticalAlignmentBottom,
} VerticalAlignment;
@property (nonatomic) VerticalAlignment verticalAlignment;
@end
