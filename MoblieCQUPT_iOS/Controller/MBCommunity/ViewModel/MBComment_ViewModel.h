//
//  MBComment_ViewModel.h
//  MoblieCQUPT_iOS
//
//  Created by GQuEen on 16/4/25.
//  Copyright © 2016年 Orange-W. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBCommentModel.h"

@interface MBComment_ViewModel : NSObject

@property (strong, nonatomic) MBCommentModel *model;

@property (assign, nonatomic) CGRect headImageViewFrame;
@property (assign, nonatomic) CGRect IDLabelFrame;
@property (assign, nonatomic) CGRect timeLabelFrame;
@property (assign, nonatomic) CGRect contentLabelFrame;

@property (assign, nonatomic) CGFloat cellHeight;
@end
