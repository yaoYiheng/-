//
//  YYHNewFeatureCollectionViewCell.h
//  17_01_10_彩票项目
//
//  Created by 姚懿恒 on 2017/1/16.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYHNewFeatureCollectionViewCell : UICollectionViewCell

/** 图片*/
@property (nonatomic, strong) UIImage *cellImage;
/** 是不是最后一个*/
@property (nonatomic, assign, getter = isLastPage) BOOL lastPage;

@end
