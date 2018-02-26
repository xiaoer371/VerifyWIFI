//
//  ZTVerifyWIFI.m
//  ZTVerifyWIFIDemo
//
//  Created by XiaoJin on 2018/2/26.
//  Copyright © 2018年 CharlesChwang. All rights reserved.
//

#import "ZTVerifyWIFI.h"
#import <UIKit/UIKit.h>

@interface ZTVerifyWIFI ()<UIWebViewDelegate>

@property (nonatomic, copy) void(^WIFICheckComplection)(BOOL needVerify);
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) NSURL *requestURL;
//是否显示系统弹窗
@property (nonatomic, assign) BOOL showAlert;
@end

@implementation ZTVerifyWIFI

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.verifyURL = [NSURL URLWithString:@"http://captive.apple.com/hotspotdetect.html"];
    }
    return self;
}

- (void)checkWIFIIsAvailable:(void(^)(BOOL needVerify))complection showAlert:(BOOL)showAlert{
    
    _WIFICheckComplection = complection;
    self.showAlert = showAlert;
    NSURLRequest *request = [NSURLRequest requestWithURL:self.verifyURL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:20];
    [self.webView loadRequest:request];
    
}

#pragma mark - UIWebView / UIWebViewDelegate

- (UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectZero];
        _webView.delegate = self;
    }
    return _webView;
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    self.requestURL = webView.request.URL;
    if ([self.requestURL.host containsString:self.verifyURL.host]) {
        if (_WIFICheckComplection) {
            _WIFICheckComplection(NO);
            _WIFICheckComplection = nil;
        }
    }else{
        if (_WIFICheckComplection) {
            _WIFICheckComplection(YES);
            _WIFICheckComplection = nil;
        }
        
        if (self.showAlert) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"WI-FI认证提醒" message:@"检测到当前WI-FI需要认证才能使用，请尝试去认证网络" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"认证", nil];
            [alert show];
        }
    }
    return YES;
}
#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) { // 认证网络
        if ([[UIApplication sharedApplication] canOpenURL:self.requestURL]) {
            [[UIApplication sharedApplication] openURL:self.requestURL];
        }
    }
}
#pragma clang diagnostic pop

@end
