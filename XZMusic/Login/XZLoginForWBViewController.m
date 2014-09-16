//
//  XZLoginForWBViewController.m
//  XZMusic
//
//  Created by xiazer on 14-9-16.
//  Copyright (c) 2014年 xiazer. All rights reserved.
//

#import "XZLoginForWBViewController.h"

@interface XZLoginForWBViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) NSString *appID;
@property (nonatomic, strong) NSString *uri;
@property (nonatomic, weak) id<WBLoginWithControllerDelegate> delegate;

@end

@implementation XZLoginForWBViewController

- (UIWebView *)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        _webView.delegate = self;
    }
    
    return _webView;
}

- (id)initWithAppID:(NSString *)appID redirectURI:(NSString *)uri delegate:(id<WBLoginWithControllerDelegate>)delegate
{
    if (self = [super init]) {
        _appID = appID;
        _uri = uri;
        _delegate = delegate;
    }
    
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitleViewWithString:@"微博登录"];
    
    if (SYSTEM_VERSION_LESS_THAN(@"7.0")) {
        self.view.frame = CGRectMake(0, 0, 320, 480);
    }
    
    [self.view addSubview:self.webView];
    
    NSString *encodedURI = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL, /* allocator */
                                                                                                 (CFStringRef)self.uri,
                                                                                                 NULL, /* charactersToLeaveUnescaped */
                                                                                                 (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                                 kCFStringEncodingUTF8));
    NSString *urlString = [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&scope=all&redirect_uri=%@", self.appID, encodedURI];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
}

#pragma mark - Orientation

- (BOOL)shouldAutorotate
{
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *url = [request.URL absoluteString];
    if ([url hasPrefix:self.uri]) {
        [self.delegate WBLoginWithControllerDidFinishRequestWIthCoode:[url substringFromIndex:[url rangeOfString:@"?code="].location + 6]];
        return NO;
    }
    
    return YES;
}

- (void)leftButtonAction:(id)sender{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
