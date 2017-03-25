//
//  YYHTextField.m
//  17_03_16_Budejie
//
//  Created by 姚懿恒 on 2017/3/25.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "YYHTextField.h"
#import "UITextField+YYHPlaceHolderColor.h"

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
 
 
    -------------------
 
    想要做到直接设置占位文字的颜色, self.placeHolderColor = [UIColor redColor];
    而不是写一大段代码 ->为UITextField添加分类 -> 考虑到UITextField的文字类型?->通过断点查看->
    其类型为UITextFieldLabel *_placeholderLabel -> 可以通过KVC拿到该Label对其textColor赋值->
    UILabel * textLabel = [self valueForKey:@"placeholderLabel"]; -> 

    到此处, 以实现能够通过 self.placeHolderColor为占位文字赋值的功能, 
    但是该功能有bug, 必须先设置占位文字, 再设置占位文字颜色才能成功实现该方法, 
    倘若先设置占位文字颜色, 再设置占位文字, 则不能实现.
 
     //设置占位文字颜色
     testField.placeHolderColor = [UIColor redColr];

    //当设置占位文字后, 在修改文字颜色, -> 想要的效果是, 当调用(系统的)placeHolder方法时,设置文字后, 在设置文字颜色 -> 修改系统的方法实现 ->runtime交换方法 -> 只需交换一次, 在load方法中实现.
    testField.placeHolder = @"test"; -> 提供一个方法(yyh_setPlaceHolder:)用于交换系统的setPlaceHolder:, 该方法需要实现setPlaceHolder: 与setPlaceHolderColor
 

    
    以上两句调换位置, 则无法设置, 原因在于系统的控件都是懒加载机制, 在未设置文字时, 占位Label为nil
    
 解决思路: 在调用testField.placeHolderColor的set方法时, 先将传进来的颜色保存起来, 等到Label不为nil时, 再进行赋值操作 -> 将颜色保存在哪里?-> 成员变量中 -> 为系统的类添加成员变量 ->不得不用到runtime.    //为当前类设置关联一个属性
            objc_setAssociatedObject(self, "placeHolderColor", placeHolderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
 -  ->


 */
- (void)awakeFromNib{
    [super awakeFromNib];
    self.tintColor = [UIColor whiteColor];

    //监听文本框的状态
    [self addTarget:self action:@selector(becomeEdting) forControlEvents:UIControlEventEditingDidBegin];

    [self addTarget:self action:@selector(finishEdting) forControlEvents:UIControlEventEditingDidEnd];

//    NSMutableDictionary *attrDict = [NSMutableDictionary dictionary];
//    attrDict[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
//    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:self.placeholder attributes:attrDict];
//    self.attributedPlaceholder = attrString;
    self.placeHolderColor = [UIColor lightGrayColor];
}

- (void)becomeEdting{

//    NSMutableDictionary *attrDict = [NSMutableDictionary dictionary];
//    attrDict[NSForegroundColorAttributeName] = [UIColor whiteColor];
//    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:self.placeholder attributes:attrDict];
//    //更改placeHolder的富文本属性.
//    self.attributedPlaceholder = attrString;
    self.placeHolderColor = [UIColor whiteColor];
}

- (void)finishEdting{
//    NSMutableDictionary *attrDict = [NSMutableDictionary dictionary];
//    attrDict[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
//    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:self.placeholder attributes:attrDict];
//    self.attributedPlaceholder = attrString;
    self.placeHolderColor = [UIColor lightGrayColor];
}
@end
