//
//  FinderCollectionViewFlowLayout.m
//  MoblieCQUPT_iOS
//
//  Created by 李展 on 2017/8/17.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import "FinderCollectionViewFlowLayout.h"

@implementation FinderCollectionViewFlowLayout
//- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
//{
//    // 系统父类写的方法， 系统子类必须调用父类，进行执行(只是对部分属性进行修改,所以不必一个个进行设置布局属性)
//    NSArray *layoutAtts =  [super layoutAttributesForElementsInRect:rect];
//    CGFloat collectionViewCenterX = self.collectionView.bounds.size.width * 0.5;
//    CGFloat contentOffsetX = self.collectionView.contentOffset.x;
//    for (UICollectionViewLayoutAttributes *layoutAtt in layoutAtts) {
//        CGFloat centerX = layoutAtt.center.x;
//        // 形变值，根据当前cell 距离中心位置，的远近  进行反比例缩放。 （不要忘记算其偏移量的值。）
//        CGFloat scale = 1 - ABS((centerX - collectionViewCenterX - contentOffsetX)/self.collectionView.bounds.size.width);
//        // 给 布局属性  添加形变
//        layoutAtt.transform = CGAffineTransformMakeScale(scale, scale);
//    }
//    return layoutAtts;
//}
//- (void)prepareLayout
//{
//    [super prepareLayout];
//    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//    self.minimumInteritemSpacing = 0;
//    self.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
//}


- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *attrs = [self deepCopyWithArray:[super layoutAttributesForElementsInRect:rect]];
    CGFloat contentOffsetX = self.collectionView.contentOffset.x;
    CGFloat collectionViewCenterX = self.collectionView.frame.size.width * 0.5;
    for (UICollectionViewLayoutAttributes *attr in attrs) {
        CGFloat scale = 1 - 0.16*fabs(attr.center.x - contentOffsetX - collectionViewCenterX) /self.collectionView.bounds.size.width;
        attr.transform = CGAffineTransformMakeScale(scale, scale);
    }
    return attrs;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}
//  每次都有图片居中


// 通过目标移动的偏移量， 提取期望偏移量  （一般情况下，期望偏移量，就是 目标偏移量）
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    // 根据偏移量 ， 确定区域
    CGRect rect = CGRectMake(proposedContentOffset.x, 0, self.collectionView.frame.size.width, self.collectionView.frame.size.height);
    // 将屏幕所显示区域的 元素布局 取出。
    NSArray *layoutAtts = [super layoutAttributesForElementsInRect:rect];
    CGFloat minMargin = MAXFLOAT;
    CGFloat collectionViewCenterX = self.collectionView.frame.size.width * 0.5;
    CGFloat contentOffsetX = proposedContentOffset.x;
    // 取出区域内元素， 并根据其中心位置， 与视图中心位置 进行比较， 比出最小的距离差
    for (UICollectionViewLayoutAttributes *layoutAtt in layoutAtts) {
        CGFloat margin = layoutAtt.center.x - contentOffsetX - collectionViewCenterX;
        if (ABS(margin) < ABS(minMargin)) {
            minMargin = margin;
        }
    }
    NSLog(@"%f",minMargin);
    // 期望偏移量 加上差值， 让整体，沿差值 反方向移动，这样的话， 最近的一个，刚好在中心位置
    proposedContentOffset.x += minMargin;
    return proposedContentOffset;
}

//- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
//    CGRect rect = CGRectMake(proposedContentOffset.x, 0, self.collectionView.bounds.size.width,self.collectionView.bounds.size.height);
//    NSArray *attrs = [super layoutAttributesForElementsInRect:rect];
//    CGFloat contentOffsetX = self.collectionView.contentOffset.x;
//    CGFloat collectionViewCenterX = self.collectionView.frame.size.width * 0.5;
//    CGFloat minDistance = MAXFLOAT;
//    for (UICollectionViewLayoutAttributes *attr in attrs) {
//        CGFloat distance = attr.center.x - contentOffsetX - collectionViewCenterX;
//        if (fabs(distance) < fabs(minDistance)) {
//            minDistance = distance;
//        }
//    }
//    proposedContentOffset.x += minDistance;
//    return proposedContentOffset;
//}

//  UICollectionViewFlowLayout has cached frame mismatch for index path这个警告来源主要是在使用layoutAttributesForElementsInRect：方法返回的数组时，没有使用该数组的拷贝对象，而是直接使用了该数组。解决办法对该数组进行拷贝，并且是深拷贝。

- (NSArray *)deepCopyWithArray:(NSArray *)arr {
    NSMutableArray *arrM = [NSMutableArray array];
    for (UICollectionViewLayoutAttributes *attr in arr) {
        [arrM addObject:[attr copy]];
    }
    return arrM;
}


@end
