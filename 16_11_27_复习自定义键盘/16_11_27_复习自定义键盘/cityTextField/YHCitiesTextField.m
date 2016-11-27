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
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == 0) {
        return self.dataArray.count;
    }else{
        YHCitiesItem *item = self.dataArray[self.currentCityIndex];
        return item.cities.count;

    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component == 0) {
        YHCitiesItem *item = self.dataArray[row];
        return item.name;
    }else{
        YHCitiesItem *item = self.dataArray[self.currentCityIndex];
        return item.cities[row];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component == 0) {
        self.currentCityIndex = row;
        [pickerView reloadAllComponents];
        [pickerView selectRow:0 inComponent:1 animated:YES];
    }
    YHCitiesItem *item = self.dataArray[self.currentCityIndex];
    NSString *provinceName = item.name;

    NSInteger cityIndex = [pickerView selectedRowInComponent:1];
    NSString *cityName = item.cities[cityIndex];

    self.text = [NSString stringWithFormat:@"%@ %@", provinceName, cityName];


}
-(void)initWithText{
    [self pickerView:self.pickerView didSelectRow:0 inComponent:0];
}

@end
