//
//  ViewController.m
//  17_03_14_UICollectionView_基本使用
//
//  Created by 姚懿恒 on 2017/3/14.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "ViewController.h"
#import "PhotoCollectionViewCell.h"
#import "FlowLayout.h"

@interface ViewController ()<UICollectionViewDataSource>
#define ScreenW [UIScreen mainScreen].bounds.size.width
@end

@implementation ViewController

static NSString * const ID = @"cell";
#pragma mark -----UICollectionViewDataSource-----
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return 10;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{


    /*
        自定义cell, 加入图片.
     */
    PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor orangeColor];

    NSString *imageName = [NSString stringWithFormat:@"%ld", indexPath.row + 1];
    UIImage *image = [UIImage imageNamed:imageName];
    cell.image = image;
    return cell;

}
- (void)viewDidLoad {
    [super viewDidLoad];


//    UICollectionViewFlowLayout *viewLayout = [[UICollectionViewFlowLayout alloc] init];
//    viewLayout.itemSize = CGSizeMake(180, 180);
//    viewLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//    CGFloat margin = (ScreenW - 150) / 2;
//    viewLayout.sectionInset = UIEdgeInsetsMake(0, margin, 0, margin);
//    viewLayout.minimumLineSpacing = 70;


    /*
        通过自定义流水布局, 实现cell的缩放.
     */

    FlowLayout *viewLayout = ({
        FlowLayout *viewLayout = [[FlowLayout alloc] init];
        viewLayout.itemSize = CGSizeMake(180, 180);
        viewLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        CGFloat margin = (ScreenW - 150) / 2;
        viewLayout.sectionInset = UIEdgeInsetsMake(0, margin, 0, margin);
        viewLayout.minimumLineSpacing = 70;

        viewLayout;

    });

//    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 200, ScreenW, 250) collectionViewLayout:viewLayout];
//
////    collectionView.backgroundColor = [UIColor grayColor];
//
//    collectionView.dataSource = self;
//    [self.view addSubview:collectionView];
//    collectionView.showsHorizontalScrollIndicator = NO;

    UICollectionView *collectionView = ({
      UICollectionView *collectionView =   [[UICollectionView alloc] initWithFrame:CGRectMake(0, 200, ScreenW, 250) collectionViewLayout:viewLayout];

        //    collectionView.backgroundColor = [UIColor grayColor];

        collectionView.dataSource = self;
        [self.view addSubview:collectionView];
        collectionView.showsHorizontalScrollIndicator = NO;

        collectionView;
    });



    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([PhotoCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:ID];
}


@end
