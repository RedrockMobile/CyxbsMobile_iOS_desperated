//
//  ImageParamProtocol.h
//  MoblieCQUPT_iOS
//
//  Created by user on 16/5/10.
//  Copyright © 2016年 Orange-W. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol MOHImageParamModel <NSObject>
@property (copy, nonatomic, nonnull) NSString *paramName;///参数名字
@property (strong, nonatomic, nonnull) UIImage *uploadImage;///上传的图片

@optional
@property (copy, nonatomic, nonnull) NSString *fileName;///上传的名字 (服务器一般要求 png 结尾)

@end
