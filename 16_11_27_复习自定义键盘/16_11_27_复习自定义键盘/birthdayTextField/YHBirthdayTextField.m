//
//  YHBirthdayTextField.m
//  16_11_27_复习自定义键盘
//
//  Created by 姚懿恒 on 2016/11/27.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "YHBirthdayTextField.h"


@interface YHBirthdayTextField ()<UITextFieldDelegate>
/** <#comments#>*/
@property (nonatomic, weak) UIDatePicker *datePicker;

@end

@implementation YHBirthdayTextField
#pragma mark 当该方法被调用时, 默认选中第0列第0行的内容.
-(void)initWithText{
    [self dateChange:self.datePicker];
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
    //创建初始化一个UIDatePicker, 并将其设置为 inputView
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    self.datePicker = datePicker;
    self.inputView = datePicker;
    //更改显示模式为    UIDatePickerModeDate,
    // Displays month, day, and year depending on the locale setting (e.g. November | 15 | 2007)
    datePicker.datePickerMode = UIDatePickerModeDate;

    //设置本地化
    datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
    //为datePicker添加监听器, 监听datePicker值的改变
    [datePicker addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];

}
#pragma mark 当datePicker的值发生改变时就会来到该方法.
- (void)dateChange:(UIDatePicker *)datePicker{
    //初始化 并设置日期格式
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //发现如果此处dd改为大写, 会出现BUG.
    formatter.dateFormat = @"yyyy-MM-dd";

    //调用formatter中stringFromDate:方法从date中拿到日期并返回为字符串.
    NSString *date = [formatter stringFromDate:datePicker.date];
    self.text = date;

}
@end
