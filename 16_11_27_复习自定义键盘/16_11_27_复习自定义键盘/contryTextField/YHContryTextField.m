//
//  YHContryTextField.m
//  16_11_27_复习自定义键盘
//
//  Created by 姚懿恒 on 2016/11/27.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "YHContryTextField.h"
#import "YHContryItem.h"
#import "YHContryView.h"

@interface YHContryTextField ()<UIPickerViewDelegate, UIPickerViewDataSource>

/** 数组*/
@property (nonatomic, strong) NSArray *dataArray;

/** */
@property (nonatomic, weak) UIPickerView *pickerView;
@end


@implementation YHContryTextField
- (void)initWithText{
    [self pickerView:self.pickerView didSelectRow:0 inComponent:0];
}
#pragma mark 懒加载数据
- (NSArray *)dataArray{
    if (!_dataArray) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"flags.plist" ofType:nil];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];

        NSMutableArray *temp = [NSMutableArray array];
        for (NSDictionary *dict in array) {
            YHContryItem *countryItem = [YHContryItem contryItemWithDictionary:dict];
            [temp addObject:countryItem];
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
#pragma mark pickerView返回的是自定义的UIView.
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{

    YHContryView *contryView = [YHContryView contryView];
    contryView.countryItem = self.dataArray[row];

    return contryView;
}
#pragma mark UIPickerView数据源方法
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.dataArray.count;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 100;
}
#pragma mark 选中某行后来到该方法, 在该方法中修改想要显示到文本框上的内容.
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{

    YHContryItem *item = self.dataArray[row];
    self.text = item.name;
}
@end
