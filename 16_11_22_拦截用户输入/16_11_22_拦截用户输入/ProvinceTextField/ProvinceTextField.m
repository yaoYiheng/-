//
//  ProvinceTextField.m
//  16_11_22_拦截用户输入
//
//  Created by 姚懿恒 on 2016/11/26.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "ProvinceTextField.h"
#import "YHProvinceItem.h"

@interface ProvinceTextField ()<UIPickerViewDelegate, UIPickerViewDataSource>

/** 数据数组*/
@property (nonatomic, strong) NSArray *dataArray;

/** 记录选中省份的角标*/
@property (nonatomic, assign) NSInteger proCurrentIndex;

@end

@implementation ProvinceTextField
- (void)awakeFromNib{
    [super awakeFromNib];

    [self setUp];
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

- (void)setUp{
    UIPickerView *picker = [[UIPickerView alloc] init];
    picker.delegate = self;
    picker.dataSource = self;
    self.inputView = picker;
}
- (NSArray *)dataArray{
    if (!_dataArray) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"provinces.plist" ofType:nil];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];

        NSMutableArray *temp = [NSMutableArray array];
        for (NSDictionary *dict in array) {
            YHProvinceItem *provinceItem = [YHProvinceItem provinceItemWithDictionary:dict];
            [temp addObject:provinceItem];
        }
        _dataArray = temp;
    }
    return _dataArray;
}

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{

    return 2;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{

    if (component == 0) {
        return self.dataArray.count;
    }
    else{
        YHProvinceItem *item = self.dataArray[self.proCurrentIndex];
        return item.cities.count;
    }

}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    //如果component为0, 说明当前选中的是省份那一列, 可以通过省份所在的row, 从数组中拿到对应的省份模型.
    if (component == 0) {
        self.proCurrentIndex = row;
    }
    YHProvinceItem *provinceItem = self.dataArray[self.proCurrentIndex];
    NSString *provinceName = provinceItem.name;

}
@end
