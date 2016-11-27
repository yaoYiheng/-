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

    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    self.datePicker = datePicker;
    self.inputView = datePicker;
    datePicker.datePickerMode = UIDatePickerModeDate;
    datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
    [datePicker addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];

}
- (void)dateChange:(UIDatePicker *)datePicker{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString *date = [formatter stringFromDate:datePicker.date];
    self.text = date;

}
@end
