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

- (void)setUp{
    UIPickerView *pickerView = [[UIPickerView alloc] init];
    pickerView.delegate = self;
    pickerView.dataSource = self;

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

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    YHFlagView *flagView = [YHFlagView flagView];
    YHFlagItem *items = self.dataArray[row];
    flagView.flagItem = items;

    return flagView;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 118;
}

@end
