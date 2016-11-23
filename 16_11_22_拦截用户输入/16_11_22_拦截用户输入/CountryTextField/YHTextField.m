//
//  YHTextField.m
//  16_11_22_拦截用户输入
//
//  Created by 姚懿恒 on 2016/11/23.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "YHTextField.h"
#import "YHFlagItem.h"
#import "YHFlagView.h"

@interface YHTextField ()<UIPickerViewDelegate, UIPickerViewDataSource>
/** 数据数组*/
@property (nonatomic, strong)NSArray *dataArray;

@end

@implementation YHTextField
#pragma mark 懒加载数组, 并将字典转化为模型数组.这里没有用到MJ的框架, 复习之前的写法.
- (NSArray *)dataArray{
    if (!_dataArray) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"flags.plist" ofType:nil];
        NSArray *dataInBundle = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *tempArray = [NSMutableArray array];
        for (NSDictionary *dict in dataInBundle) {
            YHFlagItem *flagItems = [YHFlagItem flagItemWithDictionary:dict];
            [tempArray addObject:flagItems];
        }
        _dataArray = tempArray;
    }
    return _dataArray;
}
#pragma mark 以下两个方法, 是为了方便使用, 无论是从xib文件中加载或者是代码编写
- (void)awakeFromNib{
    [super awakeFromNib];

    [self setUp];
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}
#pragma mark 在该方法中完成初始化
- (void)setUp{
    UIPickerView *pickerView = [[UIPickerView alloc] init];
    pickerView.delegate = self;
    pickerView.dataSource = self;
    //更改inputView, 不是默认的键盘, 而是一个pickerView
    self.inputView = pickerView;
}

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;

}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    return self.dataArray.count;
}
#pragma mark 在该方法中, 返回想要显示的view.
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    //创建并返回自定义的view, 通过模型数组, 以及viewForRow: 拿到对应行的模型, 并赋值
    YHFlagView *flagView = [YHFlagView flagView];
    YHFlagItem *items = self.dataArray[row];
    flagView.flagItem = items;

    return flagView;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 118;
}

@end
