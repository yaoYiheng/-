//
//  YYHNewFeatureCollectionViewCell.m
//  17_01_10_彩票项目
//
//  Created by 姚懿恒 on 2017/1/16.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "YYHNewFeatureCollectionViewCell.h"

@interface YYHNewFeatureCollectionViewCell ()
/** UIImageView*/
@property (nonatomic, weak) UIImageView *backGroundImageView;

@end

@implementation YYHNewFeatureCollectionViewCell

- (UIImageView *)backGroundImageView{
    if (!_backGroundImageView) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];

        [self.contentView addSubview:imageView];

        _backGroundImageView = imageView;
    }
    return _backGroundImageView;
}

- (void)setCellImage:(UIImage *)cellImage{
    _cellImage = cellImage;
    self.backGroundImageView.image = cellImage;

}
@end
