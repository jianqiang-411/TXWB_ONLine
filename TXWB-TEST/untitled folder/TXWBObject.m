//
//  TXWBObject.m
//  TXWB-TEST
//
//  Created by xue on 13-7-5.
//  Copyright (c) 2013年 xue. All rights reserved.
//

#import "TXWBObject.h"
#import "HttpRequestModel.h"
@implementation TXWBObject

- (id)initWithDictionary:(NSDictionary *)dic
{
    if (self = [super init]) {
        
        NSArray *keys = [dic allKeys];
        if ([keys containsObject:@"head"]) {
            self.head = [dic objectForKey:@"head"];
        } else {
            self.head = [dic objectForKey:@"headurl"];
        }
        
        if ([keys containsObject:@"https_head"]) {
            self.https_head = [dic objectForKey:@"https_head"];
        } else {
            self.https_head = [dic objectForKey:@"https_headurl"];
            NSLog(@"%@",_https_head);
        }
        

        self.atCount = [[dic objectForKey:@"count"] integerValue];
        self.timestamp = [NSNumber numberWithUnsignedLong: [[dic objectForKey:@"timestamp"] unsignedLongValue]];
        self.from = [dic objectForKey:@"from"];
        self.fromUrl = [dic objectForKey:@"fromurl"];
        self.wbID = [dic objectForKey:@"id"];
        self.name = [dic objectForKey:@"name"];
        self.nick = [dic objectForKey:@"nick"];
        self.idolnum = [[dic objectForKey:@"idolnum"] integerValue];
        self.openid = [dic objectForKey:@"openid"];
        self.text = [dic objectForKey:@"text"];
        self.arrImgUrl = [dic objectForKey:@"image"];
        self.musicUrl = [dic objectForKey:@"music"];
        self.videoUrl = [dic objectForKey:@"video"];
        
        
        self.dicSource = [dic objectForKey:@"source"];
        if ((NSNull *)_dicSource != [NSNull null]) {
            self.scNick = [_dicSource objectForKey:@"nick"];
            self.scHead = [_dicSource objectForKey:@"head"];
            self.scHttps_head = [_dicSource objectForKey:@"https_head"];
            self.scText = [_dicSource objectForKey:@"text"];
            self.arrSCImgUrl = [_dicSource objectForKey:@"image"];
            self.scMusicUrl = [_dicSource objectForKey:@"music"];
            self.scVideoUrl = [_dicSource objectForKey:@"video"];
   
        }
    }
    return self;
    
}

@end
