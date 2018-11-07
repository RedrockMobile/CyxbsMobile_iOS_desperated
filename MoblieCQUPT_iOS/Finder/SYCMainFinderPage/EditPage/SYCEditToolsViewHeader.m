//
//  SYCEditToolsViewHeader.m
//  MoblieCQUPT_iOS
//
//  Created by 施昱丞 on 2018/9/26.
//  Copyright © 2018 Orange-W. All rights reserved.
//

#import "SYCEditToolsViewHeader.h"
@interface SYCEditToolsViewHeader (){
    UILabel *titleLabel;
    UILabel *subtitleLabel;
}
@end

@implementation SYCEditToolsViewHeader

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self buildUI];
    }
    return self;
}

-(void)buildUI{
    CGFloat marginX = 15.0f; //水平方向的间隔
    CGFloat labelWidth = (self.bounds.size.width - 2 * marginX)/2.0f;
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(marginX, 0, labelWidth, self.bounds.size.height)];
    titleLabel.textColor = [UIColor blackColor];
    [self addSubview:titleLabel];
    
    subtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelWidth + marginX, 0, labelWidth, self.bounds.size.height)];
    subtitleLabel.textColor = [UIColor lightGrayColor];
    subtitleLabel.textAlignment = NSTextAlignmentRight;
    subtitleLabel.font = [UIFont systemFontOfSize:15.0f];
    [self addSubview:subtitleLabel];
}

-(void)setTitle:(NSString *)title{
    _title = title;
    titleLabel.text = title;
}

-(void)setSubTitle:(NSString *)subTitle{
    _subTitle = subTitle;
    subtitleLabel.text = subTitle;
}

@end
