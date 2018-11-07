//
//  SYCEditToolsView.h
//  MoblieCQUPT_iOS
//
//  Created by 施昱丞 on 2018/9/26.
//  Copyright © 2018 Orange-W. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SYCEditToolsView : UIView

@property(nonatomic, strong)NSMutableArray *inUseTools;
@property(nonatomic, strong)NSMutableArray *unUseTools;

- (void)reloadData;

@end

NS_ASSUME_NONNULL_END
