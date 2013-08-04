//
//  OauthVC.m
//  TXWB-TEST
//
//  Created by xue on 13-7-5.
//  Copyright (c) 2013年 xue. All rights reserved.
//

#import "OauthVC.h"
#import "Define.h"
#import "HttpRequestModel.h"
@interface OauthVC () <UIWebViewDelegate>
@property (strong, nonatomic) UIWebView *oauthWebView;
@end

@implementation OauthVC

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
    self.oauthWebView = [[UIWebView alloc] initWithFrame:self.view.frame];
    _oauthWebView.delegate = self;
    [self.view addSubview:_oauthWebView];
    
    NSString *strUrl  = nil;
    strUrl = @"https://open.t.qq.com/cgi-bin/oauth2/authorize?client_id=801382074&response_type=token&redirect_uri=http://www.code4app.com/";
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:strUrl]];
    [_oauthWebView loadRequest:request];
    
}

#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSURL *url = [request URL];

    
    
    NSString *strClient_ip = nil;
    NSString *strToken = nil;
    NSString *strOpendid = nil;
    NSString *strRefresh_token = nil;


    NSRange range = [[url absoluteString] rangeOfString:@"openkey"];
    if (range.location != NSNotFound) {
        
        
        NSArray *arrCode = [[url absoluteString] componentsSeparatedByString:@"="];
        
        NSString *strCode = [arrCode objectAtIndex:1];
        NSArray *arrtoken = [strCode componentsSeparatedByString:@"&"];
        //10e5e1dca8dcf70b7817921f25fd880b
        strToken = [arrtoken objectAtIndex:0];
        
        //A235733D2766038B76CECF5E5B980D85
        NSArray *arrOpendid = [[arrCode objectAtIndex:3] componentsSeparatedByString:@"&"];
        strOpendid = [arrOpendid objectAtIndex:0];
        
        NSArray *arrrefresh_token = [[arrCode objectAtIndex:5] componentsSeparatedByString:@"&"];
        strRefresh_token = [arrrefresh_token objectAtIndex:0];
        //NSLog(@"strRefresh_token==%@",strRefresh_token);
        //openkey=DF873F76AB2CFFEDC590E7FD100F5F64
        //name baojianqia5572
        strClient_ip = [[[arrCode objectAtIndex:7] componentsSeparatedByString:@"&"]objectAtIndex:0];


        HttpRequestModel *httpRequest = [HttpRequestModel shareHttpRequestModel];
        httpRequest.accessToken = strToken;
        httpRequest.openid = strOpendid;
        httpRequest.client_id = strClient_ip;
        httpRequest.refresh_token = strRefresh_token;
        

        [httpRequest getUserInfo];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"changeVC" object:nil];
    }
    
    
    return YES;
}



@end
