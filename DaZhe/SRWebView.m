//
//  SRWebView.m
//  DaZhe
//
//  Created by RAY on 14/11/19.
//  Copyright (c) 2014年 麻辣工作室. All rights reserved.
//

#import "SRWebView.h"

@interface SRWebView ()

@end

@implementation SRWebView
@synthesize webView=_webView;
@synthesize webUrl=_webUrl;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _progressProxy = [[NJKWebViewProgress alloc] init];
    _webView.delegate = _progressProxy;
    _progressProxy.webViewProxyDelegate = self;
    _progressProxy.progressDelegate = self;
    refreshing=NO;
    [self loatWeb:_webUrl];
    self.refreshBtn.image=[UIImage imageNamed:@"close"];
}

-(void)viewWillLayoutSubviews{
    [self.navBar setFrame:CGRectMake(0, 0, 320, 64)];
}

- (void)loatWeb:(NSString *)url{
    refreshing=YES;
    NSURLRequest *req = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    [_webView loadRequest:req];
    self.refreshBtn.image=[UIImage imageNamed:@"close"];
}

#pragma mark - NJKWebViewProgressDelegate
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    if (progress == 0.0) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        _progressView.progress = 0;
        [UIView animateWithDuration:0.27 animations:^{
            _progressView.alpha = 1.0;
        }];
    }
    if (progress == 1.0) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [UIView animateWithDuration:0.27 delay:progress - _progressView.progress options:0 animations:^{
            _progressView.alpha = 0.0;
        } completion:nil];
        refreshing=NO;
        self.refreshBtn.image=[UIImage imageNamed:@"refresh"];
    }
    
    [_progressView setProgress:progress animated:NO];
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)refresh:(id)sender {
    if (refreshing){
        [_webView stopLoading];
        refreshing=NO;
        self.refreshBtn.image=[UIImage imageNamed:@"refresh"];
    }
    else
        [self loatWeb:_webUrl];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
