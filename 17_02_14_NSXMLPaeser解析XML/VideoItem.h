//
//  VideoItem.h
//  17_02_12_复杂JSON解析
//
//  Created by 姚懿恒 on 2017/2/14.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoItem : NSObject
/** ID*/
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *length;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *url;

@end
