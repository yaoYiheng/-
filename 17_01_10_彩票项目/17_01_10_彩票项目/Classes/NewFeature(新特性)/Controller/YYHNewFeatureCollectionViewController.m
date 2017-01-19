//
//  YYHNewFeatureCollectionViewController.m
//  17_01_10_彩票项目
//
//  Created by 姚懿恒 on 2017/1/16.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "YYHNewFeatureCollectionViewController.h"
#import "YYHNewFeatureCollectionViewCell.h"

@interface YYHNewFeatureCollectionViewController ()
/** 球imageView*/
@property (nonatomic, weak) UIImageView *guide;
/** <#comments#>*/
@property (nonatomic, weak) UIImageView *guideLargeText;
/** <#comments#>*/
@property (nonatomic, weak) UIImageView *guideSmallText;
/** <#comments#>*/
@property (nonatomic, assign) CGFloat lastOffsetX;

@end

@implementation YYHNewFeatureCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (instancetype)init{
    /**
     初始化为流水布局
     系统已经给我们提供好了布局样式,其中我们最常用的布局样式是流水布局
     流水布局 UICollectionView 变宽,cell向上流,变窄向下流
     */

    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];

    //修改每个Items 的间距
    flowLayout.minimumInteritemSpacing = 0;
    //设置item的大小, 与屏幕大小一样.
    flowLayout.itemSize = [UIScreen mainScreen].bounds.size;
    //修改行间距
    flowLayout.minimumLineSpacing = 0;

    //修改水平滚动
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;

    return [super initWithCollectionViewLayout:flowLayout];


}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{


    //拿到当前总偏移量
    CGFloat offset = scrollView.contentOffset.x;

    //计算一个偏移量
    CGFloat delta = offset - self.lastOffsetX;
    //计算当前页数
    //(偏移量 / scrollView的宽度), 修正滑动不成功动画成功的bug.
    NSInteger page = offset / scrollView.Width + 1;

    //根据页数拼接图片名
    NSString *guideName = [NSString stringWithFormat:@"guide%ld", page];
    NSString *largtTitle = [NSString stringWithFormat:@"guideLargeText%ld", page];
    NSString *smaleTitle = [NSString stringWithFormat:@"guideSmallText%ld", page];

    //设置图片
    self.guide.image = [UIImage imageNamed:guideName];
    self.guideLargeText.image = [UIImage imageNamed:largtTitle];
    self.guideSmallText.image = [UIImage imageNamed:smaleTitle];

    //根据偏移量修改图片位置
    self.guide.x += 2 *delta;
    self.guideLargeText.x += 2 *delta;
    self.guideSmallText.x += 2 * delta;

    //加载动画
    [UIView animateWithDuration:0.2 animations:^{
        self.guide.x -= delta;
        self.guideLargeText.x -= delta;
        self.guideSmallText.x -= delta;
    }];

    //保存当前偏移量
    self.lastOffsetX = offset;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
//     self.clearsSelectionOnViewWillAppear = NO;

    // Register cell classes
    [self.collectionView registerClass:[YYHNewFeatureCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
    self.collectionView.backgroundColor = [UIColor orangeColor];

    //去掉弹簧效果
    self.collectionView.bounces = NO;
    //设置分页功能
    self.collectionView.pagingEnabled = YES;

    //隐藏水平滚动条
    self.collectionView.showsHorizontalScrollIndicator = NO;

//    NSLog(@"%@", self.collectionView);

    //添加子控件到self.collectionView上
    [self configureSubViews];
}

- (void)configureSubViews{
    // 1.线
    UIImageView *guideLine = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"guideLine"]];
    [self.collectionView addSubview:guideLine];
    guideLine.x -= 150;

    // 2.球
    UIImageView *guide = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"guide1"]];
    [self.collectionView addSubview:guide];
    guide.x += 50;
    self.guide = guide;

    // 3.大标题 guideLargeText
    UIImageView *guideLargeText = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"guideLargeText1"]];
    [self.collectionView addSubview:guideLargeText];
    guideLargeText.center = CGPointMake(self.view.Width / 2, self.view.Height * 0.7f );
    self.guideLargeText = guideLargeText;

    // 4.小标题 guideSmallText
    UIImageView *guideSmallText = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"guideSmallText1"]];
    [self.collectionView addSubview:guideSmallText];
    guideSmallText.center = CGPointMake(self.view.Width / 2, self.view.Height * 0.8f );
    self.guideSmallText = guideSmallText;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}

#define YYHPage 4
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return YYHPage;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    YYHNewFeatureCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[YYHNewFeatureCollectionViewCell alloc] init];
    }

    //通过拿到indexPath对图片名进行拼接
    NSString *imageName = [NSString stringWithFormat:@"guide%ldBackground", indexPath.item + 1];

    UIImage *image = [UIImage imageNamed:imageName];

    //对cell中的cellImage属性进行赋值
    cell.cellImage = image;

    //如果是最后一个

    cell.lastPage = indexPath.item == YYHPage - 1;

    return cell;
}


#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
