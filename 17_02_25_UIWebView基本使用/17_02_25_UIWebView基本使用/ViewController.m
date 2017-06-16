//
//  ViewController.m
//  17_02_25_UIWebView基本使用
//
//  Created by 姚懿恒 on 2017/2/25.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goBack;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goForward;

@end

@implementation ViewController

#pragma mark -----UIWebViewDelegate-----
- (void)webViewDidStartLoad:(UIWebView *)webView{

}
-(void)webViewDidFinishLoad:(UIWebView *)webView{

    //能否前进去后退.
    self.goForward.enabled = self.webView.canGoForward;
    self.goBack.enabled = self.webView.canGoBack;
}

/**
 是否应该开始加载
 可在该方法中, 进行简单的字符过滤

 */
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *str = request.URL.absoluteString;
    if ([str containsString:@"baidu"]) {
        return NO;
    }
    return YES;
}
#pragma mark -----buttonClick-----

/**
 后退
 */
- (IBAction)goBack:(id)sender {
    [self.webView goBack];
}

/**
 前进

 */
- (IBAction)goForward:(id)sender {
    [self.webView goForward];
}

/**
 刷新
 */
- (IBAction)refresh:(id)sender {
    [self.webView reload];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self test4];
    self.webView.delegate = self;
}

/**
 为WebView传入一个网址, 可以通过WebView对该网址进行访问.
 */
- (void)test1{

    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://therub.co.nz/shop/"]]];
    //可以修改webView的该属性, 设置自适应
    self.webView.scalesPageToFit = YES;
}


/**
 使用WebView也可以播放本地视频, 或打开PDF, PPT等文件.
 */
- (void)test2{
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:@"/Users/Morris/Documents/iOS/视频/1.C/01-基础语法/01-计算机和软件开发常识.mp4"]]];
    
}

/**
 WebView拥有一个scrollView的属性, 所以可以为其设置scrollView相关的属性,
 */
- (void)test3{

    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://therub.co.nz/shop/"]]];

    //为WebView设置上边距.
    self.webView.scrollView.contentInset = UIEdgeInsetsMake(50, 0, 0, 0);
}

/**
设置WebView的dataDetectorTypes相关值能够识别网页中的一些特殊字符串, 比如电话号码, 或是网址.
 */
-(void)test4
{
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"免责声明.htm" withExtension:nil];

    //加载网页
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];


    self.webView.dataDetectorTypes = UIDataDetectorTypeAll;
}
@end
