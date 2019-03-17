//
//  LZPersonSelectViewController.h
//  MoblieCQUPT_iOS
//
//  Created by 李展 on 2017/9/22.
//  Copyright © 2017年 Orange-W. All rights reserved.
//


@class LZPersonModel;
@interface LZPersonSelectViewController : BaseViewController
typedef void(^selectPersonBlock)(LZPersonModel *model);
@property selectPersonBlock selectPersonBlock;
- (instancetype)initWithPersons:(NSArray <LZPersonModel *> *)persons;

@end
