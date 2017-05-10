//
//  UITextField+YYHPlaceHolderColor.m
//  17_03_16_Budejie
//
//  Created by 姚懿恒 on 2017/3/25.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "UITextField+YYHPlaceHolderColor.h"
#import <objc/message.h>
@implementation UITextField (YYHPlaceHolderColor)

+ (void)load{
    //来到该方法中实现方法交换

    //拿到系统的placeHolder方法
    Method placeHolder = class_getInstanceMethod(self, @selector(setPlaceholder:));

    //拿到自定义方法
    Method yyh_setPlaceHolder = class_getInstanceMethod(self, @selector(yyh_setPlaceHolder:));
    method_exchangeImplementations(placeHolder, yyh_setPlaceHolder);
}

/**
 在分类中使用属性, 只会生成该属性的set, get方法的声明, 并不会生成其实现以及成员变量,

需要为该分类添加一个成员属性用来保存传进来的值 -> 使用runtime为系统的的类添加成员变量.
 
 思路: UITextField中的文字, 其类型是UILabel类型 UITextFieldLabel *	_placeholderLabel

 */
- (void)setPlaceHolderColor:(UIColor *)placeHolderColor{

    //为系统的类添加成员变量, 用来保存传入的值
    //为当前类设置关联一个属性
    objc_setAssociatedObject(self, "placeHolderColor", placeHolderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);


    UILabel * textLabel = [self valueForKey:@"placeholderLabel"];
    
    textLabel.textColor = placeHolderColor;

}


/**
 通过关联返回已添加的成员变量的值.
 */
- (UIColor *)placeHolderColor{

    return objc_getAssociatedObject(self, "placeHolderColor");
}

//提供一个方法(yyh_setPlaceHolder:)用于交换系统的setPlaceHolder:, 该方法需要实现setPlaceHolder: 与setPlaceHolderColor
- (void)yyh_setPlaceHolder:(NSString *)placeHolder{

    //当实现方法交换后, 调用placeholder, 实际就是调用yyh_setPlaceHolder: 这两个方法会循环调用
//    self.placeholder = placeHolder;
    [self yyh_setPlaceHolder:placeHolder];//调用该方法, 才会去调用setPlaceHolder:方法.
    self.placeHolderColor = self.placeHolderColor;
}
@end
