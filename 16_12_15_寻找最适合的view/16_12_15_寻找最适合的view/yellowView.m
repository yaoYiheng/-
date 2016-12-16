//
//  yellowView.m
//  16_12_15_寻找最适合的view
//
//  Created by 姚懿恒 on 2016/12/15.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "yellowView.h"

@interface yellowView ()
@property (nonatomic, weak) IBOutlet UIButton *blueButton;

@end

@implementation yellowView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    CGPoint blueButtonPoint = [self convertPoint:point toView:self.blueButton];
    if ([self.blueButton pointInside:blueButtonPoint withEvent:event]) {
        return self.blueButton;
    }
    else{

        return [super hitTest:point withEvent:event];
    }
}


@end
