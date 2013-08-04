//
//  TwoVC.h
//  TXWB-TEST
//
//  Created by xue on 13-7-5.
//  Copyright (c) 2013年 xue. All rights reserved.
//




#import <UIKit/UIKit.h>

@interface TwoVC : UIViewController

typedef enum {
    
    RequestTypeOfMentions,     // 获取@当前用户的最新微博
    RequestTypeOfSpecial,      //获取特别收听用户的最新微博
    RequestTypeOfVip,          //获取当前用户所关注的认证用户的最新微博
    RequestTypeOfRecv,         //收件箱
    
}RequestType;

@property (assign, nonatomic) RequestType requestType;

@property (assign, nonatomic) NSInteger pageflag;
@property (assign, nonatomic) NSInteger pagetime;
@property (assign, nonatomic) NSInteger startindex;
@property (assign, nonatomic) NSInteger reqnum;
@property (assign, nonatomic) NSInteger type;
@property (assign, nonatomic) NSInteger contenttype;

@end
