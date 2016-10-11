//
//  ViewController.m
//  16_10_11_简单音乐播放器
//
//  Created by 姚懿恒 on 2016/10/11.
//  Copyright © 2016年 姚懿恒. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()
/** 播放器*/
@property (nonatomic, strong) AVPlayer *player;

@property (weak, nonatomic) IBOutlet UIButton *playButton;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:_backgroundImageView.bounds];

    toolBar.barStyle = UIBarStyleBlack;
    toolBar.alpha = 0.9;
    [_backgroundImageView addSubview:toolBar];

    //返回想要播放的歌曲的路径
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"mySong3.mp3" withExtension:nil];
    //创建播放项目, 并传入播放路径
    AVPlayerItem *playerItem = [[AVPlayerItem alloc] initWithURL:url];

    //创建播放器
    _player = [[AVPlayer alloc] initWithPlayerItem:playerItem];
}

- (IBAction)playOrPause:(UIButton *)sender {


    [self.player play];

}

- (IBAction)preOrNext:(UIButton *)sender {

    NSString *title = nil;
    switch (sender.tag) {
        case 1:
            title = @"mySong1.mp3";
            break;
        case 2:
            title = @"mySong2.mp3";
            break;

        default:
            break;
    }

    NSURL *url = [[NSBundle mainBundle] URLForResource:title withExtension:nil];
    AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:url];
    [_player replaceCurrentItemWithPlayerItem:item];
}


@end
