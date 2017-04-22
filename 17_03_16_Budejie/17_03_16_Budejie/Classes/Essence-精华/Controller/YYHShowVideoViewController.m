//
//  YYHShowVideoViewController.m
//  17_03_16_Budejie
//
//  Created by 姚懿恒 on 2017/4/22.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "YYHShowVideoViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

@interface YYHShowVideoViewController ()

/** <#comments#>*/
@property (nonatomic, weak) AVPlayer *player;

/** <#comments#>*/
@property (nonatomic, weak) AVPlayerLayer *playerLayer;
@property (weak, nonatomic) IBOutlet UIView *placeHolder;

@end

@implementation YYHShowVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self playVideo];
}

- (IBAction)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)playVideo{

    NSURL *sourceMovieURL = [NSURL URLWithString:self.topic.videouri];

    AVAsset *movieAsset = [AVURLAsset URLAssetWithURL:sourceMovieURL options:nil];

    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:movieAsset];

    AVPlayer *player = [AVPlayer playerWithPlayerItem:playerItem];
    self.player = player;

    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
    self.playerLayer = playerLayer;

    NSLog(@"%ld", self.topic.height);

    NSLog(@"%ld", self.topic.width);
    NSLog(@"%d", playerLayer.isReadyForDisplay);
    CGFloat width = YYhScreenW;
    CGFloat height = self.topic.height * width / self.topic.width;

    CGRect size = playerLayer.frame;
    size = CGRectMake(0, 0, width, height);
    playerLayer.frame = size;




    /*
     
     @constant		AVLayerVideoGravityResizeAspect
     @abstract		Preserve aspect ratio; fit within layer bounds.
     @discussion		AVLayerVideoGravityResizeAspect may be used when setting the videoGravity
     property of an AVPlayerLayer or AVCaptureVideoPreviewLayer instance.

     //保存宽高比, 已合适的比例出现在被添加的view中
    AVF_EXPORT NSString *const AVLayerVideoGravityResizeAspect NS_AVAILABLE(10_7, 4_0);



     @constant		AVLayerVideoGravityResizeAspectFill
     @abstract		Preserve aspect ratio; fill layer bounds.
     @discussion     AVLayerVideoGravityResizeAspectFill may be used when setting the videoGravity
     property of an AVPlayerLayer or AVCaptureVideoPreviewLayer instance.
     //保持原有宽高比, 填充父view
    AVF_EXPORT NSString *const AVLayerVideoGravityResizeAspectFill NS_AVAILABLE(10_7, 4_0);

     @constant		AVLayerVideoGravityResize
     @abstract		Stretch to fill layer bounds.
     @discussion     AVLayerVideoGravityResize may be used when setting the videoGravity
     property of an AVPlayerLayer or AVCaptureVideoPreviewLayer instance.
     
     //拉伸并填充父view
    AVF_EXPORT NSString *const AVLayerVideoGravityResize NS_AVAILABLE(10_7, 4_0);
     */
    playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;

    [self.placeHolder.layer addSublayer:playerLayer];
    
    [player play];

}

/**
 控制播放与暂停
 */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{



//    if (self.player.rate == 0) {
//        self.player.rate = 1;
//    }else{
//    self.player.rate = 0;
//    }
    self.player.rate = self.player.rate == 0?1:0;
}
@end
