//
//  HttpRequestModel.m
//  TXWB-TEST
//
//  Created by xue on 13-7-5.
//  Copyright (c) 2013年 xue. All rights reserved.
//

#import "HttpRequestModel.h"

#import "Define.h"

#import "UserObj.h"
@implementation HttpRequestModel

static HttpRequestModel *httpModel = nil;
+ (HttpRequestModel *)shareHttpRequestModel
{
    @synchronized (self) {
        if (httpModel == nil) {
            httpModel = [[HttpRequestModel alloc] init];
        }
    }
    return httpModel;
}
- (id)init
{
    if (self = [super init]) {
        
        self.accessToken = [[NSString alloc] init];
        self.openid = [[NSString alloc] init];
        self.client_id = [[NSString alloc] init];
        self.hasnext = 0;
    }
    return self;
}

#pragma mark - 获取当前登录用户的个人资料
-(void)getUserInfo
{
    NSURL* url = [NSURL URLWithString:TX_GET_USERINFO];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setPostValue:TX_APP_KEY forKey:@"oauth_consumer_key"];
    
    NSLog(@"_accessToken = %@",_accessToken);
    NSLog(@"_openid = %@",_openid);
    NSLog(@"_client_id = %@",_client_id);
    
    [request setPostValue:_accessToken forKey:@"access_token"];
    [request setPostValue:_openid forKey:@"openid"];
    [request setPostValue:_client_id forKey:@"clientip"];
    [request setPostValue:@"2.a" forKey:@"oauth_version"];
    [request setPostValue:@"all" forKey:@"scope"];
    [request setPostValue:@"json" forKey:@"format"];
    
    [request setCompletionBlock:^{
        NSError *error = nil;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:request.responseData options:kNilOptions error:&error];
        NSLog(@"============JSON=================");
            //NSLog(@"%@====",dic);
        UserObj *userObj = [[UserObj alloc] initWithDictionary:dic];

    }];
    [request startSynchronous];
}




#pragma mark - 获取我的粉丝列表
//@"http://open.t.qq.com/api/friends/user_fanslist?format=json&reqnum=20&startindex=0&name=wbapihelper&fopenid=&install=0&mode=0&oauth_consumer_key=xx&access_token=xx&openid=xx&clientip=xx&oauth_version=2.a&scope=xx"
-(void)getUser_Fanslist
{


    self.reqnum = 20;
    self.startindex = 0;
//    self.contenttype = 0;
    NSString *urlStr = nil;
    urlStr = [NSString stringWithFormat:@"http://open.t.qq.com/api/friends/user_fanslist?format=json&reqnum=%d&startindex=%d&name=wbapihelper&fopenid=&install=0&mode=0&oauth_consumer_key=%@&access_token=%@&openid=%@&clientip=%@&oauth_version=2.a&scope=xx",_reqnum,_startindex,TX_APP_KEY,_accessToken,_openid,_client_id];
    
    NSURL* url = [NSURL URLWithString:urlStr];
    
    ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:url];
    
    [request setCompletionBlock:^{
        NSError *error = nil;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:request.responseData options:kNilOptions error:&error];
        NSLog(@"============JSON=================");
        
    }];
    [request startAsynchronous];
}
@end
