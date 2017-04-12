//
//  UIImageView+YYHDownImage.h
//  17_03_16_Budejie
//
//  Created by 姚懿恒 on 2017/4/12.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (YYHDownImage)

- (void)yyh_setOriginalImageWithURL:(NSString *)originalURL thumbmailImageWithURL: (NSString *)thumbmailURL placeHolderImage: (UIImage *)placeHolder completed:(void(^)(UIImage *image))completed;


@end
