//
//  ViewController.m
//  17_01_22_线程之间的通信
//
//  Created by 姚懿恒 on 2017/1/22.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

//    [self downLoad];


    [NSThread detachNewThreadSelector:@selector(downLoad1) toTarget:self withObject:nil];
}

/**
 在主线程中完成下载图片以及显示图片的任务.
 */
- (void)downLoad{

    NSLog(@"%@", [NSThread currentThread]);
    //从网络获取图片URL
    NSURL *url = [NSURL URLWithString:@"http://www.ylmfupan.com/zhuti/UploadPic/2013-8/2013819104526645.jpg"];

    //获取绝对时间.(开始)
    CFTimeInterval start = CFAbsoluteTimeGetCurrent();
    NSData *imageData = [NSData dataWithContentsOfURL:url];
    //获取绝对时间.(结束)
    CFTimeInterval end = CFAbsoluteTimeGetCurrent();
    //可以知道该方法执行了多久.
    NSLog(@"%f", end - start);
    UIImage *image = [UIImage imageWithData:imageData];

    self.imageView.image = image;

}

/**
 开启子线程下载图片, 回主线程刷新UI
 */
- (void)downLoad1{

    //获取绝对时间.(开始)
    CFTimeInterval start = CFAbsoluteTimeGetCurrent();
    //从网络获取图片URL
    NSURL *url = [NSURL URLWithString:@"http://www.ylmfupan.com/zhuti/UploadPic/2013-8/2013819104526645.jpg"];

    //将URL转为DATA
    NSData *imageData = [NSData dataWithContentsOfURL:url];

    //获取绝对时间.(结束)
    CFTimeInterval end = CFAbsoluteTimeGetCurrent();

    //可以知道该方法执行了多久.
    NSLog(@"%f", end - start);
    //从DATA中加载图片
    UIImage *image = [UIImage imageWithData:imageData];

    //回到主线程显示UI
    /*
     第一个参数:回到主线程要调用哪个方法
     第二个参数:前面方法需要传递的参数 此处就是image
     第三个参数:是否等待
     */

    //回到主线程方法.
//    [self performSelectorOnMainThread:@selector(showImage:) withObject:image waitUntilDone:NO];

    //回到指定线程的方法, 这里也是回到主线程
    [self performSelector:@selector(showImage:) onThread:[NSThread mainThread] withObject:image waitUntilDone:NO];


    /**
     
     NSObject (NSThreadPerformAdditions)

     - (void)performSelectorOnMainThread:(SEL)aSelector withObject:(nullable id)arg waitUntilDone:(BOOL)wait modes:(nullable NSArray<NSString *> *)array;
     - (void)performSelectorOnMainThread:(SEL)aSelector withObject:(nullable id)arg waitUntilDone:(BOOL)wait;
     // equivalent to the first method with kCFRunLoopCommonModes

     - (void)performSelector:(SEL)aSelector onThread:(NSThread *)thr withObject:(nullable id)arg waitUntilDone:(BOOL)wait modes:(nullable NSArray<NSString *> *)array NS_AVAILABLE(10_5, 2_0);
     - (void)performSelector:(SEL)aSelector onThread:(NSThread *)thr withObject:(nullable id)arg waitUntilDone:(BOOL)wait NS_AVAILABLE(10_5, 2_0);
     // equivalent to the first method with kCFRunLoopCommonModes
     - (void)performSelectorInBackground:(SEL)aSelector withObject:(nullable id)arg NS_AVAILABLE(10_5, 2_0);

     以上这些方法都是给NSObject写的分类方法, 也就是说任何继承了该基类的类都拥有这些方法.
     
     */

    //这里直接调用imageView的 setImage: 方法, 这样可以少写一步实现刷新的方法.
    [self.imageView performSelector:@selector(setImage:) onThread:[NSThread mainThread] withObject:image waitUntilDone:YES];


    NSLog(@"来到了该方法的最后 ");



}
- (void)showImage:(UIImage *) image{

    self.imageView.image = image;
}
@end
