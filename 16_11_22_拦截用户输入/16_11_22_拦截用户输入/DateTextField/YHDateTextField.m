//
//  YHDateTextField.m
//  16_11_22_拦截用户输入
//
//  Created by 姚懿恒 on 2016/11/25.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "YHDateTextField.h"

@implementation YHDateTextField

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
    //创建一个日期选择器, 并在此处修改datePicker的日期模式.
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    datePicker.datePickerMode = UIDatePickerModeDate;

    //显示日期本地化设置.
    datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];

    //监听datePicker的值改变.
    [datePicker addTarget:self action:@selector(dataChange:) forControlEvents:UIControlEventValueChanged];
    self.inputView = datePicker;
}

- (void)dataChange:(UIDatePicker *)dataPicker{

    //将日期转化为字符串.
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    formatter.dateFormat = @"DD-MM-YYYY";

    NSDate *date =dataPicker.date;
    NSString *dateString = [formatter stringFromDate:date];
    //修改文本框的显示内容.
    self.text = dateString;
}
@end
