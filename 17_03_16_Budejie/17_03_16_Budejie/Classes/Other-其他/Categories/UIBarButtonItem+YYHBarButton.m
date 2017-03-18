//
//  UIBarButtonItem+YYHBarButton.m
//  17_03_16_Budejie
//
//  Created by 姚懿恒 on 2017/3/18.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "UIBarButtonItem+YYHBarButton.h"

@implementation UIBarButtonItem (YYHBarButton)
+ (instancetype)barButtonWithImage:(UIImage *)image hightligtedImage:(UIImage *)highlightedImage Target:(id)target action:(SEL)action{

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:highlightedImage forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    UIView *view = [[UIView alloc] initWithFrame:button.frame];
    [view addSubview:button];
    return [[UIBarButtonItem alloc] initWithCustomView:view];

}

+ (instancetype)barButtonWithImage:(UIImage *)image selectedImage:(UIImage *)selectedImage Target:(id)target action:(SEL)action{

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:selectedImage forState:UIControlStateSelected];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    UIView *view = [[UIView alloc] initWithFrame:button.frame];
    [view addSubview:button];
    return [[UIBarButtonItem alloc] initWithCustomView:view];
    
}

@end
