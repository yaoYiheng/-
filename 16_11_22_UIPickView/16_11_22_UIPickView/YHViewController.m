//
//  YHViewController.m
//  16_11_22_UIPickView
//
//  Created by 姚懿恒 on 2016/11/22.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "YHViewController.h"

@interface YHViewController ()<UIPickerViewDelegate, UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UIPickerView *pickView;

/** 数组文件*/
@property (nonatomic, strong) NSArray *dataArray;
@property (weak, nonatomic) IBOutlet UILabel *showLabel;

@end

@implementation YHViewController

- (NSArray *)dataArray{
    if (!_dataArray) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"foods.plist" ofType:nil];
        _dataArray = [NSArray arrayWithContentsOfFile:path];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self pickerView:self.pickView didSelectRow:0 inComponent:0 ];
    // Do any additional setup after loading the view from its nib.

}


// returns the number of 'columns' to display.
//返回需要显示的列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return self.dataArray.count;
}

// returns the # of rows in each component..
//返回需要返回的列数中的行数.
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    NSArray *data = self.dataArray[component];
    return data.count;

}

/**
 从数组中拿到对应未知的数据并返回, 显示出来

 */
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSArray *data = self.dataArray[component];
    return data[row];
}

/**
 拿到选中的某一行, 做一些操作
 */
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSArray *data = self.dataArray[component];
    self.showLabel.text = data[row];
}
@end
