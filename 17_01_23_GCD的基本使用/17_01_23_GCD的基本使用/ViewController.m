//
//  ViewController.m
//  17_01_23_GCD的基本使用
//
//  Created by 姚懿恒 on 2017/1/23.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

/** 图片1*/
@property (nonatomic, strong) UIImage *image1;

/** 图片2*/
@property (nonatomic, strong) UIImage *image2;

@end

@implementation ViewController

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self downloadWithGCDGroup];

}

/**
 在队列组中完成
 */
- (void)downloadWithGCDGroup{
    //0. 获取队列组

    dispatch_group_t group = dispatch_group_create();
    //1. 获取并发队列
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);

    //2. 调用队列组开启子线程下载图片
        //获取图片1
    dispatch_group_async(group, queue, ^{
        //2.1 获取图片url

        NSLog(@"%@", [NSThread currentThread]);
        NSURL *url = [NSURL URLWithString:@"http://pic.wenwen.soso.com/p/20110708/20110708210904-899747265.jpg"];
        //2.2 下载二进制数据到NSData
        NSData *imageData = [NSData dataWithContentsOfURL:url];

        //2.3 从data中获得图片
        self.image1 = [UIImage imageWithData:imageData];

    });
        //获取图片2
    dispatch_group_async(group, queue, ^{
        //2.1 获取图片url
        NSLog(@"%@", [NSThread currentThread]);
        NSURL *url = [NSURL URLWithString:@"http://www.ylmfupan.com/zhuti/UploadPic/2013-8/2013819104526645.jpg"];
        //2.2 下载二进制数据到NSData
        NSData *imageData = [NSData dataWithContentsOfURL:url];

        //2.3 从data中获得图片
        self.image2 = [UIImage imageWithData:imageData];
        
    });

    //3. 合并图片(在图片下载完成后)
    //等待.死等. 直到队列组中所有的任务都执行完毕之后才能执行
    //dispatch_group_wait 是阻塞的
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
        //3.1 开启图形上下文
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, NO, 0.0);

        //3.2 绘制图片到上下文
    [self.image1 drawInRect:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height / 2)];
    self.image1 = nil;

    [self.image2 drawInRect:CGRectMake(0, self.view.bounds.size.height / 2, self.view.bounds.size.width, self.view.bounds.size.height / 2)];
    self.image2 = nil;

        //3.3 获取新图片
    UIImage *combieImage = UIGraphicsGetImageFromCurrentImageContext();

        //3.4 关闭图形上下文
    UIGraphicsEndImageContext();


        //3.4 更新UI(需到主线程)
//    [self.imageView performSelectorOnMainThread:@selector(setImage:) withObject:combieImage waitUntilDone:NO];

    //回到主线程更新image.
    dispatch_group_async(group, dispatch_get_main_queue(), ^{
        self.imageView.image = combieImage;
        NSLog(@"%@", [NSThread currentThread]);
    });
}
/**
 使用快速迭代移动文件
 */
- (void)moveFileWithGCD{
    //1. 获取起点路径
    NSString *from = @"/Users/Morris/Desktop/From";
    //2. 获取终点路径
    NSString *to = @"/Users/Morris/Desktop/To";
    //3. 得到起点路径下所有文件的路径
    NSArray *allFilePath = [[NSFileManager defaultManager] subpathsAtPath:from];
    //4. 执行移动操作
    NSInteger count = allFilePath.count;
    dispatch_apply(count, dispatch_get_global_queue(0, 0), ^(size_t index) {
        //拼接 要剪切的文件全路径
        NSString *fromFile = [from stringByAppendingPathComponent:allFilePath[index]];
        //拼接 文件保存的全路径
        NSString *toFile = [to stringByAppendingPathComponent:allFilePath[index]];
        //调用该方法 将文件从某路径移动待指定路径
        [[NSFileManager defaultManager] moveItemAtPath:fromFile toPath:toFile error:nil];

        NSLog(@"%@----%ld", [NSThread currentThread], index);
    });

}

/**
 普通方法移动文件
 */
- (void)moveFileDemo{
    //1. 获取起点路径
    NSString *from = @"/Users/Morris/Desktop/From";
    //2. 获取终点路径
    NSString *to = @"/Users/Morris/Desktop/To";
    //3. 得到起点路径下所有文件的路径
    NSArray *allFilePath = [[NSFileManager defaultManager] subpathsAtPath:from];
    //4. 执行移动操作
    for (NSString *eachFilePath in allFilePath) {
        //[string stringByAppendingPathComponent:]调用该方法拼接路径, 会自定加上 / .
        //拼接 要剪切的文件全路径
        NSString *fromFile = [from stringByAppendingPathComponent:eachFilePath];
        //拼接 文件保存的全路径
        NSString *toFile = [to stringByAppendingPathComponent:eachFilePath];

        //调用该方法 将文件从某路径移动待指定路径
        [[NSFileManager defaultManager] moveItemAtPath:fromFile toPath:toFile error:nil];
        NSLog(@"%@", [NSThread currentThread]);
    }
}

/**
 快速迭代: 内部会开启子线程(并和主线程), 异步并发的来执行这些任务
 */
- (void)applyDemo{
    /**
     参数一: 迭代的次数
     参数二: 队列(必须是并发队列)
     参数三: 索引
     */
    dispatch_apply(50, dispatch_get_global_queue(0, 0), ^(size_t index) {
        NSLog(@"%zu ---- %@ ", index, [NSThread currentThread]);
    });
}

/**
通过栅栏函数, 控制并发队列的任务的执行顺序
 
 */
- (void)barrier{
    //0. 获取并发队列,
    //注意. 栅栏函数不能使用全局并发队列
//    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);

    dispatch_queue_t queue = dispatch_queue_create("task", DISPATCH_QUEUE_CONCURRENT);

    //1. 调用异步函数
    dispatch_async(queue, ^{
        NSLog(@"test --- 1 %@",[NSThread currentThread]);
    });

    dispatch_async(queue, ^{
        NSLog(@"test --- 2 %@",[NSThread currentThread]);
    });

    //调用栅栏函数

    dispatch_barrier_async(queue, ^{
        NSLog(@"+++++++++");
    });
    dispatch_async(queue, ^{
        NSLog(@"test --- 3 %@",[NSThread currentThread]);
    });


}

/**
 一次性代码:整个应用程序只会执行一次.
 不能用在懒加载中, 
 一般会应用在单例模式中
 */
- (void)once{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSLog(@"once");
    });

}
/**
 延迟执行任务的几种方法.
 */
- (void)delay{
    //1.方法一
    [self performSelector:@selector(task) withObject:nil afterDelay:2.0];

    //2.方法二
//    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(task) userInfo:nil repeats:YES];

    /*
     
     以上两种方法, 只能在主线程中执行
     */

    //3.方法三.GCD延迟
    /**
     dispatch_after() DISPATCH_TIME_NOW 从现在开始计算时间,
     NSEC_PER_SEC 可精确到纳秒.
     可传入一个队列, 决定任务是否在子线程中进行.
     
     **/
    //获取全局并发队列.

    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), queue, ^{
        [self task];
    });
    //2017-01-25 23:31:46.381 17_01_23_GCD的基本使用[30552:1460904] -[ViewController task], <NSThread: 0x608000073d80>{number = 3, name = (null)}

}

- (void)task{
    NSLog(@"%s, %@", __func__, [NSThread currentThread]);
}
- (void)downLoad{
    /**
     1. 创建子线程调用异步函数, 可进行嵌套, 传入dispatch_get_global_queue(0, 0), 获取全局队列
     并在队列中封装任务
    */

    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"%@", [NSThread currentThread]);
        //从网络获取图片URL
        NSURL *url = [NSURL URLWithString:@"http://www.ylmfupan.com/zhuti/UploadPic/2013-8/2013819104526645.jpg"];

        //将URL转为DATA
        NSData *imageData = [NSData dataWithContentsOfURL:url];

        //从DATA中加载图片
        UIImage *image = [UIImage imageWithData:imageData];

//        self.imageView.image = image;

        //调用该方法, 也可以实现.
//        [self.imageView performSelectorOnMainThread:@selector(setImage:) withObject:image waitUntilDone:YES];

        CFTimeInterval start = CFAbsoluteTimeGetCurrent();

        //调用异步函数, 回到主队列, 进行UI的刷新.
        dispatch_async(dispatch_get_main_queue(), ^{

            self.imageView.image = image;
            NSLog(@"%@", [NSThread currentThread]);
        });
        CFTimeInterval end = CFAbsoluteTimeGetCurrent();
        NSLog(@"%f", end - start);
    });
}




/**
 异步函数(dispatch_async) + 并发队列(DISPATCH_QUEUE_CONCURRENT):会开启多条线程,队列中的任务是并发执行
 */
-(void)asyncConcurrent{
    //1. 创建队列
    /**
     调用该函数创建一个并发队列.
     第一个参数传入一个字符串, 作为标识.
     第二个参数 可传   DISPATCH_QUEUE_CONCURRENT  并发
                    DISPATCH_QUEUE_SERIAL      串行
     */
//    dispatch_queue_t queue = dispatch_queue_create("printSomething", DISPATCH_QUEUE_CONCURRENT);


    //获得全局并发队列 dispatch_get_global_queue()
    /*
     第一个参数:优先级
     DISPATCH_QUEUE_PRIORITY_HIGH 2
     DISPATCH_QUEUE_PRIORITY_DEFAULT 0
     DISPATCH_QUEUE_PRIORITY_LOW (-2)
     DISPATCH_QUEUE_PRIORITY_BACKGROUND INT16_MIN

     第二个参数:传0即可, 供将来使用
     
     Return : The requested global concurrent queue.
     */
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //2. 调用异步函数,dispatch_async()
    /**
     参数一: 之前创建的队列
     参数二: 需要执行的方法(封装任务)
     */
    dispatch_async(queue, ^{
        NSLog(@"task1----%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"task2----%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"task3----%@", [NSThread currentThread]);
    });


    /**
     
     2017-01-23 20:28:33.270 17_01_23_GCD的基本使用[26439:1280510] task1----<NSThread: 0x600000265300>{number = 3, name = (null)}
     2017-01-23 20:28:33.270 17_01_23_GCD的基本使用[26439:1280512] task3----<NSThread: 0x608000263bc0>{number = 5, name = (null)}
     2017-01-23 20:28:33.270 17_01_23_GCD的基本使用[26439:1280509] task2----<NSThread: 0x6080002643c0>{number = 4, name = (null)}
     
     */
}

/**
 异步函数(dispatch_async)+串行队列(DISPATCH_QUEUE_SERIAL):会开线程,开一条线程,队列中的任务是串行执行的
 */
-(void)asyncSerial{
    dispatch_queue_t queue = dispatch_queue_create("printSomething", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        NSLog(@"task1----%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"task2----%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"task3----%@", [NSThread currentThread]);
    });


    /**
     
     2017-01-23 20:27:54.791 17_01_23_GCD的基本使用[26417:1279777] task1----<NSThread: 0x60800007fcc0>{number = 3, name = (null)}
     2017-01-23 20:27:54.791 17_01_23_GCD的基本使用[26417:1279777] task2----<NSThread: 0x60800007fcc0>{number = 3, name = (null)}
     2017-01-23 20:27:54.791 17_01_23_GCD的基本使用[26417:1279777] task3----<NSThread: 0x60800007fcc0>{number = 3, name = (null)}
     */
}

/**同步函数(dispatch_sync)+并发队列(DISPATCH_QUEUE_CONCURRENT):不会开线程,任务是串行执行的
 */
-(void)syncConcurrent{
    dispatch_queue_t queue = dispatch_queue_create("printSomething", DISPATCH_QUEUE_CONCURRENT);

    dispatch_sync(queue, ^{
        NSLog(@"task1----%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"task2----%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"task3----%@", [NSThread currentThread]);
    });
}

/**同步函数(dispatch_sync)+串行队列(DISPATCH_QUEUE_SERIAL):不会开线程,任务是串行执行的*/
-(void)syncSerial{
    dispatch_queue_t queue = dispatch_queue_create("printSomething", DISPATCH_QUEUE_SERIAL);
    dispatch_sync(queue, ^{
        NSLog(@"task1----%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"task2----%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"task3----%@", [NSThread currentThread]);
    });
}


/**异步函数 + 主队列*/
- (void)asyncMain{

    //通过该函数获得主队列
    //主队列的任务必须在主线程中完成
    dispatch_queue_t queue = dispatch_get_main_queue();

    //将要执行的任务封装到主队列中
    dispatch_async(queue, ^{
        NSLog(@"task1----%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"task2----%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"task3----%@", [NSThread currentThread]);
    });

    /**
     number = 1, 执行任务的线程为主线程.
     
     2017-01-24 22:47:08.561 17_01_23_GCD的基本使用[28311:1365030] task1----<NSThread: 0x60800006bec0>{number = 1, name = main}
     2017-01-24 22:47:08.562 17_01_23_GCD的基本使用[28311:1365030] task2----<NSThread: 0x60800006bec0>{number = 1, name = main}
     2017-01-24 22:47:08.562 17_01_23_GCD的基本使用[28311:1365030] task3----<NSThread: 0x60800006bec0>{number = 1, name = main}
     
     */

}

- (void)syncMain{
    //通过该函数获得主队列
    //主队列的任务必须在主线程中完成
    /**

     
     同步函数: 当前没有执行完, 就不能继续执行之后的代码.
     异步函数: 当前没有执行完, 也可以继续执行之后的代码.

     如果在主线程中调用同步 函数 + 主队列 的组合
     这样会造成死锁.
     原因: 同步函数 任务串行执行, 而任务被分配在主线程中, 而主线程在执行syncMain(当前任务)
     (任务A的开始的前提是任务A结束?)不知是不是这样理解,

     为了解决这个问题, 可以将该任务的执行放到子线程中.

     
     */
    dispatch_queue_t queue = dispatch_get_main_queue();

    NSLog(@"start --");

    dispatch_sync(queue, ^{
        NSLog(@"task1----%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"task2----%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"task3----%@", [NSThread currentThread]);
    });
    NSLog(@"end---");
    /**
     2017-01-24 22:51:14.464 17_01_23_GCD的基本使用[28372:1368401] start --
     (lldb)

    */


}
@end
