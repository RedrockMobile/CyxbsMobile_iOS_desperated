//
//  SYCEditToolsView.m
//  MoblieCQUPT_iOS
//
//  Created by 施昱丞 on 2018/9/26.
//  Copyright © 2018 Orange-W. All rights reserved.
//

#import "SYCEditToolsView.h"
#import "SYCEditToolsViewHeader.h"
#import "SYCToolsCell.h"
#import "SYCToolModel.h"

static NSInteger ColumnNumber = 3;

static CGFloat CellMarginX = 15.0f;
static CGFloat CellMarginY = 10.0f;

@interface SYCEditToolsView()<UICollectionViewDelegate, UICollectionViewDataSource>{
    UICollectionView *collectionView;
    
    SYCToolsCell *dragingItem;
    NSIndexPath *dragingIndexPath;
    NSIndexPath *targetIndexPath;
}

@end

@implementation SYCEditToolsView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self buildUI];
    }
    return self;
}

- (void)buildUI{
    self.backgroundColor = [UIColor whiteColor];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat cellWidth = (self.bounds.size.width - (ColumnNumber + 1) * CellMarginX)/ColumnNumber;
    flowLayout.itemSize = CGSizeMake(cellWidth, cellWidth);
    flowLayout.sectionInset = UIEdgeInsetsMake(CellMarginY, CellMarginX, CellMarginY, CellMarginX);
    flowLayout.minimumLineSpacing = CellMarginY;
    flowLayout.minimumInteritemSpacing = CellMarginX;
    flowLayout.headerReferenceSize = CGSizeMake(self.bounds.size.width, 40);
    
    collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
    collectionView.showsHorizontalScrollIndicator = false;
    collectionView.backgroundColor = [UIColor clearColor];
    [collectionView registerClass:[SYCToolsCell class] forCellWithReuseIdentifier:@"SYCToolsCell"];
    [collectionView registerClass:[SYCEditToolsViewHeader class]
        forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SYCEditToolsViewHeader"];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [self addSubview:collectionView];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressMethod:)];
    longPress.minimumPressDuration = 0.3f;
    [collectionView addGestureRecognizer:longPress];
    
    dragingItem = [[SYCToolsCell alloc] initWithFrame:CGRectMake(0, 0, cellWidth, cellWidth/2.0f)];
    dragingItem.hidden = true;
    [collectionView addSubview:dragingItem];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return section == 0 ? self.inUseTools.count : self.unUseTools.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    SYCEditToolsViewHeader *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SYCEditToolsViewHeader" forIndexPath:indexPath];
    if (indexPath.section == 0) {
        headerView.title = @"已选功能";
        headerView.subTitle = @"长按并拖动调整排序";
    }else{
        headerView.title = @"全部功能";
        headerView.subTitle = @"轻按添加/删除功能";
    }
    return headerView;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SYCToolModel *tool = indexPath.section == 0 ? _inUseTools[indexPath.row] : _unUseTools[indexPath.row];
    SYCToolsCell* item = [collectionView dequeueReusableCellWithReuseIdentifier:@"SYCToolsCell" forIndexPath:indexPath];
    item.title = tool.title;
    item.image = [UIImage imageNamed:tool.imageName];
    if ([indexPath row] == 0 && [indexPath section] == 0) {
        item.image = [UIImage imageNamed:@"成绩单灰"];
        item.title = @"成绩单(锁定)";
    }
    return item;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        //只剩一个的时候不可删除
        if ([collectionView numberOfItemsInSection:0] == 1) {return;}
        //第一个不可删除
        if (indexPath.row  == 0) {return;}
        id obj = [_inUseTools objectAtIndex:indexPath.row];
        [_inUseTools removeObject:obj];
        [_unUseTools insertObject:obj atIndex:0];
        [collectionView moveItemAtIndexPath:indexPath toIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    }else{
        id obj = [_unUseTools objectAtIndex:indexPath.row];
        [_unUseTools removeObject:obj];
        [_inUseTools addObject:obj];
        [collectionView moveItemAtIndexPath:indexPath toIndexPath:[NSIndexPath indexPathForRow:_inUseTools.count - 1 inSection:0]];
    }
}

//拖拽
- (void)longPressMethod:(UILongPressGestureRecognizer*)gesture{
    CGPoint point = [gesture locationInView:collectionView];
    switch (gesture.state) {
            case UIGestureRecognizerStateBegan:
            [self dragBegin:point];
            break;
            case UIGestureRecognizerStateChanged:
            [self dragChanged:point];
            break;
            case UIGestureRecognizerStateEnded:
            [self dragEnd];
            break;
        default:
            break;
    }
}

//拖拽开始 找到被拖拽的item
- (void)dragBegin:(CGPoint)point{
    dragingIndexPath = [self getDragingIndexPathWithPoint:point];
    if (!dragingIndexPath) {return;}
    [collectionView bringSubviewToFront:dragingItem];
    SYCToolsCell *item = (SYCToolsCell *)[collectionView cellForItemAtIndexPath:dragingIndexPath];
    item.isMoving = true;
    item.hidden = YES;
    //更新被拖拽的item
    dragingItem.hidden = false;

    dragingItem.frame = item.frame;
    dragingItem.title = item.title;
    dragingItem.image = item.image;
    dragingItem.backgroundColor = [UIColor clearColor];
    [dragingItem setTransform:CGAffineTransformMakeScale(1.1, 1.1)];
}

//正在被拖拽
- (void)dragChanged:(CGPoint)point{
    if (!dragingIndexPath) {return;}
    dragingItem.center = point;
    targetIndexPath = [self getTargetIndexPathWithPoint:point];
    //交换位置 如果没有找到_targetIndexPath则不交换位置
    if (dragingIndexPath && targetIndexPath) {
        //更新数据源
        [self rearrangeInUseTitles];
        //更新item位置
        [collectionView moveItemAtIndexPath:dragingIndexPath toIndexPath:targetIndexPath];
        dragingIndexPath = targetIndexPath;
    }
}

//拖拽结束
- (void)dragEnd{
    if (!dragingIndexPath) {return;}
    CGRect endFrame = [collectionView cellForItemAtIndexPath:dragingIndexPath].frame;
    [dragingItem setTransform:CGAffineTransformMakeScale(1.0, 1.0)];
    [UIView animateWithDuration:0.3 animations:^{
        dragingItem.frame = endFrame;
    }completion:^(BOOL finished) {
        dragingItem.hidden = true;
        SYCToolsCell *item = (SYCToolsCell *)[collectionView cellForItemAtIndexPath:dragingIndexPath];
        item.isMoving = false;
        item.hidden = NO;
    }];
    
}

#pragma mark -
#pragma mark 辅助方法

//获取被拖动IndexPath的方法
- (NSIndexPath*)getDragingIndexPathWithPoint:(CGPoint)point{
    NSIndexPath* dragIndexPath = nil;
    //最后剩一个怎不可以排序
    if ([collectionView numberOfItemsInSection:0] == 1) {return dragIndexPath;}
    for (NSIndexPath *indexPath in collectionView.indexPathsForVisibleItems) {
        //下半部分不需要排序
        if (indexPath.section > 0) {continue;}
        //在上半部分中找出相对应的Item
        if (CGRectContainsPoint([collectionView cellForItemAtIndexPath:indexPath].frame, point)) {
            if (indexPath.row != 0) {
                dragIndexPath = indexPath;
            }
            break;
        }
    }
    return dragIndexPath;
}

//获取目标IndexPath的方法
- (NSIndexPath*)getTargetIndexPathWithPoint:(CGPoint)point{
    NSIndexPath *targetIndexPath = nil;
    for (NSIndexPath *indexPath in collectionView.indexPathsForVisibleItems) {
        //如果是自己不需要排序
        if ([indexPath isEqual:dragingIndexPath]) {continue;}
        //第二组不需要排序
        if (indexPath.section > 0) {continue;}
        //在第一组中找出将被替换位置的Item
        if (CGRectContainsPoint([collectionView cellForItemAtIndexPath:indexPath].frame, point)) {
            if (indexPath.row != 0) {
                targetIndexPath = indexPath;
            }
        }
    }
    return targetIndexPath;
}

#pragma mark 刷新方法
//拖拽排序后需要重新排序数据源
- (void)rearrangeInUseTitles{
    id obj = [_inUseTools objectAtIndex:dragingIndexPath.row];
    [_inUseTools removeObject:obj];
    [_inUseTools insertObject:obj atIndex:targetIndexPath.row];
}

- (void)reloadData{
    [collectionView reloadData];
}

@end
