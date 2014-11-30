//
//  SRWebView.h
//  DaZhe
//
//  Created by RAY on 14/11/19.
//  Copyright (c) 2014年 麻辣工作室. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NJKWebViewProgress.h"

@interface SRWebView : UIViewController<UIWebViewDelegate, NJKWebViewProgressDelegate>
{
    NJKWebViewProgress *_progressProxy;
    BOOL refreshing;
}
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) NSString *webUrl;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *refreshBtn;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *back;
@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;


@end
