//
//  ViewController.m
//  16_10_13_03-综合练习
//
//  Created by 姚懿恒 on 2016/10/13.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "ViewController.h"
#import "Item.h"
#import "ItemView.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *cartView;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UILabel *showHUB;
@property (weak, nonatomic) IBOutlet UIButton *removeButton;
/** 数据数组*/
@property (nonatomic, strong) NSArray *data;
/** 临时数组*/
//@property (nonatomic, strong) NSMutableArray *itemsArray;
@end

@implementation ViewController

/**
 懒加载

 @return 重写data数组的get方法.
 保证了:
 1.全局都可以使用该数据.
 2.用到的时候才进行加载.
 3.只加载一次.
 */
-(NSArray *)data{
    if (_data == nil)
    {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"shopData.plist" ofType:nil];

        //字典类型的文件
        _data = [NSArray arrayWithContentsOfFile:path];

        //将字典文件转化为item文件
        NSMutableArray *temp = [NSMutableArray array];
        for (NSDictionary *dict in _data)
        {
            Item *items = [Item itemWithDictionary:dict];

            [temp addObject:items];
        }
        _data = temp;
    }
    return _data;
}
- (void)viewDidLoad {
    [super viewDidLoad];


    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
添加项目到购物车

 @param sender 添加
 */
- (IBAction)addItem:(UIButton *)sender {

        /**********1.定义一些常量****************/
    int col = 3;
    NSInteger itemIndex = self.cartView.subviews.count;
    CGFloat itemWidth = 100;
    CGFloat itemHeigh = 150;

    CGFloat hGap = (self.view.frame.size.width - col * itemWidth ) / (col - 1);
    CGFloat vGap = (self.cartView.frame.size.height - 2 * itemHeigh) ;


    CGFloat x = (hGap + itemWidth) * (itemIndex % col);
    CGFloat y = (vGap + itemHeigh) * (itemIndex / col);

        /**********2.向cartView中添加子项目****************/

    ItemView *itemView = [ItemView itemView];
    itemView.frame = CGRectMake(x, y, itemWidth, itemHeigh);
    itemView.item = self.data[itemIndex];

    [self.cartView addSubview:itemView];
    

        /**********3.更改按钮的状态****************/
    sender.enabled = (itemIndex != 5);
    _removeButton.enabled = YES;

        /**********4.更改showHUB的显示状态************/
    if (itemIndex == 5) {

        [self showWithInfo:@"购物车已满, 赶紧结账"];
    }
}

/**
 删除项目

 @param sender 删除
 */
- (IBAction)removeItem:(UIButton *)sender {

    //取出最后一个item, 并移除.
    UIView *lastView = [self.cartView.subviews lastObject];
    [lastView removeFromSuperview];


    /**********4.更改showHUB的显示状态************/
    if (self.cartView.subviews.count == 0) {

        [self showWithInfo:@"购物车已空, 赶紧买买买"];


    }
    _addButton.enabled = YES;
    sender.enabled = (self.cartView.subviews.count != 0);
}

/**
 添加渐变动画

 @param info 传入不同状态下需要显示的字符串.
 */
-(void)showWithInfo:(NSString *)info
{   //动画持续1s, 设置透明度为0, 并显示相应的字符串
    [UIView animateWithDuration:1.0 animations:^{
        self.showHUB.alpha = 1.0;
        self.showHUB.text = info;
    } completion:^(BOOL finished)
     {
         //动画结束后, 需要执行以下代码, 持续0.5s, 延迟1s执行, 将显示栏的透明度变为0.
        [UIView animateWithDuration:0.5 delay:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.showHUB.alpha = 0;
        } completion:nil];
    }];

}

@end
