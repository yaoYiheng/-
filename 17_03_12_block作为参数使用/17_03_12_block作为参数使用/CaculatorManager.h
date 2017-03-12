//
//  CaculatorManager.h
//  17_03_12_block作为参数使用
//
//  Created by 姚懿恒 on 2017/3/12.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NSInteger(^test)(NSInteger result);
@interface CaculatorManager : NSObject

/** <#comments#>*/
@property (nonatomic, assign) NSInteger result;

/** <#comments#>*/
@property (nonatomic, strong) NSString *returnedString;

/** <#comments#>*/
@property (nonatomic, assign) int myInt;
//- (void)test:(NSString *)parameter;
//(返回值类型)方法名:(参数类型)参数名;
- (void)caculate:(NSInteger(^)(NSInteger result))caculatorBlock;
//使用typedef
//- (void)caculate:(test)caculatorBlock;
- (void)returnAString:(NSString *(^)(NSString *str1, NSString *str2))newString;


@end
