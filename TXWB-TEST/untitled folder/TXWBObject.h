//
//  TXWBObject.h
//  TXWB-TEST
//
//  Created by xue on 13-7-5.
//  Copyright (c) 2013年 xue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TXWBObject : NSObject
@property (copy, nonatomic) NSString *head;//头像url
@property (copy, nonatomic) NSString *https_head;//头像url
@property (assign, nonatomic) NSInteger idolnum;//关注的人数
@property (assign, nonatomic) NSInteger atCount;//收听的人数
@property (retain, nonatomic) NSNumber *timestamp;
@property (copy, nonatomic) NSString *from;//
@property (copy, nonatomic) NSString *fromUrl;//
@property (copy, nonatomic) NSString *wbID;
@property (copy, nonatomic) NSString *name;//用户帐户名
@property (copy, nonatomic) NSString *nick;//用户帐户名
@property (copy, nonatomic) NSString *openid;
@property (copy, nonatomic) NSString *text;
@property (retain, nonatomic) NSMutableArray *arrImgUrl;
@property (copy, nonatomic) NSString *musicUrl;
@property (copy, nonatomic) NSString *videoUrl;

//cell 内容 source
@property (retain, nonatomic) NSDictionary *dicSource;
@property (copy, nonatomic) NSString *scNick;//用户帐户名
@property (copy, nonatomic) NSString *scHead;//头像url
@property (copy, nonatomic) NSString *scHttps_head;//头像url
@property (copy, nonatomic) NSString *scText;
@property (retain, nonatomic) NSMutableArray *arrSCImgUrl;
@property (copy, nonatomic) NSString *scMusicUrl;
@property (copy, nonatomic) NSString *scVideoUrl;

- (id)initWithDictionary:(NSDictionary *)dic;
@end
