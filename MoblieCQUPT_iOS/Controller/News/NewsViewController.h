//
//  ViewController.h
//  重邮小帮手
//
//  Created by 1808 on 15/8/19.
//  Copyright (c) 2015年 1808. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsViewController : UIViewController<UITextFieldDelegate>
typedef NS_ENUM(NSInteger, EnumFreshType)
{
    //以下是枚举成员
    EnumDataRefresh = 0,
    EnumDataAdd = 1,
};

@end

