//
//  LZSearchView.h
//  MoblieCQUPT_iOS
//
//  Created by 李展 on 2017/9/17.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LZSearchView : UIView
typedef void (^touchBlock)(void);
@property touchBlock cancelBlock;
@property touchBlock addBlock;
@property (nonatomic, strong) UIColor *cancelBtnTextColor;
@property (nonatomic, strong) UIColor *addBtnTextColor;
@property (nonatomic, strong) UIColor *textFieldTextColor;
@property (nonatomic, copy) NSString *placeHolder;
@property (nonatomic, readonly)NSString *text;
//@property (nonatomic, strong) UIColor *plcaeHolderTextColor;
@end
