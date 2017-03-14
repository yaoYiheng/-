//
//  PhotoCollectionViewCell.m
//  17_03_14_UICollectionView_基本使用
//
//  Created by 姚懿恒 on 2017/3/14.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "PhotoCollectionViewCell.h"
@interface PhotoCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *PhotoImageView;

@end

@implementation PhotoCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setImage:(UIImage *)image{
    _image = image;

    self.PhotoImageView.image = image;
}

@end
