//
//  ViewController.m
//  17_04_25_CollectionView循环利用tableView
//
//  Created by 姚懿恒 on 2017/4/25.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "ViewController.h"
#import "YYHReuseCollectionViewCell.h"
@interface ViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>


/** 模型*/
@property (nonatomic, strong) NSArray *items;
@end

@implementation ViewController

- (NSArray *)items{
    if (!_items) {
        _items = @[@"体育", @"科技", @"娱乐",
                   @"体育1", @"科技1", @"娱乐1",
                   @"体育2", @"科技2", @"娱乐3"
                   ];
    }
    return _items;
}
static NSString *cellID = @"cell";
- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupCollectionView];
}
- (void)setupCollectionView{

    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.itemSize = self.view.bounds.size;


    UICollectionView *collection = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:flowLayout];

    [collection registerNib:[UINib nibWithNibName:NSStringFromClass([YYHReuseCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:cellID];
    collection.backgroundColor = [UIColor lightGrayColor];
    collection.dataSource = self;
    collection.delegate = self;
    collection.pagingEnabled = YES;

    [self.view addSubview:collection];
}
#pragma mark - -------UICollectionViewDataSource--------------
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{


    YYHReuseCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];

    cell.backgroundColor = [UIColor cyanColor];

    cell.item = self.items[indexPath.row];
    return cell;
}

#pragma mark - -------UICollectionViewDelegate--------------
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
