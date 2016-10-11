//
//  ViewController.m
//  16_10_11_拳皇动画及音效加载
//
//  Created by 姚懿恒 on 2016/10/11.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController (){
    NSDictionary *_dict;
}
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

/** 站立数组*/
@property (nonatomic, strong) NSArray *stand;

/** 小招数组*/
@property (nonatomic, strong) NSArray *xiaozhao;

/** 大招数组*/
@property (nonatomic, strong) NSArray *dazhao;
@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *path = [bundle pathForResource:@"Property List" ofType:@"plist"];
    _dict = [NSDictionary dictionaryWithContentsOfFile:path];

    [self loadAllImagesToArray];

    // Do any additional setup after loading the view, typically from a nib.

}

-(void)loadAllImagesToArray{
    _stand = [self loadAllImagesWithimagePrefix:@"stand" count:10];
    _xiaozhao = [self loadAllImagesWithimagePrefix:@"xiaozhao3" count:39];
    _dazhao = [self loadAllImagesWithimagePrefix:@"dazhao" count:87];
}


#pragma mark 加载图片文件
- (NSArray *)loadAllImagesWithimagePrefix:(NSString *)imagePrefix count:(int)count{

    NSMutableArray<UIImage *> *images = [NSMutableArray array];
    for (int i = 0; i < count; i++) {
//        NSString *imageName = [NSString stringWithFormat:@"%@_%d",imagePrefix, i+1];
        NSString *picName = [NSString stringWithFormat:@"%@_%d.png", imagePrefix, i +1];

        NSString *imagePath = [[NSBundle mainBundle] pathForResource:picName ofType:nil];
        UIImage *image = [[UIImage alloc] initWithContentsOfFile:imagePath];

        [images addObject:image];
    }

    return images;
}
- (IBAction)function:(UIButton *)sender {


    NSString *functionName = [sender titleForState:UIControlStateNormal];
    int count = [_dict[functionName] intValue];
    NSLog(@"%@, %d",functionName, count);

    NSArray *images = [self loadAllImagesWithimagePrefix: functionName count:count];
//    self.imageView.animationImages = [self loadAllImagesWithimagePrefix: functionName count:count];

    self.imageView.animationImages = images;

    self.imageView.animationDuration = 0.1 * count;
    self.imageView.animationRepeatCount = 1;
    [self.imageView startAnimating];

}



@end
