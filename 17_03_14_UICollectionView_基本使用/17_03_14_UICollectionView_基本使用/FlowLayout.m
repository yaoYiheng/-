//
//  FlowLayout.m
//  17_03_14_UICollectionView_基本使用
//
//  Created by 姚懿恒 on 2017/3/15.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "FlowLayout.h"

@implementation FlowLayout

/**
    当边界发生改变时，是否应该刷新布局。
 如果YES则在边界变化（一般是scroll到其他地方）时，将重新计算需要的布局信息。
 */
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}
/*
 UICollectionViewLayoutAttributes:确定cell的尺寸
 一个UICollectionViewLayoutAttributes对象就对应一个cell
 拿到UICollectionViewLayoutAttributes相当于拿到cell
 */

// 重写它方法,扩展功能

// 什么时候调用:collectionView第一次布局,collectionView刷新的时候也会调用
// 作用:计算cell的布局,条件:cell的位置是固定不变
// - (void)prepareLayout
//{
//    [super prepareLayout];
//
//    NSLog(@"%s",__func__);
//
//}

// 作用:指定一段区域给你这段区域内cell的尺寸
// 可以一次性返回所有cell尺寸,也可以每隔一个距离返回cell
- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    //    NSLog(@"%s, %@",__func__,NSStringFromCGRect(self.collectionView.bounds));
    // 设置cell尺寸 => UICollectionViewLayoutAttributes
    // 越靠近中心点,距离越小,缩放越大
    // 求cell与中心点距离

    // 1.获取当前显示cell的布局
    NSArray *attrs = [super layoutAttributesForElementsInRect:self.collectionView.bounds];

    for (UICollectionViewLayoutAttributes *attr in attrs) {

        // 2.计算中心点距离
        CGFloat delta = fabs((attr.center.x - self.collectionView.contentOffset.x) - self.collectionView.bounds.size.width * 0.5);

        // 3.计算比例
        CGFloat scale = 1 - delta / (self.collectionView.bounds.size.width * 0.5) * 0.25;

        attr.transform = CGAffineTransformMakeScale(scale, scale);
    }

    return attrs;

}

// 什么时候调用:用户手指一松开就会调用
// 作用:确定最终偏移量
// 定位:距离中心点越近,这个cell最终展示到中心点
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity{

    //    NSLog(@"%f  =====%f", proposedContentOffset.x, velocity.x);
    // 拖动比较快 最终偏移量 不等于 手指离开时偏移量
    CGFloat collectionW = self.collectionView.bounds.size.width;

    // 最终偏移量
    CGPoint targetP = [super targetContentOffsetForProposedContentOffset:proposedContentOffset withScrollingVelocity:velocity];

    // 0.获取最终显示的区域
    CGRect targetRect = CGRectMake(targetP.x, 0, collectionW, MAXFLOAT);

    // 1.获取最终显示的cell
    NSArray *attrs = [super layoutAttributesForElementsInRect:targetRect];

    // 获取最小间距
    CGFloat minDelta = MAXFLOAT;
    for (UICollectionViewLayoutAttributes *attr in attrs) {
        // 获取距离中心点距离:注意:应该用最终的x
        CGFloat delta = (attr.center.x - targetP.x) - self.collectionView.bounds.size.width * 0.5;

        if (fabs(delta) < fabs(minDelta)) {
            minDelta = delta;
        }
    }

    // 移动间距
    targetP.x += minDelta;

    if (targetP.x < 0) {
        targetP.x = 0;
    }


    return targetP;
}


@end
