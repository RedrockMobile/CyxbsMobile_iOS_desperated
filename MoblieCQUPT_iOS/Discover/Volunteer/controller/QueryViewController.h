//
//  QueryViewController.h
//  MoblieCQUPT_iOS
//
//  Created by MaggieTang on 05/10/2017.
//  Copyright © 2017 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QueryViewController : BaseViewController
@property (nonatomic,assign) NSInteger index;
-(instancetype)initWithDic:(NSDictionary *)dic;
@end
