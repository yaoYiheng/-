//
//  YYHTextField.m
//  17_03_16_Budejie
//
//  Created by 姚懿恒 on 2017/3/25.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "YYHTextField.h"

@implementation YYHTextField

/*
 待解决的问题:
 1. 想要修改光标颜色为白色  在awakeFromNib方法中设置tintColor的颜色即可 ✔️

 2. 点击到对应的textField时, 占位符变成白色.

    问题一解决思路: 有多个textField同时存在, 除了考虑对每一个单独进行设置以外,
 应该考虑的方法为自定义textField进行统一设置->自定义textField -> 关于颜色的设置只需要
 设置一次即可,在awakeFromNib方法中设置tintColor的颜色即可修改光标颜色.->到xib文件中
 绑定UITextField类型为自定义类型.
 
    问题二解决思路: 当文本框进入编辑状态时, 修改占位文字的颜色.需要对文本框的状态进行监听, 监听的
 方式有: 代理 通知 addTarget.
        代理: 不适合自己监听自己, 虽然可以做到, 但考虑到之后该文本框也可能会被被外界监听设置代理, 此处设置代理的方法就会失效. 注意点: 在开发中, 不要自己成为自己的代理.
        通知: 一对多用到通知,而且需要移除, 较麻烦.
        这里选择最简单的addTarget

 */
- (void)awakeFromNib{
    [super awakeFromNib];
    self.tintColor = [UIColor whiteColor];

    //监听文本框的状态
    [self addTarget:self action:@selector(becomeEdting) forControlEvents:UIControlEventEditingDidBegin];

    [self addTarget:self action:@selector(finishEdting) forControlEvents:UIControlEventEditingDidEnd];
}

- (void)becomeEdting{

    NSMutableDictionary *attrDict = [NSMutableDictionary dictionary];
    attrDict[NSForegroundColorAttributeName] = [UIColor whiteColor];
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:self.placeholder attributes:attrDict];
    //更改placeHolder的富文本属性.
    self.attributedPlaceholder = attrString;
}

- (void)finishEdting{
    NSMutableDictionary *attrDict = [NSMutableDictionary dictionary];
    attrDict[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:self.placeholder attributes:attrDict];
    self.attributedPlaceholder = attrString;

}
@end
