//
//  YHImageView.h
//  16_12_24_模仿系统UIImageView
//
//  Created by 姚懿恒 on 2016/12/24.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YHImageView : UIView
/** <#comments#>*/
@property (nonatomic, strong) UIImage *image;

- (instancetype)initWithImage:(UIImage *) image;

@end
