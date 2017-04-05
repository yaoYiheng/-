/*
 
 如何使用:
 当拿到来自服务器的plist文件, 需要通过字典来创建相关模型对象时, 
 通过调用该分类方法, 迅速根据字典key生成相关属性.
 然后复制到模型的头文件中, 避免重复切换创建.
 
 */

#import <Foundation/Foundation.h>

@interface NSDictionary (Property)

- (void)createPropertyCode;

@end
