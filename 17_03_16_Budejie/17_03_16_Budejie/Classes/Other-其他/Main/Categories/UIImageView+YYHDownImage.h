//
//  UIImageView+YYHDownImage.h
//  17_03_16_Budejie
//
//  Created by 姚懿恒 on 2017/4/12.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIImageView+WebCache.h>

/*
 void(^)(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
 */
@interface UIImageView (YYHDownImage)

- (void)yyh_setOriginalImageWithURL:(NSString *)originalURL thumbmailImageWithURL: (NSString *)thumbmailURL placeHolderImage: (UIImage *)placeHolder completed:(SDExternalCompletionBlock)completedBlock;


@end
