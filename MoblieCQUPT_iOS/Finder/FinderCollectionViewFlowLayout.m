//
//  FinderCollectionViewFlowLayout.m
//  MoblieCQUPT_iOS
//
//  Created by 李展 on 2017/8/17.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import "FinderCollectionViewFlowLayout.h"

@implementation FinderCollectionViewFlowLayout
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    // 系统父类写的方法， 系统子类必须调用父类，进行执行(只是对部分属性进行修改,所以不必一个个进行设置布局属性)
    NSArray *layoutAtts = [self deepCopyWithArray:[super layoutAttributesForElementsInRect:rect]];
    CGFloat collectionViewCenterX = self.collectionView.bounds.size.width * 0.5;
    CGFloat contentOffsetX = self.collectionView.contentOffset.x;
    for (UICollectionViewLayoutAttributes *layoutAtt in layoutAtts) {
        CGFloat centerX = layoutAtt.center.x;
        // 形变值，根据当前cell距离中心位置，的远近进行反比例缩放。（不要忘记算其偏移量的值。）
        CGFloat scale = 1 - 0.2*fabs((centerX - collectionViewCenterX - contentOffsetX)/self.collectionView.bounds.size.width);
        // 给布局属性添加形变
        layoutAtt.transform = CGAffineTransformMakeScale(1, scale);
    }
    return layoutAtts;
}




- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}
//  每次都有图片居中


// 通过目标移动的偏移量，提取期望偏移量（一般情况下，期望偏移量，就是目标偏移量）
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    // 根据偏移量 ，确定区域
    CGRect rect = CGRectMake(proposedContentOffset.x, 0, self.collectionView.frame.size.width, self.collectionView.frame.size.height);
    // 将屏幕所显示区域的元素布局取出。
    NSArray *layoutAtts = [self deepCopyWithArray:[super layoutAttributesForElementsInRect:rect]];
    CGFloat minMargin = MAXFLOAT;
    CGFloat collectionViewCenterX = self.collectionView.frame.size.width * 0.5;
    CGFloat contentOffsetX = proposedContentOffset.x;
    // 取出区域内元素，并根据其中心位置，与视图中心位置进行比较，比出最小的距离差
    for (UICollectionViewLayoutAttributes *layoutAtt in layoutAtts) {
        CGFloat margin = layoutAtt.center.x - contentOffsetX - collectionViewCenterX;
        if (fabs(margin) < fabs(minMargin)) {
            minMargin = margin;
        }
    }
    NSLog(@"%f",minMargin);
    // 期望偏移量加上差值，让整体沿差值反方向移动，这样的话，最近的一个，刚好在中心位置
    proposedContentOffset.x += minMargin;
    return proposedContentOffset;
}

- (NSArray *)deepCopyWithArray:(NSArray *)arr {
    NSMutableArray *arrM = [NSMutableArray array];
    for (UICollectionViewLayoutAttributes *attr in arr) {
        [arrM addObject:[attr copy]];
    }
    return arrM;
}

- (void)prepareLayout{
    self.itemSize = CGSizeMake(self.collectionView.width-100, self.collectionView.height);
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
}

@end
