//
//  HttpRequestModel.h
//  TXWB-TEST
//
//  Created by xue on 13-7-5.
//  Copyright (c) 2013年 xue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

@interface HttpRequestModel : NSObject 

@property (copy, nonatomic) NSString *accessToken;
@property (copy, nonatomic) NSString *openid;
@property (copy, nonatomic) NSString *client_id; //user's name
@property (copy, nonatomic) NSString *refresh_token;
@property (assign, nonatomic) NSInteger hasnext;

//获取当前用户及所关注用户的最新微博
@property (assign, nonatomic) NSInteger pageflag;
@property (assign, nonatomic) NSInteger pagetime;
@property (assign, nonatomic) NSInteger reqnum;
@property (assign, nonatomic) NSInteger type;
@property (assign, nonatomic) NSInteger contenttype;
@property (assign, nonatomic) NSInteger startindex;


+ (HttpRequestModel *)shareHttpRequestModel;

-(void)getUserInfo;
-(void)getUser_Fanslist;
@end
