//
//  SYCCustomToolsControl.h
//  MoblieCQUPT_iOS
//
//  Created by 施昱丞 on 2018/9/26.
//  Copyright © 2018 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ChannelBlock)(NSArray *inUseTitles, NSArray *unUseTitles);

@interface SYCCustomToolsControlView : UIView

+ (SYCCustomToolsControlView *)shareInstance;

- (void)showChannelViewWithInUseTitles:(NSArray*)inUseTitles unUseTitles:(NSArray*)unUseTitles finish:(ChannelBlock)block;


@end

NS_ASSUME_NONNULL_END
