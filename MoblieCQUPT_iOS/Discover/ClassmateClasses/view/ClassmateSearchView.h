//
//  ClassmateSearchView.h
//  MoblieCQUPT_iOS
//
//  Created by 方昱恒 on 2019/9/27.
//  Copyright © 2019 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClassmateSearchViewDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface ClassmateSearchView : UIView

@property (nonatomic, weak) id<ClassmateSearchViewDelegate> delegate;
@property (nonatomic, weak) UITextField *searchTextField;
@property (nonatomic, weak) UIButton *searchButton;

@end

NS_ASSUME_NONNULL_END
