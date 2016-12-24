//
//  YHImageView.m
//  16_12_24_模仿系统UIImageView
//
//  Created by 姚懿恒 on 2016/12/24.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "YHImageView.h"

@implementation YHImageView
- (instancetype)initWithImage:(UIImage *)image{
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, image.size.width, image.size.height);
        _image = image;
    }
    return self;
}

- (void)drawRect:(CGRect)rect{

    [self.image drawInRect:rect];

}
- (void)setImage:(UIImage *)image{
    _image = image;
    [self setNeedsDisplay];
}

@end
