//
//  ViewController.m
//  16_10_16_05_通过xib自定义View
//
//  Created by 姚懿恒 on 2016/10/16.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "ViewController.h"
#import "YHItemView.h"
#import "YHItems.h"

@interface ViewController (){
    NSArray *_allItems;
}


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    NSString *path = [[NSBundle mainBundle] pathForResource:@"product.plist" ofType:nil];
    _allItems = [NSArray arrayWithContentsOfFile:path];
    YHItemView *itemView = [YHItemView items];
    YHItems *item = [YHItems itemWithDictionary:_allItems[0]];
    itemView.items = item;
    [self.view addSubview:itemView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
