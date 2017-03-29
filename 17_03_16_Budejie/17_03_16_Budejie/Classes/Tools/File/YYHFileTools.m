

#import "YYHFileTools.h"

@implementation YYHFileTools

+ (void)fileSizeForDirectory:(NSString *)DirectoryPath completion:(void(^)(NSInteger totalSize))completion{


    //. 使用文件管理者
    NSFileManager *fileManger = [NSFileManager defaultManager];

    BOOL isDirectory;
    BOOL isExist = [fileManger fileExistsAtPath:DirectoryPath isDirectory:&isDirectory];

    //如果文件夹不存在或不是一个文件就抛出异常.
    if (!isExist || !isDirectory) {
        NSException *excetion = [NSException exceptionWithName:@"PathError" reason:@"Passing with a right DirectoryPath" userInfo:nil];
        [excetion raise];
    }


    dispatch_async(dispatch_get_global_queue(0, 0), ^{

        //拿到缓存文件夹下, 所有子文件的路径
        NSArray *subPathArray = [fileManger subpathsAtPath:DirectoryPath];

        NSInteger totalSize = 0;

        for (NSString *filePath in subPathArray) {
            //拼接路径
            NSString *fileFullPath = [DirectoryPath stringByAppendingPathComponent:filePath];

            //判断是否为隐藏文件
            if([fileFullPath containsString:@".DS"]) continue;

            BOOL isDirectory;
            BOOL isExist = [fileManger fileExistsAtPath:fileFullPath isDirectory:&isDirectory];

            //如果是文件夹或文件不存在, 不计算
            if (isDirectory || !isExist) continue;

            //通过文件管理者拿到对应文件的属性
            NSDictionary *fileDict = [[NSFileManager defaultManager] attributesOfItemAtPath:fileFullPath error:nil];
            //通过@"NSFileSize"拿到每一个文件的大小.
            totalSize =totalSize + [fileDict[@"NSFileSize"] floatValue];
        }
        //当计算完成时, 回到主线程完成回调
        dispatch_sync(dispatch_get_main_queue(), ^{
            if (completion) {
                completion(totalSize);
            }
        });


    });



}
+ (void)removeItemAtDirectoryPath:(NSString *)DirectoryPath{
    NSFileManager *fileManger = [NSFileManager defaultManager];

    BOOL isDirectory;
    BOOL isExist = [fileManger fileExistsAtPath:DirectoryPath isDirectory:&isDirectory];

    //如果文件夹不存在或不是一个文件就抛出异常.
    if (!isExist || !isDirectory) {
        NSException *excetion = [NSException exceptionWithName:@"PathError" reason:@"Passing with a right DirectoryPath" userInfo:nil];
        [excetion raise];
    }
    //拿到缓存文件夹下, 所有子文件的路径
    NSArray *subPathArray = [fileManger subpathsAtPath:DirectoryPath];

    for (NSString *filePath in subPathArray) {
        //拼接路径
        NSString *fileFullPath = [DirectoryPath stringByAppendingPathComponent:filePath];

        [fileManger removeItemAtPath:fileFullPath error:nil];

    }
    
}
@end
