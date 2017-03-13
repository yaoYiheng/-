//
//  ViewController.m
//  17_03_14_UICollectionView_基本使用
//
//  Created by 姚懿恒 on 2017/3/14.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "ViewController.h"

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


    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor orangeColor];

    return cell;

}
- (void)viewDidLoad {
    [super viewDidLoad];


    UICollectionViewFlowLayout *viewLayout = [[UICollectionViewFlowLayout alloc] init];
    viewLayout.itemSize = CGSizeMake(160, 160);
    viewLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    CGFloat margin = (ScreenW - 150) / 2;
    viewLayout.sectionInset = UIEdgeInsetsMake(0, margin, 0, margin);
    viewLayout.minimumLineSpacing = 70;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 200, ScreenW, 200) collectionViewLayout:viewLayout];

    collectionView.backgroundColor = [UIColor grayColor];

    collectionView.dataSource = self;
    [self.view addSubview:collectionView];
    collectionView.showsHorizontalScrollIndicator = NO;


    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:ID];
}


@end
