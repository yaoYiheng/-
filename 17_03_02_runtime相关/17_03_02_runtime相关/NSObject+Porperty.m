//
//  NSObject+Porperty.m
//  17_03_02_runtime相关
//
//  Created by 姚懿恒 on 2017/3/4.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "NSObject+Porperty.h"
#import <objc/message.h>

@implementation NSObject (Porperty)

- (void)setName:(NSString *)name{

    /*
     让传入的对象与当前需要添加属性的类产生关联.
      object:给哪个对象添加属性
      key:属性名称
      value:属性值
      policy:保存策略
     */
    objc_setAssociatedObject(self, "name", name, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

}
- (NSString *)name{

    return objc_getAssociatedObject(self, "name");

}

@end
