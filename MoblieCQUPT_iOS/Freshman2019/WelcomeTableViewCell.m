//
//  WelcomeTableViewCell.m
//  MoblieCQUPT_iOS
//
//  Created by hwh on 2019/8/5.
//  Copyright © 2019 mac. All rights reserved.
//

#import "WelcomeTableViewCell.h"

@interface WelcomeTableViewCell() {
    UILabel *_titleLbl;
    UILabel *_descriptionLbl;
}

@end

@implementation WelcomeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        
        UIView *centerView = [[UIView alloc]init];
        centerView.translatesAutoresizingMaskIntoConstraints = NO;
        centerView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:centerView];
        [self.contentView addConstraints:[NSLayoutConstraint
                                          constraintsWithVisualFormat:@"H:|-(20)-[centerView]-(20)-|"
                                    options:0
                                          metrics:nil
                                        views:NSDictionaryOfVariableBindings(centerView)]];
        [self.contentView addConstraints: [NSLayoutConstraint
                                           constraintsWithVisualFormat:@"V:|-(10)-[centerView]-(0)-|"
                                        options:0
                                        metrics:nil
                                           views:NSDictionaryOfVariableBindings(centerView)]];
        
        UIImageView *bgImageView = [[UIImageView alloc]init];
        bgImageView.translatesAutoresizingMaskIntoConstraints = NO;
        bgImageView.image = [UIImage imageNamed:@"welcome_cell_bg.png"];
        [centerView addSubview:bgImageView];
        [centerView addConstraints:[NSLayoutConstraint
                                    constraintsWithVisualFormat:@"H:|-(0)-[bgImageView]-(0)-|"
                                options:0
                                    metrics:nil
                                    views:NSDictionaryOfVariableBindings(bgImageView)]];
        [centerView addConstraints: [NSLayoutConstraint
                                     constraintsWithVisualFormat:@"V:|-(0)-[bgImageView]-(0)-|"
                                     options:0
                                metrics:nil
                                     views:NSDictionaryOfVariableBindings(bgImageView)]];
        
        UIImageView *arrowImageView = [[UIImageView alloc]init];
        arrowImageView.translatesAutoresizingMaskIntoConstraints = NO;
        arrowImageView.image = [UIImage imageNamed:@"welcome_arrow.png"];
        [centerView addSubview:arrowImageView];
        [centerView addConstraints:[NSLayoutConstraint
                                    constraintsWithVisualFormat:@"H:[arrowImageView]-(20)-|"
                                options:0
                                    metrics:nil
                                views:NSDictionaryOfVariableBindings(arrowImageView)]];
        NSLayoutConstraint *centerCstt = [NSLayoutConstraint constraintWithItem:arrowImageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:centerView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
        [centerView addConstraint:centerCstt];
        
        
        _titleLbl = [[UILabel alloc]init];
        _titleLbl.translatesAutoresizingMaskIntoConstraints = NO;
        _titleLbl.textColor = [UIColor blackColor];
        [centerView addSubview:_titleLbl];
        [centerView addConstraints:[NSLayoutConstraint
                                    constraintsWithVisualFormat:@"H:|-(20)-[_titleLbl]-(0)-|"
                                    options:0
                                    metrics:nil
                                    views:NSDictionaryOfVariableBindings(_titleLbl)]];
        [centerView addConstraints: [NSLayoutConstraint
                                     constraintsWithVisualFormat:@"V:|-(18)-[_titleLbl]"
                                     options:0
                                    metrics:nil
                                     views:NSDictionaryOfVariableBindings(_titleLbl)]];
        
        
        _descriptionLbl = [[UILabel alloc]init];
        _descriptionLbl.translatesAutoresizingMaskIntoConstraints = NO;
        _descriptionLbl.textColor = [UIColor grayColor];
        [centerView addSubview:_descriptionLbl];
        [centerView addConstraints:[NSLayoutConstraint
                                    constraintsWithVisualFormat:@"H:|-(20)-[_descriptionLbl]-(45)-|"
                                    options:0
                                    metrics:nil
                                    views:NSDictionaryOfVariableBindings(_descriptionLbl)]];
        [centerView addConstraints: [NSLayoutConstraint
                                     constraintsWithVisualFormat:@"V:[_titleLbl]-(5)-[_descriptionLbl]"
                                     options:0
                                     metrics:nil
                                     views:NSDictionaryOfVariableBindings(_titleLbl,_descriptionLbl)]];
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTitle:(NSString *)title {
    _title = [title copy];
    _titleLbl.text = _title;
}

- (void)setDescript:(NSString *)descript {
    _descript = [descript copy];
    _descriptionLbl.text = _descript;
}

@end
