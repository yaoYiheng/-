/*
    文件相关操作.
 */

#import <Foundation/Foundation.h>

@interface YYHFileTools : NSObject

/**
 获取给定文件路径下所有文件大小

 @param DirectoryPath 文件夹路径

 */
+ (void)fileSizeForDirectory:(NSString *)DirectoryPath completion:(void(^)(NSInteger totalSize))completion;


/**
 删除给定文件夹下所有文件

 @param DirectoryPath 文件夹路径
 */
+ (void)removeItemAtDirectoryPath:(NSString *)DirectoryPath;
@end
