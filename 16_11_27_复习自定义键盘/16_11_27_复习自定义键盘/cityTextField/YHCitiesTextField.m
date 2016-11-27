//
//  YHCitiesTextField.m
//  16_11_27_复习自定义键盘
//
//  Created by 姚懿恒 on 2016/11/27.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "YHCitiesTextField.h"
#import "YHCitiesItem.h"

@interface YHCitiesTextField ()<UIPickerViewDelegate, UIPickerViewDataSource>

/** 数据数组*/
@property (nonatomic, strong) NSArray *dataArray;
/** 记录选中省份的索引*/
@property (nonatomic, assign) NSInteger currentCityIndex;
/** <#comments#>*/
@property (nonatomic, weak) UIPickerView *pickerView;
@end

@implementation YHCitiesTextField

#pragma mark 懒加载数据
- (NSArray *)dataArray{
    if (!_dataArray) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"provinces.plist" ofType:nil];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];

        NSMutableArray *temp = [NSMutableArray array];
        for (NSDictionary *dict in array) {
            YHCitiesItem *citiesItem = [YHCitiesItem citiesItemWithDictionary:dict];
            [temp addObject:citiesItem];
        }
        _dataArray = temp;
    }
    return _dataArray;
}

#pragma mark 提供两个初始化方法, 无论用户是从nib文件中加载, 或是代码编写, 都有相应的初始化方法
- (void)awakeFromNib{

    [super awakeFromNib];
    [self setUp];

}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

- (void)setUp{

    UIPickerView *picker = [[UIPickerView alloc] init];
    self.pickerView = picker;

    self.inputView = picker;
    picker.delegate = self;
    picker.dataSource = self;

    self.inputView = picker;
    
}
#pragma  mark 通过component以及currentCityIndex, 拿到对应数组中的元素, 返回数量.
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == 0) {
        return self.dataArray.count;
    }else{
        YHCitiesItem *item = self.dataArray[self.currentCityIndex];
        return item.cities.count;

    }
}

#pragma mark 2列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}

#pragma mark 在该方法中返回需要显示的文字.
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component == 0) {
        YHCitiesItem *item = self.dataArray[row];
        return item.name;
    }else{
        YHCitiesItem *item = self.dataArray[self.currentCityIndex];
        return item.cities[row];
    }
}
#pragma mark 当pickerView中某行被选中时机会来到该方法. 可在该方法中更改文本框显示的内容.
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    //当component为0时, 选中的为省份.
    if (component == 0) {
        //仅记录下当选中省份行时的row,
        self.currentCityIndex = row;

        //选中第1列的第0行
        [pickerView selectRow:0 inComponent:1 animated:YES];
        //刷新pickerView
        [pickerView reloadAllComponents];
    }
    //通过选中的省份的角标拿到数组中对应的item
    YHCitiesItem *item = self.dataArray[self.currentCityIndex];
    NSString *provinceName = item.name;

    //调用selectedRowInComponent:方法, 返回传入的列数中对应的行数的index
    NSInteger cityIndex = [pickerView selectedRowInComponent:1];
    //通过index拿到对应数组里的元素
    NSString *cityName = item.cities[cityIndex];

    self.text = [NSString stringWithFormat:@"%@ %@", provinceName, cityName];


}
#pragma mark 当该方法被调用时, 默认选中第0列第0行的内容.
-(void)initWithText{
    [self pickerView:self.pickerView didSelectRow:0 inComponent:0];
}

@end
