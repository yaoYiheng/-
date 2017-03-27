//
//  YYHWebViewController.m
//  17_03_16_Budejie
//
//  Created by 姚懿恒 on 2017/3/27.
//  Copyright © 2017年 姚懿恒. All rights reserved.
//

#import "YYHWebViewController.h"
#import <WebKit/WebKit.h>

@interface YYHWebViewController ()
@property (weak, nonatomic) IBOutlet UIView *placeHolderView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *forwardButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *refreshButton;
/** <#comments#>*/
@property (nonatomic, weak) WKWebView *webView;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

@end

@implementation YYHWebViewController
#pragma mark -----点击按钮-----
- (IBAction)backClick:(UIBarButtonItem *)sender {
    [self.webView goBack];
}
- (IBAction)forwardClick:(UIBarButtonItem *)sender {
    [self.webView goForward];
}
- (IBAction)refreshClick:(UIBarButtonItem *)sender {
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.webView.frame = self.placeHolderView.bounds;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    //添加webView到placeHolderView
    [self configureWebView];
}

/**
 在该方法中布局子控件的尺寸
 */
- (void)configureWebView{
    WKWebView *webView = [[WKWebView alloc] init];

    _webView = webView;


    NSURLRequest *request = [NSURLRequest requestWithURL:_url];
    [webView loadRequest:request];

    [self.placeHolderView addSubview:webView];


    /*
        使用KVO监听进度, 前进后退, 标题的改变.
     */
    [webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [webView addObserver:self forKeyPath:@"canGoBack" options:NSKeyValueObservingOptionNew context:nil];
    [webView addObserver:self forKeyPath:@"canGoForward" options:NSKeyValueObservingOptionNew context:nil];
    [webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
}

/**
 当监听的属性发生改变时, 就会调用该方法, 可以在该方法中修改
 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{

    self.progressView.progress = self.webView.estimatedProgress;
    self.backButton.enabled = self.webView.canGoBack;
    self.forwardButton.enabled = self.webView.canGoForward;
    self.progressView.hidden = self.webView.estimatedProgress >= 1;
    self.title = self.webView.title;


}

/**
 对象被销毁时, 需要移除观察者.
 */
- (void)dealloc{
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.webView removeObserver:self forKeyPath:@"canGoBack"];
    [self.webView removeObserver:self forKeyPath:@"canGoForward"];
    [self.webView removeObserver:self forKeyPath:@"title"];

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
