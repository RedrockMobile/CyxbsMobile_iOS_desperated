//
//  LZPersonAddView.h
//  MoblieCQUPT_iOS
//
//  Created by 李展 on 2017/9/24.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^touchBlock)(void);
typedef NS_ENUM(NSInteger,LZPersonAddViewType){
    LZPersonAdd,
    LZPersonShow
};
@interface LZPersonAddView : UIView
@property touchBlock cancelBlock;
@property touchBlock clickBlock;
@property (nonatomic, copy) NSString *title;
@property (nonatomic,readonly)LZPersonAddViewType type;

- (instancetype)initWithFrame:(CGRect)frame type:(LZPersonAddViewType)type;
@end
