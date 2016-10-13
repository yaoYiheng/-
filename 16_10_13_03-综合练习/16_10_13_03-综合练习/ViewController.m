//
//  ViewController.m
//  16_10_13_03-综合练习
//
//  Created by 姚懿恒 on 2016/10/13.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "ViewController.h"
#import "Item.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *cartView;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
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

    UIView *itemView = [[UIView alloc] initWithFrame:CGRectMake(x, y, itemWidth, itemHeigh)];

    itemView.backgroundColor = [UIColor grayColor];

    [self.cartView addSubview:itemView];

    //创建itemView中的UIImageView跟UILabel
    UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, itemWidth, itemWidth)];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, itemWidth, itemWidth, itemHeigh - itemWidth)];

    //设置它们的背景颜色
    iconView.backgroundColor = [UIColor blueColor];
    titleLabel.backgroundColor = [UIColor yellowColor];
    //设置标题居中显示
    titleLabel.textAlignment = NSTextAlignmentCenter;

    //将其添加到单个的itemView当中
    [itemView addSubview:iconView];
    [itemView addSubview:titleLabel];

    /**********3.加载数据****************/
    //此处如果换成_data的写法, 则无法加载数据, 必须写成self.data,才能加载数据,
    //因为第24行重写了data的get方法, 只有写self.data才能加载重写的方法, 才能加载
    //数据, 而_data仅仅只是访问其成员变量, 而且是没有任何数据的成员变量, 所以才会出现null
    Item *item = self.data[itemIndex];
    iconView.image = [UIImage imageNamed:item.icon];
    titleLabel.text = item.title;




    /**********4.更改按钮的状态****************/
    sender.enabled = (itemIndex != 5);
    _removeButton.enabled = YES;
    
}

/**
 删除项目

 @param sender 删除
 */
- (IBAction)removeItem:(UIButton *)sender {

    //取出最后一个item, 并移除.
    UIView *lastView = [self.cartView.subviews lastObject];
    [lastView removeFromSuperview];

    _addButton.enabled = YES;
    sender.enabled = (self.cartView.subviews.count != 0);
}

@end
